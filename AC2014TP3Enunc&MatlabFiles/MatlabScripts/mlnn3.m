function [filename, performance, network_outputs, binary_results, results_data] = mlnn3( net_type, data_id, train_percentage, num_neurons, num_neurons_step, classification_method, num_characteristics )
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

    filename = strcat(imgdir, net_type, '/', data_id, '/', num2str(num_neurons), '_', num2str(num_neurons_step), '_', num2str(train_percentage), '_', classification_method, '_', num2str(num_characteristics));

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
    
    
    % train and test
    net = newrb(train_set, target, 0, 1, num_neurons, num_neurons_step);
    network_outputs = sim(net, test_set);
    
    
    %% calculate performance
    performance = perform(net, test_target, network_outputs);


    %% apply classification method
    [binary_results, results_data] = classify_results(classification_method, network_outputs, test_target);
    
    
    
end