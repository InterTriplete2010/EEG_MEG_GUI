function varargout = Remove_selected_sensors_GUI_COGMO(varargin)
% REMOVE_SELECTED_SENSORS_GUI_COGMO M-file for Remove_selected_sensors_GUI_COGMO.fig
%      REMOVE_SELECTED_SENSORS_GUI_COGMO, by itself, creates a new REMOVE_SELECTED_SENSORS_GUI_COGMO or raises the existing
%      singleton*.
%
%      H = REMOVE_SELECTED_SENSORS_GUI_COGMO returns the handle to a new REMOVE_SELECTED_SENSORS_GUI_COGMO or the handle to
%      the existing singleton*.
%
%      REMOVE_SELECTED_SENSORS_GUI_COGMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOVE_SELECTED_SENSORS_GUI_COGMO.M with the given input arguments.
%
%      REMOVE_SELECTED_SENSORS_GUI_COGMO('Property','Value',...) creates a new REMOVE_SELECTED_SENSORS_GUI_COGMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Remove_selected_sensors_GUI_COGMO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Remove_selected_sensors_GUI_COGMO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Remove_selected_sensors_GUI_COGMO

% Last Modified by GUIDE v2.5 12-Jan-2022 12:18:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Remove_selected_sensors_GUI_COGMO_OpeningFcn, ...
                   'gui_OutputFcn',  @Remove_selected_sensors_GUI_COGMO_OutputFcn, ...
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


% --- Executes just before Remove_selected_sensors_GUI_COGMO is made visible.
function Remove_selected_sensors_GUI_COGMO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Remove_selected_sensors_GUI_COGMO (see VARARGIN)

% Choose default command line output for Remove_selected_sensors_GUI_COGMO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Remove_selected_sensors_GUI_COGMO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Remove_selected_sensors_GUI_COGMO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the "mat" file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_file_sensors_removed_COGMO.
function Upload_file_sensors_removed_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_file_sensors_removed_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_selected;
global mat_file_directory;
global table_tag_remove_sensors;
global labels_electrodes;

table_tag_remove_sensors = handles.Table_Electrodes_Recorded_Removed_COGMO;

[mat_file_selected,mat_file_directory] = uigetfile('*.mat','Select the "mat" file');

cd(mat_file_directory)
load(mat_file_selected);

set(handles.Removed_Sensors_File_Selected_COGMO,'String',mat_file_selected);

labels_electrodes = data_exported.labels';

%Filling the table with the electrodes
set(handles.Table_Electrodes_Recorded_Removed_COGMO,'Data',data_exported.labels);
set(handles.Table_Electrodes_Recorded_Removed_COGMO,'columnname',{'Electrodes recorded'});

warning off
pause(0.05)
set(handles.Sensors_to_be_Removed,'Value',1);
set(handles.Sensors_to_be_Removed,'String',labels_electrodes');
warning on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Retuns the "mat" file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Removed_Sensors_File_Selected_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Removed_Sensors_File_Selected_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Removed_Sensors_File_Selected_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Removed_Sensors_File_Selected_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Removed_Sensors_File_Selected_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Removed_Sensors_File_Selected_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Remove the sensors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Remove_Sensors_Function_COGMO.
function Remove_Sensors_Function_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_Sensors_Function_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_selected;
global mat_file_directory;
global sensors_to_remove;

remove_selected_sensors_function_COGMO(mat_file_selected,mat_file_directory,sensors_to_remove);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select the sensors to be removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes when selected cell(s) is changed in Table_Electrodes_Recorded_Removed_COGMO.
function Table_Electrodes_Recorded_Removed_COGMO_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Table_Electrodes_Recorded_Removed_COGMO (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global table_tag_remove_sensors;
global sensors_to_remove;
global labels_electrodes;

event_data_indices = eventdata.Indices;

properties_table = get(table_tag_remove_sensors);

sensors_to_remove = zeros(1,size(event_data_indices,1));

for kk = 1:size(event_data_indices,1)
   
    sensors_to_remove(1,kk) = event_data_indices(kk,1);
    
end

set(handles.Sensors_to_be_Removed,'Value', 1);
set(handles.Sensors_to_be_Removed,'String', labels_electrodes(sensors_to_remove)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sensors to be removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Sensors_to_be_Removed.
function Sensors_to_be_Removed_Callback(hObject, eventdata, handles)
% hObject    handle to Sensors_to_be_Removed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Sensors_to_be_Removed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Sensors_to_be_Removed


% --- Executes during object creation, after setting all properties.
function Sensors_to_be_Removed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sensors_to_be_Removed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to remove sensors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Remove_Sensors_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_Sensors_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
