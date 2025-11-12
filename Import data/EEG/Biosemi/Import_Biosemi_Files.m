function varargout = Import_Biosemi_Files(varargin)
% IMPORT_BIOSEMI_FILES M-file for Import_Biosemi_Files.fig
%      IMPORT_BIOSEMI_FILES, by itself, creates a new IMPORT_BIOSEMI_FILES or raises the existing
%      singleton*.
%
%      H = IMPORT_BIOSEMI_FILES returns the handle to a new IMPORT_BIOSEMI_FILES or the handle to
%      the existing singleton*.
%
%      IMPORT_BIOSEMI_FILES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORT_BIOSEMI_FILES.M with the given input arguments.
%
%      IMPORT_BIOSEMI_FILES('Property','Value',...) creates a new IMPORT_BIOSEMI_FILES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Read_Biosemi_Files_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Import_Biosemi_Files_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Import_Biosemi_Files

% Last Modified by GUIDE v2.5 27-Oct-2021 09:22:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Import_Biosemi_Files_OpeningFcn, ...
                   'gui_OutputFcn',  @Import_Biosemi_Files_OutputFcn, ...
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


% --- Executes just before Import_Biosemi_Files is made visible.
function Import_Biosemi_Files_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Import_Biosemi_Files (see VARARGIN)

% Choose default command line output for Import_Biosemi_Files
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Import_Biosemi_Files wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Import_Biosemi_Files_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BDF file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function BDF_File_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to BDF_File_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BDF_File_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of BDF_File_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function BDF_File_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BDF_File_Uploaded (see GCBO)
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
% --- Executes on button press in Upload_BDF_File.
function Upload_BDF_File_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_BDF_File (see GCBO)
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

[BDF_file_selected,BDF_file_directory] = uigetfile('*.bdf','Select the "bdf" file');

%End the program, if no file has been selected
if (BDF_file_directory == 0)

    set(handles.BDF_File_Uploaded,'String','No_file_selected');
    
    message = 'No file has been selected';

        msgbox(message,'End of operation','warn');
    
        return;
    
end

set(handles.BDF_File_Uploaded,'String',BDF_file_selected);

%Read Biosemi data
cd(BDF_file_directory)

reference_channel = str2num(get(handles.Reference_Biosemi,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Double checking the reference channels
if (reference_channel == 0)

    warning off
    
    options.Interpreter = 'tex';
    options.Default = ' ';
    
 check_reference_channel = questdlg('You chose to not re-reference the data (reference electrode = 0). Are you sure of your choice?', ...
  'Check Reference Channel', ...
  'Yes. Continue to export the data', 'No. Abort operation',options);

if (strcmp(check_reference_channel,'No. Abort operation'))
    
    message = 'Please, select the correct reference and reload the data';

        msgbox(message,'Incorrect reference','warn');
    
    return
    
end


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

warning on

pause(0.1);
%% Loading the EEG-BDF file selected
%[EEG, command, dat] = read_biosig(BDF_file_selected,reference_channel); %EEGLAB code
EEG = extract_data_biosemi(BDF_file_selected,reference_channel);    %My code
%EEG = extract_data_biosemi_mex(BDF_file_selected,reference_channel);    %My code in MEX


%Saving the labels of the channels
for kk = 1:length(EEG.chanlocs)
    
labels_electrodes(kk,1) = cellstr(EEG.chanlocs(kk).labels);

end

%Adding the Cz value re-referenced to the average of the two ear lobes
if (reference_channel == 0)
   
    EEG.data(size(EEG.data,1) + 1,:) = mean(EEG.data);
    labels_electrodes(length(EEG.chanlocs) + 1,1) = {'AEL'};
    
end

%Adding the additional channel (A2 - A1) for the Perceptual study
if (reference_channel == 0)
   
    EEG.data(size(EEG.data,1) + 1,:) = EEG.data(1,:) - EEG.data(2,:);
    labels_electrodes(length(EEG.chanlocs) + 2,1) = {'A1_A2'};
    
end

save_data_folder = get(handles.Folder_Save_Data_BDF,'String');
save_data_directory = get(handles.Dir_Save_Data_BDF,'String');
name_mat_file = get(handles.Mat_File_Name_BDF,'String');

cd([save_data_directory])
mkdir(save_data_folder)
cd([save_data_directory '\' save_data_folder]);


%xlswrite ('Electrodes_Recorded',labels_electrodes);

try
%Saving the type and latency of the triggers
for hh = 1:length(EEG.event)
   
    events_type(hh) = EEG.event(hh).type - str2double(get(handles.Off_Set_Parallel_port_Biosemi,'String'));
    events_trigger(hh) = EEG.event(hh).latency;
    events_status(hh) = EEG.event(hh).status;
end

if (get(handles.Remove_First_Trigger_Biosemi,'Value')) == 1
    
    events_type(1) = [];
    events_trigger(1) = [];
    events_status(1) = [];
    
end

catch

    events_type = [];
    events_trigger = [];
    events_status = [];
    
end
    
try 
    
    %{
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Temporary code for the analysis
    EEG.data = double(EEG.data);
    EEG.data = EEG.data(1:64,:);
    [bb aa] = butter(2,[1 8]/(8192/2));
    EEG.data = filtfilt(bb,aa,EEG.data');
    EEG.data = resample(EEG.data,1,128);
    data_exported.eeg_data = EEG.data'; 
    data_exported.channels = EEG.nbchan;
    data_exported.samples = size(EEG.data',2);
    data_exported.reference_channel = {reference_channel};
    %data_exported.trial_duration = (EEG.pnts - 1)/EEG.srate;
    %data_exported.labels = labels_electrodes;
    data_exported.chanlocs = EEG.chanlocs;
    data_exported.resolution = EEG.resolution;
    %data_exported.events_trigger = events_trigger;
    data_exported.events_type = events_type;
    data_exported.events_status = events_status;
    data_exported.sampling_frequency = 64;
    data_exported.labels = labels_electrodes(1:64);
    data_exported.trial_duration = (size(EEG.data',2) - 1)/64;
    data_exported.events_trigger = round(events_trigger/128);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}
    
  
data_exported.eeg_data = double(EEG.data); 
data_exported.channels = EEG.nbchan;
data_exported.samples = EEG.pnts;
data_exported.sampling_frequency = EEG.srate;
data_exported.time = (0:size(EEG.data,2)-1)./EEG.srate;
data_exported.reference_channel = {reference_channel};
data_exported.trial_duration = (EEG.pnts - 1)/EEG.srate;
data_exported.labels = labels_electrodes;
data_exported.chanlocs = EEG.chanlocs;
data_exported.resolution = EEG.resolution;
data_exported.physical_dimension_channels = EEG.physic_dimen_chan;
data_exported.events_trigger = events_trigger;
data_exported.events_type = events_type;
data_exported.events_status = events_status;

    
catch
    
end

save_eeg = [name_mat_file '.' 'mat'];

    %try

     %   save (save_eeg,'data_exported')

    %catch

        save (save_eeg,'data_exported','-v7.3') %-v7.3 is used to save data > 2Gbytes
        
    %end

    try
    
    set(panel_info_tag,'Title',['File Opened: ' BDF_file_selected]);
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
function Dir_Save_Data_BDF_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Save_Data_BDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Save_Data_BDF as text
%        str2double(get(hObject,'String')) returns contents of Dir_Save_Data_BDF as a double


% --- Executes during object creation, after setting all properties.
function Dir_Save_Data_BDF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Save_Data_BDF (see GCBO)
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
function Folder_Save_Data_BDF_Callback(hObject, eventdata, handles)
% hObject    handle to Folder_Save_Data_BDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Folder_Save_Data_BDF as text
%        str2double(get(hObject,'String')) returns contents of Folder_Save_Data_BDF as a double


% --- Executes during object creation, after setting all properties.
function Folder_Save_Data_BDF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Folder_Save_Data_BDF (see GCBO)
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
function Mat_File_Name_BDF_Callback(hObject, eventdata, handles)
% hObject    handle to Mat_File_Name_BDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mat_File_Name_BDF as text
%        str2double(get(hObject,'String')) returns contents of Mat_File_Name_BDF as a double


% --- Executes during object creation, after setting all properties.
function Mat_File_Name_BDF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mat_File_Name_BDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Channel used to reference the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Reference_Biosemi_Callback(hObject, eventdata, handles)
% hObject    handle to Reference_Biosemi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Reference_Biosemi as text
%        str2double(get(hObject,'String')) returns contents of Reference_Biosemi as a double


% --- Executes during object creation, after setting all properties.
function Reference_Biosemi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Reference_Biosemi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Explanation of what a trigger-offset is
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Explanation_Offset_Trigger.
function Explanation_Offset_Trigger_Callback(hObject, eventdata, handles)
% hObject    handle to Explanation_Offset_Trigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

msgbox(['It appears that when Biosemi receives a trigger from a 8 bit parallel port ', ... 
'rather than 16 bit, it appends bits to the trigger code thus creating an ', ...
'offset. While this does not cause any change in the accuracy of the trigger ', ... 
'it might create some confusion, as the user would expect to see a small ', ... 
'number (e.g. "4"), but then a big number is saved (e.g. 3844 = offset + 4). If you ', ...
'see 3844 rather then the expected "4", insert 3840 in the box (the default value is "0", ', ...
'which implies that the correct 16 bit parallel port has been used) and re-upload the data.'],'End of the experiment'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Trigger-offset 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Off_Set_Parallel_port_Biosemi_Callback(hObject, eventdata, handles)
% hObject    handle to Off_Set_Parallel_port_Biosemi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Off_Set_Parallel_port_Biosemi as text
%        str2double(get(hObject,'String')) returns contents of Off_Set_Parallel_port_Biosemi as a double


% --- Executes during object creation, after setting all properties.
function Off_Set_Parallel_port_Biosemi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Off_Set_Parallel_port_Biosemi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the first trigger recorded will be removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Remove_First_Trigger_Biosemi.
function Remove_First_Trigger_Biosemi_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_First_Trigger_Biosemi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Remove_First_Trigger_Biosemi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to import Biosemi data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Import_Biosemi_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Import_Biosemi_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Import_Biosemi();



