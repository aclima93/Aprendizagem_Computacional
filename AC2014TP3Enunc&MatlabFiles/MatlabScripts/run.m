
net_types = {'feedforwardnet'};
data_ids = {'92202'}; %{'92202', '112502', '63502'};
train_funcs = {'trainlm'}; %{'trainlm', 'traingd', 'traincgb', 'trainbfg', 'trainscg', 'traingdm'};
train_percentages = 0.7; %[0.7, 0.725, 0.675, 0.75, 0.65, 0.8, 0.6, 0.85, 0.55];
hidden_layers = [log2(29)]; %[20, 20, 20, 20, 20];
characteristics = [0, 29]; % all or only primary components
classifications = 1:3; % 1-1, 10, 5/10

save('dataset/net_types.mat','net_types');
save('dataset/data_ids.mat','data_ids');
save('dataset/train_funcs.mat','train_funcs');
save('dataset/train_percentages.mat','train_percentages');
save('dataset/hidden_layers.mat','hidden_layers');
save('dataset/characteristics.mat', 'characteristics');
save('dataset/classifications.mat', 'classifications');

choice = questdlg('Run all simulations?', 'Run all simulations?','Yes','No', 'No');
switch choice
    case 'No'
        GUI;
             
    otherwise
        run_all;
        

end

%% clean environment
clc;
close all;
clear all;

