function [filename, performance, network_outputs, binary_results, results_data] = mlnn2( showUI, net_type, data_id, train_percentage, train_func, hidden_layers, classification_method, num_characteristics, delays )
%% multi-layer neural network

    imgdir = 'images/simulations/';
    data = load(strcat('dataset/', data_id, '.mat'));

    target = data.Trg;
    input_set = data.FeatVectSel;
    
    %divide the data in the train and test dataset
    [train_set, target, test_set, test_target] = prep_dataset(input_set, target, train_percentage);

    train_set = train_set';
    target = target';
    test_set = test_set';
    test_target = test_target';

    filename = strcat(imgdir, net_type, '/', data_id, '/', train_func, '/', num2str(length(delays)),'/', num2str(length(hidden_layers)), '_', num2str(hidden_layers(1)), '_', num2str(train_percentage), '_', classification_method, '_', num2str(num_characteristics));


    % filter the primary components based on the number of desired characteristics chosen by the user
    if (num_characteristics < 1) || (num_characteristics > 29)
        %[~, reduced_data] = princomp(train_set);
        reduced_data = train_set;
    else
        reduced_data = reduce_data_set(train_set, target, num_characteristics);
        test_set = reduce_data_set(test_set, test_target, num_characteristics);

    end
    
    %save('reduced_data.mat','reduced_data');
    train_set = reduced_data; % the reduced data is our new training data
    
    
    net = layrecnet(delays, hidden_layers, train_func);
    
        % disable visual output
    if showUI == 0
        net.trainParam.showWindow = false;
    end

    if strcmp(version('-release'),'2014a') == 1 && gpuDeviceCount == 1
        [net, ~] = train(net, train_set, target, 'useGPU', 'yes');
        network_outputs = net(test_set, 'useGPU', 'yes');
    else
        [net, ~] = train(net, train_set, target);
        network_outputs = net(test_set);
    end

    %% calculate performance
    performance = perform(net, test_target, network_outputs);


    %% apply classification method
    [binary_results, results_data] = classify_results(classification_method, network_outputs, test_target);

    
end