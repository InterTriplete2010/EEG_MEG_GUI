function varargout = Import_IHS_SEPCAM(varargin)
% IMPORT_IHS_SEPCAM M-file for Import_IHS_SEPCAM.fig
%      IMPORT_IHS_SEPCAM, by itself, creates a new IMPORT_IHS_SEPCAM or raises the existing
%      singleton*.
%
%      H = IMPORT_IHS_SEPCAM returns the handle to a new IMPORT_IHS_SEPCAM or the handle to
%      the existing singleton*.
%
%      IMPORT_IHS_SEPCAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORT_IHS_SEPCAM.M with the given input arguments.
%
%      IMPORT_IHS_SEPCAM('Property','Value',...) creates a new IMPORT_IHS_SEPCAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Read_Biosemi_Files_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Import_IHS_SEPCAM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Import_IHS_SEPCAM

% Last Modified by GUIDE v2.5 27-Oct-2021 10:32:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Import_IHS_SEPCAM_OpeningFcn, ...
                   'gui_OutputFcn',  @Import_IHS_SEPCAM_OutputFcn, ...
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


% --- Executes just before Import_IHS_SEPCAM is made visible.
function Import_IHS_SEPCAM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Import_IHS_SEPCAM (see VARARGIN)

% Choose default command line output for Import_IHS_SEPCAM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Import_IHS_SEPCAM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Import_IHS_SEPCAM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BDF file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function F_File_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to F_File_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F_File_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of F_File_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function F_File_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F_File_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the BDF file and convert it into "mat" format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_F_File.
function Upload_F_File_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_F_File (see GCBO)
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

[F_file_selected,F_file_directory] = uigetfile('*.F','Select the "F" file');

%End the program, if no file has been selected
if (F_file_directory == 0)

     set(handles.F_File_Uploaded,'String','No_file_selected');
    
    message = 'No file has been selected';

        msgbox(message,'End of operation','warn');
    
        return;
    
end

set(handles.F_File_Uploaded,'String',F_file_selected);

%Read IHS data
cd(F_file_directory)

pause(0.1);

%% Loading the EEG-BDF file selected
alt_pol_option = get(handles.Alternating_polarity_SEPCAM,'Value');
interval_trig = str2double(get(handles.Trigger_Interval_SEPCAM,'String'));
[EEG] = Read_IHS_SEPCAM_Data(F_file_selected,F_file_directory,alt_pol_option,interval_trig);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Removing the last two triggers (one for each polarity) to avoid the program 
%to crash when extracting the sweeps ("Exceed matrix dimension")
EEG.triggers (end) = [];
EEG.type (end) = [];

if (mod(length(EEG.triggers),2) ~= 0)

    EEG.triggers (end) = [];
EEG.type (end) = [];

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Saving the labels of the channels
if EEG.nbchan > 1
    
for ll = 1:EEG.nbchan-1
    
labels_electrodes(ll,1) = {['Chan_' num2str(ll)]};

end

else
   
    for ll = 1:EEG.nbchan
    
labels_electrodes(ll,1) = {['Chan_' num2str(ll)]};

end
    
end

if (get(handles.Save_Dig_Channel_SEPCAM,'Value') == 1)
    
labels_electrodes(EEG.nbchan,1) = {'Dig'};

else
 
    if EEG.nbchan > 1
    
    EEG.data(end,:) = [];
           
    end
    
end

save_data_folder = get(handles.Folder_Save_Data_F,'String');
save_data_directory = get(handles.Dir_Save_Data_F,'String');
name_mat_file = get(handles.Mat_File_Name_F,'String');

cd([save_data_directory])
mkdir(save_data_folder)
cd([save_data_directory '\' save_data_folder]);

xlswrite ('Electrodes_Recorded',labels_electrodes);

try 
    
data_exported.eeg_data = double(EEG.data); 
data_exported.channels = EEG.nbchan;
data_exported.samples = EEG.pnts;
data_exported.sampling_frequency = EEG.srate;
data_exported.time = (0:size(EEG.data,2)-1)./EEG.srate;
data_exported.trial_duration = (EEG.pnts - 1)/EEG.srate;
data_exported.labels = labels_electrodes;
data_exported.chanlocs = {'N/A'};
data_exported.events_trigger = EEG.triggers;
data_exported.events_type = EEG.type;

catch
    
end

save_eeg = [name_mat_file '.' 'mat'];
save (save_eeg,'data_exported')

try
    
set(panel_info_tag,'Title',['File Opened: ' F_file_selected]);
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
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory where to save the mat file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Save_Data_F_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Save_Data_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Save_Data_F as text
%        str2double(get(hObject,'String')) returns contents of Dir_Save_Data_F as a double


% --- Executes during object creation, after setting all properties.
function Dir_Save_Data_F_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Save_Data_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Folder where to save the mat file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Folder_Save_Data_F_Callback(hObject, eventdata, handles)
% hObject    handle to Folder_Save_Data_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Folder_Save_Data_F as text
%        str2double(get(hObject,'String')) returns contents of Folder_Save_Data_F as a double


% --- Executes during object creation, after setting all properties.
function Folder_Save_Data_F_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Folder_Save_Data_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the mat file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Mat_File_Name_F_Callback(hObject, eventdata, handles)
% hObject    handle to Mat_File_Name_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mat_File_Name_F as text
%        str2double(get(hObject,'String')) returns contents of Mat_File_Name_F as a double


% --- Executes during object creation, after setting all properties.
function Mat_File_Name_F_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mat_File_Name_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the triggers will be saved in an alternating polarity mode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Alternating_polarity_SEPCAM.
function Alternating_polarity_SEPCAM_Callback(hObject, eventdata, handles)
% hObject    handle to Alternating_polarity_SEPCAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Alternating_polarity_SEPCAM

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Interval used to save the trriggers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Trigger_Interval_SEPCAM_Callback(hObject, eventdata, handles)
% hObject    handle to Trigger_Interval_SEPCAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Trigger_Interval_SEPCAM as text
%        str2double(get(hObject,'String')) returns contents of Trigger_Interval_SEPCAM as a double


% --- Executes during object creation, after setting all properties.
function Trigger_Interval_SEPCAM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trigger_Interval_SEPCAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the dig channel will be saved 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Save_Dig_Channel_SEPCAM.
function Save_Dig_Channel_SEPCAM_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Dig_Channel_SEPCAM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Save_Dig_Channel_SEPCAM

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to import SEPCAM data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Import_SEPCAM_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Import_SEPCAM_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Import_SEPCAM();
