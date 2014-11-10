
choice = questdlg('Run all simulations?', 'Run all simulations?','Yes','No', 'No');
switch choice
    case 'No'

        GUI;
        
        %{
        gui_handle = hgload('GUI.fig');
        
        data_id = guidata(gui_handle.data_set_popupmenu);
        train_percentage = guidata(gui_handle.training_percentage_edit);
        train_func = guidata(gui_handle.learning_function_popupmenu);
        num_hidden_layers = guidata(gui_handle.hidden_layers_edit);
        hidden_layers_size = guidata(gui_handle.hidden_layers_size_edit);
        hidden_layers = ones(1, num_hidden_layers) * hidden_layers_size;
     
        run_one(data_id, train_percentage, train_func, hidden_layers);
        %}
        
        
    otherwise
        run_all;

end

%% clean environment
clc;
close all;
clear all;

