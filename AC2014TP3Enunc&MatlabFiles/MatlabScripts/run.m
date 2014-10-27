
%clc;
clear all;
imgdir = 'images/simulations/';
data_id = '92202';
data_file = '112502';
data_file2 = '63502';
data = load(strcat(data_id, '.mat'));
target = data.Trg;
input_set = data.FeatVectSel;

% quando deixar de ser perguicoso tiro este debug e tento meter o
% original a dar. also, dividir o dataset em training e testing com varias
% percentagens
%[train_set, target] = simplefit_dataset; %matlab default

[train,train_target,test,test_target] = prep_dataset(input_set,target);
train_set = train';
target = train_target';

disp('press any key to continue');
pause();

test_set = train_set;

num_hidden_layers = 5;
train_func = 'trainlm';
train_size = size(train_set);
test_size = size(test_set);
train_size = train_size(1)*train_size(2);
test_size = test_size(1)*test_size(2);

%filename = strcat(imgdir, data_id, '_', num2str(num_hidden_layers), '_', train_func, '_', num2str(train_size), '_', num2str(test_size));
%mlnn(num_hidden_layers, target, train_func, train_set, test_set, filename);

