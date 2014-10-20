clc;
clear all;

data = load('92202.mat');
target = data.Trg;
input_set = data.FeatVectSel;

[train_set,target] = simplefit_dataset;

mlnn(5, target, 'trainlm', train_set, train_set, 'lolitos');
