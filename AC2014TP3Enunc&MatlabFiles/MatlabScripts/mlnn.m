function [performance, network_outputs] = mlnn( net_type, hidden_layers, target, train_function, train_set, test_set, test_target, classification_method, num_characteristics, filename)
%% multi-layer neural network


    %% DISCLAIMER: é bem provavel que isto esteja mal visto que foi feito por mim
    % - ACL

    % filter the primary components based on the number of desired characteristics chosen by the user
    if (num_characteristics < 1) || (num_characteristics > 29)
        [~, reduced_data] = princomp(train_set);
    else
        reduced_data = reduce_data_set(train_set, target, num_characteristics);
    end
    
    %save('reduced_data.mat','reduced_data');
    train_set = reduced_data; % the reduced data is our new training data
    test_set = reduce_data_set(test_set, test_target, num_characteristics);

    %% end of disclaimer
    % - ACL
    
    if strcmp(net_type, 'feedforwardnet') == 1
        net = feedforwardnet(hidden_layers, train_function);
    elseif strcmp(net_type, 'fitnet') == 1
        net = fitnet(hidden_layers, train_function);
    elseif strcmp(net_type, 'cascadeforwardnet') == 1
        net = cascadeforwardnet(hidden_layers, train_function);
    end

    % disable visual output
    net.trainParam.showWindow = false;
    
    if strcmp(version('-release'),'2014a') == 1 && gpuDeviceCount == 1
        net = train(net, train_set, target, 'useGPU', 'yes');
        network_outputs = net(test_set, 'useGPU', 'yes');
    else
        net = train(net, train_set, target);
        network_outputs = net(test_set);
    end
    
    %% apply classification method
    %% TODO: %%
    if strcmp(classification_method, '10 consecutive ictals') == 1
    elseif strcmp(classification_method, 'at least 5 of the last 10 are ictals') == 1
    elseif strcmp(classification_method, 'single point') == 1
    end
    
    %% calculate performance
    performance = perform(net, test_target, network_outputs);
                
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
    
    %plot and print classification
    %{
    figure(2);
    plot(network_outputs(1,:)','g');
    hold on;
    plot(test_target(1,:)','b');
    hold off;
    print(2, '-dpng', strcat(filename, '__netoutput1'));
    %}
    
    %{
    figure(3);
    plot(network_outputs(2,:)','r');
    hold on;
    plot(test_target(2,:)','k');
    hold off;
    print(3, '-dpng', strcat(filename, '__netoutput2'));
    %}

end