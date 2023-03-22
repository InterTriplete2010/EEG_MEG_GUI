function varargout = Remove_selected_Triggers_GUI(varargin)
% REMOVE_SELECTED_TRIGGERS_GUI M-file for Remove_selected_Triggers_GUI.fig
%      REMOVE_SELECTED_TRIGGERS_GUI, by itself, creates a new REMOVE_SELECTED_TRIGGERS_GUI or raises the existing
%      singleton*.
%
%      H = REMOVE_SELECTED_TRIGGERS_GUI returns the handle to a new REMOVE_SELECTED_TRIGGERS_GUI or the handle to
%      the existing singleton*.
%
%      REMOVE_SELECTED_TRIGGERS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOVE_SELECTED_TRIGGERS_GUI.M with the given input arguments.
%
%      REMOVE_SELECTED_TRIGGERS_GUI('Property','Value',...) creates a new REMOVE_SELECTED_TRIGGERS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Remove_selected_Triggers_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Remove_selected_Triggers_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Remove_selected_Triggers_GUI

% Last Modified by GUIDE v2.5 12-Jan-2022 19:09:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Remove_selected_Triggers_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Remove_selected_Triggers_GUI_OutputFcn, ...
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


% --- Executes just before Remove_selected_Triggers_GUI is made visible.
function Remove_selected_Triggers_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Remove_selected_Triggers_GUI (see VARARGIN)

% Choose default command line output for Remove_selected_Triggers_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Remove_selected_Triggers_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Remove_selected_Triggers_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the "mat" file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_file_triggers_removed.
function Upload_file_triggers_removed_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_file_triggers_removed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_selected;
global mat_file_directory;
global table_tag_remove_triggers;
global table_tag_remove_all_triggers_code;
global labels_triggers;
global latency_triggers;
global trigger_code;

table_tag_remove_triggers = handles.Table_Triggers_Recorded_Removed;
table_tag_remove_all_triggers_code = handles.Table_Triggers_Recorded_Remove_Type;

[mat_file_selected,mat_file_directory] = uigetfile('*.mat','Select the "mat" file');

cd(mat_file_directory)
load(mat_file_selected);

set(handles.Removed_Triggers_File_Selected,'String',mat_file_selected);

labels_triggers = data_exported.events_type';
latency_triggers = (data_exported.events_trigger/data_exported.sampling_frequency)';

if iscell(labels_triggers)
   
    labels_triggers = cell2mat(labels_triggers);
   
end


[count_trig trigger_code] = count_triggers_type(labels_triggers); 
check_identical_consecutive_triggers(labels_triggers,latency_triggers);

if ischar(labels_triggers)
   
     labels_triggers = str2num(labels_triggers);
    
end

if ischar(trigger_code)
   
     trigger_code = str2num(trigger_code);
    
end

%Filling the two tables with the triggers
set(handles.Table_Triggers_Recorded_Removed,'Data',[labels_triggers latency_triggers]);
set(handles.Table_Triggers_Recorded_Removed,'columnname',{'Code';'Latency(s)'});

set(handles.Table_Triggers_Recorded_Remove_Type,'Data',[trigger_code count_trig]);
set(handles.Table_Triggers_Recorded_Remove_Type,'columnname',{'Code';'Count'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Retuns the "mat" file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Removed_Triggers_File_Selected_Callback(hObject, eventdata, handles)
% hObject    handle to Removed_Triggers_File_Selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Removed_Triggers_File_Selected as text
%        str2double(get(hObject,'String')) returns contents of Removed_Triggers_File_Selected as a double


% --- Executes during object creation, after setting all properties.
function Removed_Triggers_File_Selected_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Removed_Triggers_File_Selected (see GCBO)
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
% --- Executes on button press in Remove_Triggers_Function.
function Remove_Triggers_Function_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_Triggers_Function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_selected;
global mat_file_directory;
global triggers_to_remove;
global triggers_to_remove_code;

if strcmp(get(handles.Triggers_to_be_Removed_Latency,'String'),'ALL') == 1

    remove_all_triggers_code_function(mat_file_selected,mat_file_directory,triggers_to_remove_code);
    
else
    
    remove_selected_triggers_function(mat_file_selected,mat_file_directory,triggers_to_remove);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select the triggers to be removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes when selected cell(s) is changed in Table_Triggers_Recorded_Removed.
function Table_Triggers_Recorded_Removed_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Table_Triggers_Recorded_Removed (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global table_tag_remove_triggers;
global triggers_to_remove;
global labels_triggers;
global latency_triggers;

event_data_indices = eventdata.Indices;

properties_table = get(table_tag_remove_triggers);

triggers_to_remove = zeros(1,size(event_data_indices,1));

for kk = 1:size(event_data_indices,1)
   
    triggers_to_remove(1,kk) = event_data_indices(kk,1);
    
    
end

set(handles.Triggers_to_be_Removed_Code,'String', labels_triggers(triggers_to_remove)');
set(handles.Triggers_to_be_Removed_Latency,'String', latency_triggers(triggers_to_remove)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Code of the triggers to be removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Triggers_to_be_Removed_Code.
function Triggers_to_be_Removed_Code_Callback(hObject, eventdata, handles)
% hObject    handle to Triggers_to_be_Removed_Code (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Triggers_to_be_Removed_Code contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Triggers_to_be_Removed_Code


% --- Executes during object creation, after setting all properties.
function Triggers_to_be_Removed_Code_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Triggers_to_be_Removed_Code (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Latency of the triggers to be removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Triggers_to_be_Removed_Latency.
function Triggers_to_be_Removed_Latency_Callback(hObject, eventdata, handles)
% hObject    handle to Triggers_to_be_Removed_Latency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Triggers_to_be_Removed_Latency contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Triggers_to_be_Removed_Latency


% --- Executes during object creation, after setting all properties.
function Triggers_to_be_Removed_Latency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Triggers_to_be_Removed_Latency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select the code to be removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes when selected cell(s) is changed in Table_Triggers_Recorded_Remove_Type.
function Table_Triggers_Recorded_Remove_Type_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Table_Triggers_Recorded_Remove_Type (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global table_tag_remove_all_triggers_code;
global triggers_to_remove_code;
global trigger_code;

event_data_indices = eventdata.Indices;

properties_table = get(table_tag_remove_all_triggers_code);

triggers_to_remove = zeros(1,size(event_data_indices,1));

for kk = 1:size(event_data_indices,1)
   
    triggers_to_remove(1,kk) = event_data_indices(kk,1);
    
    
end

triggers_to_remove_code = eventdata.Source.Data(triggers_to_remove,1);

set(handles.Triggers_to_be_Removed_Code,'String', trigger_code(triggers_to_remove)');
set(handles.Triggers_to_be_Removed_Latency,'String', 'ALL');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to remove triggers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Remove_Selected_Triggers_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_Selected_Triggers_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Remove_Triggers_Help();
