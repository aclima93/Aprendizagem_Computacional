
net_types = {'Feed Forward Net', 'Fitting Net', 'Cascade Forward Net', 'Pattern Recognition Net'};
data_ids = {'92202', '63502'};
n_char = 29;
train_funcs = {'trainlm', 'traingd'}%, 'trainbfg', 'trainrp'};
train_percentages = [0.7, 0.75, 0.65];
hidden_layers = {[ceil(log2(n_char))], [n_char], [n_char, n_char], [ceil(log2(n_char)), ceil(log2(n_char))]};
characteristics = [n_char, ceil(n_char/2), 0]; % all, half, primary components
classifications = {'10 consecutive ictals', 'at least 5 of the last 10 are ictals', 'single point'};
repetitions = 3;


save('dataset/net_types.mat','net_types');
save('dataset/data_ids.mat','data_ids');
save('dataset/train_funcs.mat','train_funcs');
save('dataset/train_percentages.mat','train_percentages');
save('dataset/hidden_layers.mat','hidden_layers');
save('dataset/characteristics.mat', 'characteristics');
save('dataset/classifications.mat', 'classifications');
save('dataset/repetitions.mat', 'repetitions');

choice = questdlg('Run all simulations?', 'Run all simulations?','Yes','No', 'No');
switch choice
    case 'No'
        while 1 == 1
            GUI;
        end
             
    otherwise
        run_all;
        
end

%% clean environment
clc;
close all;
clear all;

disp('Finished.');

