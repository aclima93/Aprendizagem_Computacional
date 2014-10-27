function mlnn( num_hidden_layers, target, train_function, train_set, test_set, filename)

net = feedforwardnet(num_hidden_layers, train_function);
net = train(net, train_set, target);

%plot and print classification
network_outputs = net(test_set);
plot(network_outputs)
print(1, '-dpng', strcat(filename, '__1'));
close Figure 1;

%create it in a MATLAB figure
jframe = view(net);
hFig = figure('Menubar','none', 'Position',[100 100 565 166]);
jpanel = get(jframe,'ContentPane');
[~,h] = javacomponent(jpanel);
set(h, 'units','normalized', 'position',[0 0 1 1]);

%close java window
jframe.setVisible(false);
jframe.dispose();

%print to file
set(hFig, 'PaperPositionMode', 'auto');
saveas(hFig, strcat(filename, '__2'), 'png');
close(hFig);

%performance = perform(net, targets, network_outputs)

close all;

end