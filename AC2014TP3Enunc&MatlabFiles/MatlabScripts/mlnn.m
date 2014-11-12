function [performance, network_outputs] = mlnn( net_type, hidden_layers, target, train_function, train_set, test_set, test_target, classification_method, num_characteristics, filename)
%% multi-layer neural network


    %% DISCLAIMER: é bem provavel que isto esteja mal visto que foi feito por mim
    % - ACL

    % filter the primary components based on the number of desired characteristics chosen by the user
    if (num_characteristics < 1) || (num_characteristics > 29)
        
        %figure(1);
        [primary_components, reduced_data] = princomp(train_set);
        %biplot(primary_components(:,1:2), 'Scores', reduced_data(:,1:2), 'VarLabels', {'X1' 'X2' 'X3' 'X4'});
        %print(1, '-dpng', strcat(filename, '__correlations'));
        
    else
        
        % Compute sample correlation and p-values.
        % Find significant correlations, don't count the target
        % 1 and -1 are the most important, 0 is worthless
        [r,p] = corrcoef(horzcat(train_set', target(1,:)'));
        [x,~] = size(p);
        indexed_corr = vertcat(abs(r(length(p),1:(x-1))), 1:(x-1));
        reduced_correlations = cell(length(indexed_corr), 1);
        
        for i = 1:length(indexed_corr)
            reduced_correlations{i} = indexed_corr(1,i);
        end
        
        % sort by correlation but maintain index information and filter the best X elements
        temp = [reduced_correlations{:}];
        [~, ind] = sort( temp(1,:), 'descend');
        best_rc_ind = ind(1:num_characteristics);
        reduced_data = train_set(best_rc_ind, :);
        
    end
    
    %save('reduced_data.mat','reduced_data');
    train_set = reduced_data; % the reduced data is our new training data

    %% end of disclaimer
    % - ACL
    
    if strcmp(net_type, 'feedforwardnet') == 1
        net = feedforwardnet(hidden_layers, train_function);
    else
        net = feedforwardnet(hidden_layers, train_function);
    end

    save('test_set.mat','test_set');
    
    if strcmp(version('-release'),'2014a') == 1 && gpuDeviceCount == 1
        net = train(net, train_set, target, 'useGPU', 'yes');
        network_outputs = net(test_set, 'useGPU', 'yes');
    else
        net = train(net, train_set, target);
        network_outputs = net(test_set);
    end
    
    %% apply classification method
    if classification_method == 1
    elseif classification_method == 2
    elseif classification_method == 3
    else
    end
    
    %% calculate performance
    performance = perform(net, target, network_outputs);
        
    
    %% data plots
    %plot and print classification
    figure(2);
    plot(network_outputs(1,:)','g');
    hold on;
    plot(test_target(1,:)','b');
    hold off;
    figure(3);
    plot(network_outputs(2,:)','r');
    hold on;
    plot(test_target(2,:)','k');
    hold off;
    print(2, '-dpng', strcat(filename, '__1'));
    print(3, '-dpng', strcat(filename, '__2'));

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

end