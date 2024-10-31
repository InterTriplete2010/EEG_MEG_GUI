function varargout = Low_Pass_Filter_FIR_GUI(varargin)
% LOW_PASS_FILTER_FIR_GUI MATLAB code for Low_Pass_Filter_FIR_GUI.fig
%      LOW_PASS_FILTER_FIR_GUI, by itself, creates a new LOW_PASS_FILTER_FIR_GUI or raises the existing
%      singleton*.
%
%      H = LOW_PASS_FILTER_FIR_GUI returns the handle to a new LOW_PASS_FILTER_FIR_GUI or the handle to
%      the existing singleton*.
%
%      LOW_PASS_FILTER_FIR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOW_PASS_FILTER_FIR_GUI.M with the given input arguments.
%
%      LOW_PASS_FILTER_FIR_GUI('Property','Value',...) creates a new LOW_PASS_FILTER_FIR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Low_Pass_Filter_FIR_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Low_Pass_Filter_FIR_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Low_Pass_Filter_FIR_GUI

% Last Modified by GUIDE v2.5 10-Feb-2022 14:03:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Low_Pass_Filter_FIR_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Low_Pass_Filter_FIR_GUI_OutputFcn, ...
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


% --- Executes just before Low_Pass_Filter_FIR_GUI is made visible.
function Low_Pass_Filter_FIR_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Low_Pass_Filter_FIR_GUI (see VARARGIN)

% Choose default command line output for Low_Pass_Filter_FIR_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Low_Pass_Filter_FIR_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Low_Pass_Filter_FIR_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Cut off high pass filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Cut_Off_LPF_FIR_Callback(hObject, eventdata, handles)
% hObject    handle to Cut_Off_LPF_FIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cut_Off_LPF_FIR as text
%        str2double(get(hObject,'String')) returns contents of Cut_Off_LPF_FIR as a double


% --- Executes during object creation, after setting all properties.
function Cut_Off_LPF_FIR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cut_Off_LPF_FIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Filter the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in LPF_FIR_Filter.
function LPF_FIR_Filter_Callback(hObject, eventdata, handles)
% hObject    handle to LPF_FIR_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_file_selected;
global EEG_file_directory;

cd(EEG_file_directory)
file_to_be_filtered = load(EEG_file_selected); 

eeg_data_filter = file_to_be_filtered.data_exported.eeg_data;
sampling_frequency_data = file_to_be_filtered.data_exported.sampling_frequency;

cut_off_low = str2double(get(handles.Cut_Off_LPF_FIR,'String'));
order_low_pass = str2double(get(handles.Order_LPF_FIR,'String'));

eeg_filtered = Low_Pass_Filter_Function_FIR (eeg_data_filter,cut_off_low,sampling_frequency_data,order_low_pass); 

try
data_exported.eeg_data = eeg_filtered; 
data_exported.channels = file_to_be_filtered.data_exported.channels;
data_exported.samples = file_to_be_filtered.data_exported.samples;
data_exported.sampling_frequency = sampling_frequency_data;
data_exported.trial_duration = file_to_be_filtered.data_exported.samples/sampling_frequency_data;
data_exported.labels = file_to_be_filtered.data_exported.labels;

try
   
    data_exported.time = file_to_be_filtered.data_exported.time_average;
    data_exported.onset_average = file_to_be_filtered.data_exported.onset_average;
        
catch
    
    data_exported.time = file_to_be_filtered.data_exported.time;
    
end

%try
    
%data_exported.sensors_removed = file_to_be_filtered.data_exported.labels(sensors_to_remove);

%catch
    
%end

data_exported.chanlocs = file_to_be_filtered.data_exported.chanlocs;
data_exported.events_trigger = file_to_be_filtered.data_exported.events_trigger;
data_exported.events_type = file_to_be_filtered.data_exported.events_type;
data_exported.filter_type = {'Low_Pass FIR'};
data_exported.low_cut_filter = cut_off_low;
data_exported.order_filter = order_low_pass;

data_exported.sensors_removed = file_to_be_filtered.data_exported.sensors_removed;

data_exported.chanlocs = file_to_be_filtered.data_exported.chanlocs;

catch
    
end

EEG_file_filtered_name = EEG_file_selected;

    save_eeg = [EEG_file_filtered_name '_LPF_FIR_' num2str(cut_off_low) '_Order_' num2str(data_exported.order_filter) '.mat'];


save (save_eeg,'data_exported')

message = 'The data have been successfully filtered';

        msgbox(message,'Low Pass Filter','warn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Order of the filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Order_LPF_FIR_Callback(hObject, eventdata, handles)
% hObject    handle to Order_LPF_FIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Order_LPF_FIR as text
%        str2double(get(hObject,'String')) returns contents of Order_LPF_FIR as a double


% --- Executes during object creation, after setting all properties.
function Order_LPF_FIR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Order_LPF_FIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the file to be filtered
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Mat_File_LPF_FIR.
function Upload_Mat_File_LPF_FIR_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Mat_File_LPF_FIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_file_selected;
global EEG_file_directory;

[EEG_file_selected,EEG_file_directory] = uigetfile('*.mat','Select the mat file');

set(handles.Mat_File_Uploaded_LPF_FIR,'String',EEG_file_selected);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File to be filtered uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Mat_File_Uploaded_LPF_FIR_Callback(hObject, eventdata, handles)
% hObject    handle to Mat_File_Uploaded_LPF_FIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mat_File_Uploaded_LPF_FIR as text
%        str2double(get(hObject,'String')) returns contents of Mat_File_Uploaded_LPF_FIR as a double


% --- Executes during object creation, after setting all properties.
function Mat_File_Uploaded_LPF_FIR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mat_File_Uploaded_LPF_FIR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI for the FIR LPF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_LPF_FIR_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_LPF_FIR_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Low_Pass_Filter_FIR_Help();
