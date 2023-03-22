function varargout = Comb_Notch_Filter_GUI(varargin)
% COMB_NOTCH_FILTER_GUI MATLAB code for Comb_Notch_Filter_GUI.fig
%      COMB_NOTCH_FILTER_GUI, by itself, creates a new COMB_NOTCH_FILTER_GUI or raises the existing
%      singleton*.
%
%      H = COMB_NOTCH_FILTER_GUI returns the handle to a new COMB_NOTCH_FILTER_GUI or the handle to
%      the existing singleton*.
%
%      COMB_NOTCH_FILTER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMB_NOTCH_FILTER_GUI.M with the given input arguments.
%
%      COMB_NOTCH_FILTER_GUI('Property','Value',...) creates a new COMB_NOTCH_FILTER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Comb_Notch_Filter_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Comb_Notch_Filter_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Comb_Notch_Filter_GUI

% Last Modified by GUIDE v2.5 10-Feb-2022 13:35:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Comb_Notch_Filter_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Comb_Notch_Filter_GUI_OutputFcn, ...
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


% --- Executes just before Comb_Notch_Filter_GUI is made visible.
function Comb_Notch_Filter_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Comb_Notch_Filter_GUI (see VARARGIN)

% Choose default command line output for Comb_Notch_Filter_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Comb_Notch_Filter_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Comb_Notch_Filter_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fundamental frequency
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Fundamental_Freq_Comb_Notch_Callback(hObject, eventdata, handles)
% hObject    handle to Fundamental_Freq_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fundamental_Freq_Comb_Notch as text
%        str2double(get(hObject,'String')) returns contents of Fundamental_Freq_Comb_Notch as a double


% --- Executes during object creation, after setting all properties.
function Fundamental_Freq_Comb_Notch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fundamental_Freq_Comb_Notch (see GCBO)
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
% --- Executes on button press in Filter_Data_Comb_Notch.
function Filter_Data_Comb_Notch_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_Data_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_file_selected;
global EEG_file_directory;

cd(EEG_file_directory)
file_to_be_filtered = load(EEG_file_selected); 

eeg_data_filter = file_to_be_filtered.data_exported.eeg_data;
sampling_frequency_data = file_to_be_filtered.data_exported.sampling_frequency;;

frequency_notch = str2double(get(handles.Fundamental_Freq_Comb_Notch,'String'));

order_notch = round(sampling_frequency_data/frequency_notch);
BW = (frequency_notch/(sampling_frequency_data/2))/(str2double(get(handles.Q_Factor_Comb_Notch,'String')));

decibel_notch_filter = str2double(get(handles.Decibel_Comb_Notch,'String'));

[num den] = iircomb(order_notch,BW,decibel_notch_filter,'notch');
zp_option = get(handles.Phase_Comb_Notch,'Value');
eeg_filtered = Comb_Notch_Filter_Function (num,den,eeg_data_filter,sampling_frequency_data,zp_option); 

data_exported = [];

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

try
    
data_exported.sensors_removed = file_to_be_filtered.data_exported.labels;

catch
    
end

data_exported.events_trigger = file_to_be_filtered.data_exported.events_trigger;
data_exported.events_type = file_to_be_filtered.data_exported.events_type;
data_exported.filter_type = {'Comb_Notch'};
data_exported.frequency_notch_filter = frequency_notch;

if (zp_option == 1)
    
   data_exported.phase = {'Zero_Phase_FiltFilt'}; 
    
else
    
    data_exported.phase = {'No_Zero_Phase_Filter'}; 
    
end

data_exported.sensors_removed = file_to_be_filtered.data_exported.sensors_removed;

data_exported.chanlocs = file_to_be_filtered.data_exported.chanlocs;

catch
    
end

EEG_file_filtered_name = EEG_file_selected;

    save_eeg = [EEG_file_filtered_name '_Comb_Notch_F_IIR_' num2str(frequency_notch) '_' cell2mat(data_exported.phase) '.mat'];


save (save_eeg,'data_exported','-v7.3')

message = 'The data have been successfully filtered';

        msgbox(message,'Band Pass Filter','warn');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decibel for the notch filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Decibel_Comb_Notch_Callback(hObject, eventdata, handles)
% hObject    handle to Decibel_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Decibel_Comb_Notch as text
%        str2double(get(hObject,'String')) returns contents of Decibel_Comb_Notch as a double


% --- Executes during object creation, after setting all properties.
function Decibel_Comb_Notch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Decibel_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q factor for the Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Q_Factor_Comb_Notch_Callback(hObject, eventdata, handles)
% hObject    handle to Q_Factor_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q_Factor_Comb_Notch as text
%        str2double(get(hObject,'String')) returns contents of Q_Factor_Comb_Notch as a double


% --- Executes during object creation, after setting all properties.
function Q_Factor_Comb_Notch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q_Factor_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose if zero-phase will be used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Phase_Comb_Notch.
function Phase_Comb_Notch_Callback(hObject, eventdata, handles)
% hObject    handle to Phase_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Phase_Comb_Notch contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Phase_Comb_Notch


% --- Executes during object creation, after setting all properties.
function Phase_Comb_Notch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phase_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the file to be filtered
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_File_Comb_Notch.
function Upload_File_Comb_Notch_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_File_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_file_selected;
global EEG_file_directory;

[EEG_file_selected,EEG_file_directory] = uigetfile('*.mat','Select the mat file');

set(handles.File_Comb_Notch,'String',EEG_file_selected);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File to be filtered uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Comb_Notch_Callback(hObject, eventdata, handles)
% hObject    handle to File_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Comb_Notch as text
%        str2double(get(hObject,'String')) returns contents of File_Comb_Notch as a double


% --- Executes during object creation, after setting all properties.
function File_Comb_Notch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Comb_Notch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI for the IIR Comb Notch Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_CNF_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_CNF_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Comb_Notch_Filter_Help();
