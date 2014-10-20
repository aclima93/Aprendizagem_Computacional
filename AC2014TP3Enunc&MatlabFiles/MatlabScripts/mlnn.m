function mlnn( num_neurons, target, train_function, train_set, test_set, filename)

net = feedforwardnet(num_neurons, train_function);
net = train(net, train_set, target);
network_outputs = net(test_set);
plot(network_outputs)
print(1, '-dpng', filename);
close Figure 1;

jframe = view(net);

%# create it in a MATLAB figure
hFig = figure('Menubar','none', 'Position',[100 100 565 166]);
jpanel = get(jframe,'ContentPane');
[~,h] = javacomponent(jpanel);
set(h, 'units','normalized', 'position',[0 0 1 1]);

%# close java window
jframe.setVisible(false);
jframe.dispose();

%# print to file
set(hFig, 'PaperPositionMode', 'auto');
saveas(hFig, 'out.png');

%# close figure
close(hFig);

%performance = perform(net, targets, network_outputs)

close all;

end