%% Batch run simulations for 'Radial Basis Function Simulations


load('dataset/data_ids.mat', 'data_ids');
load('dataset/train_percentages.mat', 'train_percentages');
load('dataset/characteristics.mat', 'characteristics');
load('dataset/classifications.mat', 'classifications');


net_types = {'Radial Basis Function'};
num_neurons = characteristics;
repetitions = 1;


len_types = length(net_types);
len_ids = length(data_ids);
len_percs = length(train_percentages);
len_charact = length(characteristics);
len_class = length(classifications);
len_num_neurons = len_charact;
len_num_neurons_step = 4; % because we use [1, 2, ceil(characteristics(m)/2), characteristics(m)];
                          % adding one neuron at a time, then 2, then half the total, then all in one go

%total_num_neurons_steps = cumsum(num_neurons);
%total_num_neurons_steps = total_num_neurons_steps(len_num_neurons);

num_cases = len_types * len_ids * len_num_neurons * len_percs * len_num_neurons_step * len_charact * len_class * repetitions;
results = cell(num_cases, 5);
counter = 1;

h = waitbar(0, 'Initializing waitbar...');
showUI = 0;

for n = 1:len_types
    for i = 1:len_ids
        for j = 1:len_percs
            for k = 1:len_num_neurons
                for l = 1:len_class
                    for m = 1:len_charact
                        
                        num_neurons_step = [1, 2, ceil(characteristics(m)/2), characteristics(m)];
                        
                        for o = 1:len_num_neurons_step
                            
                            for r = 1:repetitions
                                
                                perc = (counter*100)/num_cases;
                                waitbar(perc/100, h, sprintf('Third batch of tests: %.3f%% - %d / %d', perc, counter, num_cases));
                                [filename, performance, network_outputs, binary_results, results_data] = mlnn3(net_types{n}, data_ids{i}, train_percentages(j), num_neurons(k), num_neurons_step(o), classifications{l}, characteristics(m));
                                results(counter, 1) = {filename};
                                results(counter, 2) = {performance};
                                results(counter, 3) = {network_outputs};
                                results(counter, 4) = {binary_results};
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

save('dataset/results3.mat', 'results');


