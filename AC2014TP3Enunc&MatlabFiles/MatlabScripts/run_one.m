function [filename, performance, network_ouputs] = run_one( net_type, data_id, train_percentage, train_func, hidden_layers, classification_method, num_charateristics )

    imgdir = 'images/simulations/';
    data = load(strcat('dataset/', data_id, '.mat'));
    disp(strcat('dataset/', data_id, '.mat'));

    target = data.Trg;
    input_set = data.FeatVectSel;

    
    
    %divide the data in the train and test dataset
    [train_set, target, test_set, test_target] = prep_dataset(input_set, target, train_percentage);

    train_set = train_set';
    target = target';
    test_set = test_set';
    test_target = test_target';

    train_size = size(train_set);
    test_size = size(test_set);
    train_size = train_size(1)*train_size(2);
    test_size = test_size(1)*test_size(2);

    filename = strcat(imgdir, data_id, '_', num2str(length(hidden_layers)), '_', num2str(hidden_layers(1)), '_', train_func, '_', num2str(train_size), '_', num2str(test_size), '_', classification_method, '_', num_charateristics);
    [performance, network_ouputs] = mlnn(net_type, hidden_layers, target, train_func, train_set, test_set,test_target, classification_method, num_charateristics, filename);

end

