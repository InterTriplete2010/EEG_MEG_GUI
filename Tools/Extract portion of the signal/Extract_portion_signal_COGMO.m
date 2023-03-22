function varargout = Extract_portion_signal_COGMO(varargin)
% EXTRACT_PORTION_SIGNAL_COGMO M-file for Extract_portion_signal_COGMO.fig
%      EXTRACT_PORTION_SIGNAL_COGMO, by itself, creates a new EXTRACT_PORTION_SIGNAL_COGMO or raises the existing
%      singleton*.
%
%      H = EXTRACT_PORTION_SIGNAL_COGMO returns the handle to a new EXTRACT_PORTION_SIGNAL_COGMO or the handle to
%      the existing singleton*.
%
%      EXTRACT_PORTION_SIGNAL_COGMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACT_PORTION_SIGNAL_COGMO.M with the given input arguments.
%
%      EXTRACT_PORTION_SIGNAL_COGMO('Property','Value',...) creates a new EXTRACT_PORTION_SIGNAL_COGMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Extract_portion_signal_COGMO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Extract_portion_signal_COGMO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Extract_portion_signal_COGMO

% Last Modified by GUIDE v2.5 12-Jan-2022 11:18:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Extract_portion_signal_COGMO_OpeningFcn, ...
                   'gui_OutputFcn',  @Extract_portion_signal_COGMO_OutputFcn, ...
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


% --- Executes just before Extract_portion_signal_COGMO is made visible.
function Extract_portion_signal_COGMO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Extract_portion_signal_COGMO (see VARARGIN)

% Choose default command line output for Extract_portion_signal_COGMO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Extract_portion_signal_COGMO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Extract_portion_signal_COGMO_OutputFcn(hObject, eventdata, handles) 
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
global table_tag;

clear('info_trigger');

table_tag = handles.Table_Electrodes_Recorded_COGMO;

[mat_file_selected,mat_file_directory] = uigetfile('*.mat','Select the "mat" file');

cd(mat_file_directory)
load(mat_file_selected);

set(handles.Mat_File_Selected_Extract_Portion_Signal_COGMO,'String',mat_file_selected);

%Filling the table with the triggers
info_trigger(:,1) = data_exported.events_type;

[matrix_count_triggers] = count_triggers_COGMO(info_trigger(:,1));


try

info_trigger(:,2) = matrix_count_triggers;
info_trigger(:,3) = data_exported.events_trigger/data_exported.sampling_frequency;
info_trigger(:,4) = data_exported.events_trigger/data_exported.sampling_frequency/60;

catch
   
    info_trigger(:,2) = matrix_count_triggers;
    
    for ppp = 1:length(data_exported.events_trigger)
        
    info_trigger(ppp,3) = {data_exported.events_trigger(ppp)/data_exported.sampling_frequency};
    info_trigger(ppp,4) = {data_exported.events_trigger(ppp)/data_exported.sampling_frequency/60};
    
    end

end

set(table_tag,'Data',info_trigger);
set(table_tag,'columnname',{'Code';'Count Triggers';'Time (s)';'Time (m)'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Retuns the "mat" file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Mat_File_Selected_Extract_Portion_Signal_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Mat_File_Selected_Extract_Portion_Signal_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mat_File_Selected_Extract_Portion_Signal_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Mat_File_Selected_Extract_Portion_Signal_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Mat_File_Selected_Extract_Portion_Signal_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mat_File_Selected_Extract_Portion_Signal_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sensors to be removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Time_Window_Portion_Signal_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Time_Window_Portion_Signal_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_Window_Portion_Signal_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Time_Window_Portion_Signal_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Time_Window_Portion_Signal_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_Window_Portion_Signal_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract the signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extract_Signal_Portion_COGMO.
function Extract_Signal_Portion_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Signal_Portion_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_selected;
global mat_file_directory;
global table_tag;
global time_window_signal;

time_window_signal = str2num(get(handles.Time_Window_Portion_Signal_COGMO,'String'));

Extract_portion_signal_function_COGMO(mat_file_selected,mat_file_directory,time_window_signal,table_tag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select the portion of the signal to be extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes when selected cell(s) is changed in Table_Electrodes_Recorded_COGMO.
function Table_Electrodes_Recorded_COGMO_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Table_Electrodes_Recorded_COGMO (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global table_tag;
global time_window_signal;

event_data_indices = eventdata.Indices;

properties_table = get(table_tag);

try
    
time_window_signal(1) = cell2mat(properties_table.Data(eventdata.Indices(1,1),eventdata.Indices(1,2)));
time_window_signal(2) = cell2mat(properties_table.Data(eventdata.Indices(2,1),eventdata.Indices(2,2)));

set(handles.Time_Window_Portion_Signal_COGMO,'String',num2str(time_window_signal));

catch
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to extract the portion of the signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Extract_portion_signal_Help_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_portion_signal_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Extract_portion_signal_Help();
