function [performance, network_outputs, binary_results, results_data] = mlnn( showUI, net_type, hidden_layers, target, train_function, train_set, test_set, test_target, classification_method, num_characteristics, filename)
%% multi-layer neural network


    %% DISCLAIMER: � bem provavel que isto esteja mal visto que foi feito por mim
    % - ACL

    % filter the primary components based on the number of desired characteristics chosen by the user
    if (num_characteristics < 1) || (num_characteristics > 29)
        %[~, reduced_data] = princomp(train_set);
        reduced_data = train_set;
        test_set = test_set;
    else
        reduced_data = reduce_data_set(train_set, target, num_characteristics);
        test_set = reduce_data_set(test_set, test_target, num_characteristics);

    end
    
    %save('reduced_data.mat','reduced_data');
    train_set = reduced_data; % the reduced data is our new training data
    
    %% end of disclaimer
    % - ACL
    
    if strcmp(net_type, 'Feed Forward Net') == 1
        net = feedforwardnet(hidden_layers, train_function);
    elseif strcmp(net_type, 'Fitting Net') == 1
        net = fitnet(hidden_layers, train_function);
    elseif strcmp(net_type, 'Cascade Forward Net') == 1
        net = cascadeforwardnet(hidden_layers, train_function);
    elseif strcmp(net_type, 'Pattern Recognition Net') == 1
        net = patternnet(hidden_layers, train_function);
    end

    % disable visual output
    if showUI == 0
        net.trainParam.showWindow = false;
    end
    
    if strcmp(version('-release'),'2014a') == 1 && gpuDeviceCount == 1
        [net, tr] = train(net, train_set, target, 'useGPU', 'yes');
        network_outputs = net(test_set, 'useGPU', 'yes');
    else
        [net, tr] = train(net, train_set, target);
        network_outputs = net(test_set);
    end
    
    %% calculate performance
    performance = perform(net, test_target, network_outputs);
    
    
    %% apply classification method
    [binary_results, results_data] = classify_results(classification_method, network_outputs, test_target);
                  
    %{
    %create it in a MATLAB figure
    jframe = view(net);
    hFig = figure('Menubar','none', 'Position',[100 100 565 166]);
    jpanel = get(jframe,'ContentPane');
    [~,h] = javacomponent(jpanel);
    set(h, 'units','normalized', 'position',[0 0 1 1]);

    %close java window
    jframe.setVisible(false);
    jframe.dispose();

    %print to file
    set(hFig, 'PaperPositionMode', 'auto');
    saveas(hFig, strcat(filename, '__netconfig'), 'png');
    close(hFig);
    %}
    
    %plot and print data
    %{
    figure(1);
    plottrainstate(tr);
    print(1, '-dpng', strcat(filename, '__plottrainstate'));
    %}
    
    %{
    figure(2);
    plotperform(tr)
    print(2, '-dpng', strcat(filename, '__plotperform'));
    %}
    
end