function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 11-Nov-2014 13:54:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)


%load data
load('dataset/data_ids.mat', 'data_ids');
load('dataset/train_funcs.mat', 'train_funcs');
load('dataset/train_percentages.mat', 'train_percentages');
load('dataset/hidden_layers.mat', 'hidden_layers');


% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using GUI.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on button press in run_simulation_pushbutton.
function run_simulation_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to run_simulation_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    %gui_handle = hgload('GUI.fig');

    data_id = handles.data_set_popupmenu;
    train_percentage = handles.training_percentage_edit;
    train_func = handles.learning_function_popupmenu;
    num_hidden_layers = handles.hidden_layers_edit;
    hidden_layers_size = handles.hidden_layers_size_edit;
    hidden_layers = ones(1, num_hidden_layers) * hidden_layers_size;

    % get(handles.popupmenu1, 'Value')
    
    run_one(data_id, train_percentage, train_func, hidden_layers);



function output_layer_size_edit_Callback(hObject, eventdata, handles)
% hObject    handle to output_layer_size_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_layer_size_edit as text
%        str2double(get(hObject,'String')) returns contents of output_layer_size_edit as a double


% --- Executes during object creation, after setting all properties.
function output_layer_size_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_layer_size_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in data_set_popupmenu.
function data_set_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to data_set_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns data_set_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from data_set_popupmenu


% --- Executes during object creation, after setting all properties.
function data_set_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_set_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function training_percentage_edit_Callback(hObject, eventdata, handles)
% hObject    handle to training_percentage_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of training_percentage_edit as text
%        str2double(get(hObject,'String')) returns contents of training_percentage_edit as a double


% --- Executes during object creation, after setting all properties.
function training_percentage_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to training_percentage_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function characteristics_edit_Callback(hObject, eventdata, handles)
% hObject    handle to characteristics_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of characteristics_edit as text
%        str2double(get(hObject,'String')) returns contents of characteristics_edit as a double


% --- Executes during object creation, after setting all properties.
function characteristics_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to characteristics_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hidden_layers_edit_Callback(hObject, eventdata, handles)
% hObject    handle to hidden_layers_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hidden_layers_edit as text
%        str2double(get(hObject,'String')) returns contents of hidden_layers_edit as a double


% --- Executes during object creation, after setting all properties.
function hidden_layers_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hidden_layers_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hidden_layers_size_edit_Callback(hObject, eventdata, handles)
% hObject    handle to hidden_layers_size_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hidden_layers_size_edit as text
%        str2double(get(hObject,'String')) returns contents of hidden_layers_size_edit as a double


% --- Executes during object creation, after setting all properties.
function hidden_layers_size_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hidden_layers_size_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epochs_edit_Callback(hObject, eventdata, handles)
% hObject    handle to epochs_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epochs_edit as text
%        str2double(get(hObject,'String')) returns contents of epochs_edit as a double


% --- Executes during object creation, after setting all properties.
function epochs_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epochs_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in learning_function_popupmenu.
function learning_function_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to learning_function_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns learning_function_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from learning_function_popupmenu


% --- Executes during object creation, after setting all properties.
function learning_function_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to learning_function_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in type_popupmenu.
function type_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns type_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from type_popupmenu


% --- Executes during object creation, after setting all properties.
function type_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function accuracy_edit_Callback(hObject, eventdata, handles)
% hObject    handle to accuracy_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accuracy_edit as text
%        str2double(get(hObject,'String')) returns contents of accuracy_edit as a double


% --- Executes during object creation, after setting all properties.
function accuracy_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accuracy_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function true_positives_edit_Callback(hObject, eventdata, handles)
% hObject    handle to true_positives_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of true_positives_edit as text
%        str2double(get(hObject,'String')) returns contents of true_positives_edit as a double


% --- Executes during object creation, after setting all properties.
function true_positives_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to true_positives_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function true_negatives_edit_Callback(hObject, eventdata, handles)
% hObject    handle to true_negatives_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of true_negatives_edit as text
%        str2double(get(hObject,'String')) returns contents of true_negatives_edit as a double


% --- Executes during object creation, after setting all properties.
function true_negatives_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to true_negatives_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function false_positives_edit_Callback(hObject, eventdata, handles)
% hObject    handle to false_positives_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of false_positives_edit as text
%        str2double(get(hObject,'String')) returns contents of false_positives_edit as a double


% --- Executes during object creation, after setting all properties.
function false_positives_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to false_positives_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function false_negatives_edit_Callback(hObject, eventdata, handles)
% hObject    handle to false_negatives_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of false_negatives_edit as text
%        str2double(get(hObject,'String')) returns contents of false_negatives_edit as a double


% --- Executes during object creation, after setting all properties.
function false_negatives_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to false_negatives_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function specificity_edit_Callback(hObject, eventdata, handles)
% hObject    handle to specificity_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of specificity_edit as text
%        str2double(get(hObject,'String')) returns contents of specificity_edit as a double


% --- Executes during object creation, after setting all properties.
function specificity_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to specificity_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sensitivity_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sensitivity_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sensitivity_edit as text
%        str2double(get(hObject,'String')) returns contents of sensitivity_edit as a double


% --- Executes during object creation, after setting all properties.
function sensitivity_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sensitivity_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over radiobutton1.
function radiobutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.classification_method = 1;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over radiobutton1.
function radiobutton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.classification_method = 2;

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over radiobutton1.
function radiobutton3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.classification_method = 3;
