
clc;
clear all;
imgdir = 'images/simulations/';
data_id = '92202';
data_id2 = '112502';
data_id3 = '63502';
data = load(strcat('dataset/',data_id, '.mat'));
disp('Testing:');
disp(strcat('dataset/',data_id, '.mat'));

target = data.Trg;
input_set = data.FeatVectSel;


trainPrecentage = 0.7;
%divide the data in the train and test dataset
[train_set,target,test_set,test_target] = prep_dataset(input_set,target,trainPrecentage);

train_set = train_set';
target = target';
test_set = test_set';

num_hidden_layers = 5;
train_func = 'trainlm';
train_size = size(train_set);
test_size = size(test_set);
train_size = train_size(1)*train_size(2);
test_size = test_size(1)*test_size(2);

%Se quiseres verificar se funciona/fazer isto, avisa
:)
%filename = strcat(imgdir, data_id, '_', num2str(num_hidden_layers), '_', train_func, '_', num2str(train_size), '_', num2str(test_size));
%mlnn(num_hidden_layers, target, train_func, train_set, test_set, filename);

