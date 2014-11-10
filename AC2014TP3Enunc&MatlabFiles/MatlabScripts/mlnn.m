function performance = mlnn( hidden_layers, target, train_function, train_set, test_set,test_target, filename)
%% multi-layer neural network


    net = feedforwardnet(hidden_layers, train_function);
    net = train(net, train_set, target, 'useGPU', 'yes');
    network_outputs = net(test_set, 'useGPU', 'yes');
    
    %plot and print classification
    figure(1);
    plot(network_outputs(1,:)','g');
    hold on;
    plot(test_target(1,:)','b');
    hold off;
    figure(2);
    plot(network_outputs(2,:)','r');
    hold on;
    plot(test_target(2,:)','k');
    hold off;
    print(1, '-dpng', strcat(filename, '__1'));
    print(2, '-dpng', strcat(filename, '__2'));
    %close Figure 1;

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
    saveas(hFig, strcat(filename, '__netconfig'), 'png');
    close(hFig);

    performance = perform(net, targets, network_outputs);

    close all;

end