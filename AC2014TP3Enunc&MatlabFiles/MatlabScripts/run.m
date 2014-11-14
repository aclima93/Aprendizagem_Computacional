
net_types = {'feedforwardnet', 'fitnet', 'cascadeforwardnet'};
data_ids = {'92202', '63502'};
train_funcs = {'trainlm', 'traingd', 'trainbfg'}; %{'trainlm', 'trainbr', 'traingd', 'traincgb', 'trainbfg', 'trainscg', 'traingdm'};
train_percentages = [0.7, 0.725, 0.75, 0.675, 0.65];
hidden_layers = {[ceil(log2(29))], [29], [29, 29]}; %[20, 20, 20, 20, 20];
characteristics = [29, 15, 0]; % half, all or only primary components
classifications = {'10 consecutive ictals', 'at least 5 of the last 10 are ictals', 'single point'};
repetitions = 1;


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

