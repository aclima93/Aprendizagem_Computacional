%% Batch run simulations for everything

load('dataset/net_types.mat','net_types');
load('dataset/data_ids.mat', 'data_ids');
load('dataset/train_funcs.mat', 'train_funcs');
load('dataset/train_percentages.mat', 'train_percentages');
load('dataset/hidden_layers.mat', 'hidden_layers');
load('dataset/characteristics.mat', 'characteristics');
load('dataset/classifications.mat', 'classifications');
load('dataset/repetitions.mat', 'repetitions');


len_types = length(net_types);
len_ids = length(data_ids);
len_funcs = length(train_funcs);
len_percs = length(train_percentages);
len_charact = length(characteristics);
len_class = length(classifications);
len_hidden_layers = length(hidden_layers);
num_cases = len_types * len_ids * len_funcs * len_percs * len_hidden_layers * len_charact * len_class * repetitions;
results = cell(num_cases, 5);
counter = 10;

h = waitbar(0, 'Initializing waitbar...');

for n = 1:len_types
    for i = 1:len_ids
        for j = 1:len_percs
            for k = 1:len_funcs
                for l = 1:len_class
                    for m = 1:len_charact
                        for o = 1:len_hidden_layers
                            
                            for r = 1:repetitions
                                
                                perc = (counter*100)/num_cases;
                                waitbar(perc/100, h, sprintf('%.3f%% - %d / %d', perc, counter, num_cases));
                                [filename, performance, network_outputs, binary_resultss, results_data] = run_one(net_types{n}, data_ids{i}, train_percentages(j), train_funcs{k}, hidden_layers{o}, classifications{l}, characteristics(m));
                                results(counter, 1) = {filename};
                                results(counter, 2) = {performance};
                                results(counter, 3) = {network_outputs};
                                results(counter, 4) = {binary_resultss};
                                results(counter, 5) = {results_data};
                                counter = counter + 1;
                                close all;
                                
                            end
                            
                        end
                    end
                end
            end
        end
    end
end

close(h);

save('dataset/results.mat', 'results');

analyse_results;


