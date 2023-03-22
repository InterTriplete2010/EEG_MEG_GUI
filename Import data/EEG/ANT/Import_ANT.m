function varargout = Import_ANT(varargin)
% IMPORT_ANT MATLAB code for Import_ANT.fig
%      IMPORT_ANT, by itself, creates a new IMPORT_ANT or raises the existing
%      singleton*.
%
%      H = IMPORT_ANT returns the handle to a new IMPORT_ANT or the handle to
%      the existing singleton*.
%
%      IMPORT_ANT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORT_ANT.M with the given input arguments.
%
%      IMPORT_ANT('Property','Value',...) creates a new IMPORT_ANT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Import_ANT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Import_ANT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Import_ANT

% Last Modified by GUIDE v2.5 27-Oct-2021 08:57:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Import_ANT_OpeningFcn, ...
                   'gui_OutputFcn',  @Import_ANT_OutputFcn, ...
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


% --- Executes just before Import_ANT is made visible.
function Import_ANT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Import_ANT (see VARARGIN)

% Choose default command line output for Import_ANT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Import_ANT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Import_ANT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory where to save the mat file  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Save_ANT_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Save_ANT_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Save_ANT_Data as text
%        str2double(get(hObject,'String')) returns contents of Dir_Save_ANT_Data as a double


% --- Executes during object creation, after setting all properties.
function Dir_Save_ANT_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Save_ANT_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the file where to save the ANT file in matlab 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ANT_Folder_Name_Callback(hObject, eventdata, handles)
% hObject    handle to ANT_Folder_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ANT_Folder_Name as text
%        str2double(get(hObject,'String')) returns contents of ANT_Folder_Name as a double


% --- Executes during object creation, after setting all properties.
function ANT_Folder_Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ANT_Folder_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the ANT file in matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ANT_File_Mat_Name_Callback(hObject, eventdata, handles)
% hObject    handle to ANT_File_Mat_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ANT_File_Mat_Name as text
%        str2double(get(hObject,'String')) returns contents of ANT_File_Mat_Name as a double


% --- Executes during object creation, after setting all properties.
function ANT_File_Mat_Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ANT_File_Mat_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the ANT file 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in ANT_File_Upload.
function ANT_File_Upload_Callback(hObject, eventdata, handles)
% hObject    handle to ANT_File_Upload (see GCBO)
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

[ANT_file_selected,ANT_file_directory] = uigetfile('*.cnt','Select the "cnt" file');

%End the program, if no file has been selected
if (ANT_file_directory == 0)

    set(handles.ANT_File_Uploaded,'String','No_file_selected');
    
    message = 'No file has been selected';

        msgbox(message,'End of operation','warn');
    
        return;
    
end

set(handles.ANT_File_Uploaded,'String',ANT_file_selected);

%Read Brain Vision data
cd(ANT_file_directory)

pause(0.1);

%% Loading the EEG-VHDR file selected
[EEG, com] = loadeep_COGMO_EEG(ANT_file_selected,ANT_file_directory);

try
latency_event = zeros(length(EEG.event),1);
type_event = cell(length(EEG.event),1);
for kk = 1:length(EEG.event)
   
latency_event(kk,1) = EEG.event(kk).latency;%/EEG.srate;
type_event(kk,1) = {EEG.event(kk).type};  
    
end

catch
    
end

save_data_folder = get(handles.ANT_Folder_Name,'String');
save_data_directory = get(handles.Dir_Save_ANT_Data,'String');
name_mat_file = get(handles.ANT_File_Mat_Name,'String');

cd([save_data_directory])
mkdir(save_data_folder)
cd([save_data_directory '\' save_data_folder]);

%% Saving the names and locations of the electrodes;
labels_electrodes = cellstr(str2mat(EEG.chanlocs.labels));
xlswrite ('Electrodes_Recorded',labels_electrodes);

try
data_exported.eeg_data = double(EEG.data); 
data_exported.channels = EEG.nbchan;
data_exported.samples = EEG.pnts;
data_exported.sampling_frequency = EEG.srate;
data_exported.time = (0:size(EEG.data,2)-1)./EEG.srate;
data_exported.trial_duration = (EEG.pnts - 1)/EEG.srate;
data_exported.labels = labels_electrodes;
data_exported.chanlocs = EEG.chanlocs;
data_exported.events_trigger = latency_event;
data_exported.events_type = type_event;

catch
    
end

save_eeg = [name_mat_file '.' 'mat'];
save (save_eeg,'data_exported')

        
        %pause(5);
        
try
    
 set(panel_info_tag,'Title',['File Opened: ' ANT_file_selected]);
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
        
        %close(Import_ANT);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ANT file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ANT_File_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to ANT_File_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ANT_File_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of ANT_File_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function ANT_File_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ANT_File_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to import ANT data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Import_ANT_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Import_ANT_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Import_ANT();
