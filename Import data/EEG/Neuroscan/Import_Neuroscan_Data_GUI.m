function varargout = Import_Neuroscan_Data_GUI(varargin)
% IMPORT_NEUROSCAN_DATA_GUI MATLAB code for Import_Neuroscan_Data_GUI.fig
%      IMPORT_NEUROSCAN_DATA_GUI, by itself, creates a new IMPORT_NEUROSCAN_DATA_GUI or raises the existing
%      singleton*.
%
%      H = IMPORT_NEUROSCAN_DATA_GUI returns the handle to a new IMPORT_NEUROSCAN_DATA_GUI or the handle to
%      the existing singleton*.
%
%      IMPORT_NEUROSCAN_DATA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORT_NEUROSCAN_DATA_GUI.M with the given input arguments.
%
%      IMPORT_NEUROSCAN_DATA_GUI('Property','Value',...) creates a new IMPORT_NEUROSCAN_DATA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Import_Neuroscan_Data_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Import_Neuroscan_Data_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Import_Neuroscan_Data_GUI

% Last Modified by GUIDE v2.5 27-Oct-2021 10:39:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Import_Neuroscan_Data_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Import_Neuroscan_Data_GUI_OutputFcn, ...
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


% --- Executes just before Import_Neuroscan_Data_GUI is made visible.
function Import_Neuroscan_Data_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Import_Neuroscan_Data_GUI (see VARARGIN)

% Choose default command line output for Import_Neuroscan_Data_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Import_Neuroscan_Data_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Import_Neuroscan_Data_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dir where to save the data for Neuroscan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Neuroscan_Save_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Neuroscan_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Neuroscan_Save_Data as text
%        str2double(get(hObject,'String')) returns contents of Dir_Neuroscan_Save_Data as a double


% --- Executes during object creation, after setting all properties.
function Dir_Neuroscan_Save_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Neuroscan_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Folder where to save the data for Brain Vision
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Folder_Neuroscan_Save_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Folder_Neuroscan_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Folder_Neuroscan_Save_Data as text
%        str2double(get(hObject,'String')) returns contents of Folder_Neuroscan_Save_Data as a double


% --- Executes during object creation, after setting all properties.
function Folder_Neuroscan_Save_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Folder_Neuroscan_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the mat file where to save the data for Neuroscan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Neuroscan_Save_Data_Callback(hObject, eventdata, handles)
% hObject    handle to File_Neuroscan_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Neuroscan_Save_Data as text
%        str2double(get(hObject,'String')) returns contents of File_Neuroscan_Save_Data as a double


% --- Executes during object creation, after setting all properties.
function File_Neuroscan_Save_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Neuroscan_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload Neuroscan data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Neuroscan_File.
function Upload_Neuroscan_File_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Neuroscan_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global panel_info_tag;
global name_file_tag;
global channels_tag;
global samples_tag;
global sampling_frequency_tag;
global trial_duration_minutes_tag;
global trial_duration_seconds_tag;
global electrodes_recorded_tag;
global triggers_number_tag;
global triggers_type_tag;
global data_exported;

data_exported = [];

[CNT_file_selected,CNT_file_directory] = uigetfile('*.cnt','Select the "cnt" file');

%End the program, if no file has been selected
if (CNT_file_directory == 0)

    set(handles.Neuroscan_File_Uploaded,'String','No_file_selected');
    
    message = 'No file has been selected';

        msgbox(message,'End of operation','warn');
    
        return;
    
end

set(handles.Neuroscan_File_Uploaded,'String',CNT_file_selected);

%Read Neuroscan data
cd(CNT_file_directory)

pause(0.1);

%% Open and Read the neuroscan file uploaded
bits_selection_EEG = get(handles.Bits_Neuroscan,'Value');
switch bits_selection_EEG
    
    case 1
        
bits_data_EEG = 'int16'

case 2
    
bits_data_EEG = 'int32'

end

%% Loading the EEG-CNT file selected
[f,lab,dat,labels_electrodes,events_trigger,events_type] = Read_Neuroscan_COGMO(CNT_file_selected,bits_data_EEG,CNT_file_directory);

eeg_neuroscan = dat;    %Saving the data in a file named "eeg_neuroscan"

[number_of_channels number_of_samples] = size(eeg_neuroscan);
sampling_frequency = f.header.rate;

save_data_folder = get(handles.Folder_Neuroscan_Save_Data,'String');
save_data_directory = get(handles.Dir_Neuroscan_Save_Data,'String');
name_mat_file = get(handles.File_Neuroscan_Save_Data,'String');

cd([save_data_directory])
mkdir(save_data_folder)
cd([save_data_directory '\' save_data_folder])

%% Saving the names and locations of the electrodes;
labels_electrodes = cellstr(labels_electrodes);
xlswrite ('Electrodes_Recorded',labels_electrodes);

try
    
data_exported.eeg_data = eeg_neuroscan; 
data_exported.channels = number_of_channels;
data_exported.samples = number_of_samples;
data_exported.sampling_frequency = sampling_frequency;
data_exported.time = (0:size(eeg_neuroscan,2)-1)./sampling_frequency;
data_exported.trial_duration = (number_of_samples - 1)/sampling_frequency;
data_exported.labels = labels_electrodes;
data_exported.chanlocs = f.electloc;
data_exported.events_trigger = events_trigger;
data_exported.events_type = events_type;

catch
    
end

save_eeg = [name_mat_file '.' 'mat'];
save (save_eeg,'data_exported')

              
 try
     
 set(panel_info_tag,'Title',['File Opened: ' CNT_file_selected]);
 set(name_file_tag,'String',name_mat_file);
 set(channels_tag,'String',data_exported.channels);
 set (samples_tag,'String',data_exported.samples);
set(sampling_frequency_tag,'String',data_exported.sampling_frequency);
set(trial_duration_minutes_tag,'String',data_exported.trial_duration/60);
set(trial_duration_seconds_tag,'String',data_exported.trial_duration);
set(electrodes_recorded_tag,'String',data_exported.labels);
set(triggers_number_tag,'String',length(data_exported.events_trigger));

if (length(data_exported.events_trigger) > 0)

    set(triggers_type_tag,'String',data_exported.events_type);

else
    
    set(triggers_type_tag,'String','No triggers');
    
end;

 catch
    
      set(triggers_number_tag,'String','No triggers');
      set(triggers_type_tag,'String','No triggers'); 
    
 end


message = 'EEGs have been saved';

        msgbox(message,'EEG saved','warn');
        
        %close(Import_Neuroscan_Data_GUI);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Neuroscan data uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Neuroscan_File_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Neuroscan_File_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Neuroscan_File_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Neuroscan_File_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Neuroscan_File_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Neuroscan_File_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Bits for Neuroscan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Bits_Neuroscan.
function Bits_Neuroscan_Callback(hObject, eventdata, handles)
% hObject    handle to Bits_Neuroscan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Bits_Neuroscan contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Bits_Neuroscan


% --- Executes during object creation, after setting all properties.
function Bits_Neuroscan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bits_Neuroscan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to import SEPCAM data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Import_Neuroscan_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Import_Neuroscan_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Import_Neuroscan();
