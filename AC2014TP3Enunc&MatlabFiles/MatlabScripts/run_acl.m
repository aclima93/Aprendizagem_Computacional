
clc;
clear all;

imgdir = 'images/simulations/';
data_id = '92202';
data = load(strcat(data_id, '.mat'));
target = data.Trg;
input_set = data.FeatVectSel;

% quandooo deixar de ser perguiçoso tiro este debug e tento emter o
% original a dar. also, dividir o dataset em training e testing com várias
% percentagens
[train_set, target] = simplefit_dataset;
test_set = train_set;

num_neurons = 5;
train_func = 'trainlm';
train_size = size(train_set);
test_size = size(test_set);
train_size = train_size(1)*train_size(2);
test_size = test_size(1)*test_size(2);

filename = strcat(imgdir, data_id, '_', num2str(num_neurons), '_', train_func, '_', num2str(train_size), '_', num2str(test_size));
mlnn(num_neurons, target, train_func, train_set, test_set, filename);

