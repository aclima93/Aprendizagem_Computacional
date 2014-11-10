%% Batch run simulations for everything

data_ids = {'92202', '112502', '63502'};
train_funcs = {'trainlm'}; %{'trainlm', 'traingd', 'traincgb', 'trainbfg', 'trainscg', 'traingdm'};
train_percentages = 0.7; %[0.7, 0.725, 0.675, 0.75, 0.65, 0.8, 0.6, 0.85, 0.55];
hidden_layers = [20]; %[20, 20, 20, 20];

len_ids = length(data_ids);
len_funcs = length(train_funcs);
len_percs = length(train_percentages);
num_cases = len_ids*len_funcs*len_percs*length(hidden_layers);
result = cell(num_cases);
counter = 1;

h = waitbar(0,'Initializing waitbar...');

for i = len_ids
    for j = len_percs
        for k = len_funcs

            perc = (counter*100)/num_cases; 
            waitbar(perc/100, h, sprintf('%d%% along...', perc))
            [result(counter,1), result(counter,2)] = run_one(data_ids{i}, train_percentages(j), train_funcs{k}, hidden_layers);
            counter = counter + 1;
        end
    end
end

close(h);
%TODO: use the results gathered?


