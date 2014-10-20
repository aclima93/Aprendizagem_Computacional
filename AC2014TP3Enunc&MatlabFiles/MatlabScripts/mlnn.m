function mlnn( num_neurons, targets, train_function, train_set, test_set, filename)

%[train_set,targets] = simplefit_dataset;
net = feedforwardnet(num_neurons, train_function);
net = train(net, train_set, targets);
network_outputs = net(test_set);
imwrite(plot(network_outputs), filename);
%performance = perform(net, targets, network_outputs)

close all;

end