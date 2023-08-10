function varargout = Import_Brain_Vision_Data_GUI(varargin)
% IMPORT_BRAIN_VISION_DATA_GUI MATLAB code for Import_Brain_Vision_Data_GUI.fig
%      IMPORT_BRAIN_VISION_DATA_GUI, by itself, creates a new IMPORT_BRAIN_VISION_DATA_GUI or raises the existing
%      singleton*.
%
%      H = IMPORT_BRAIN_VISION_DATA_GUI returns the handle to a new IMPORT_BRAIN_VISION_DATA_GUI or the handle to
%      the existing singleton*.
%
%      IMPORT_BRAIN_VISION_DATA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORT_BRAIN_VISION_DATA_GUI.M with the given input arguments.
%
%      IMPORT_BRAIN_VISION_DATA_GUI('Property','Value',...) creates a new IMPORT_BRAIN_VISION_DATA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Import_Brain_Vision_Data_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Import_Brain_Vision_Data_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Import_Brain_Vision_Data_GUI

% Last Modified by GUIDE v2.5 10-Aug-2023 07:57:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Import_Brain_Vision_Data_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Import_Brain_Vision_Data_GUI_OutputFcn, ...
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


% --- Executes just before Import_Brain_Vision_Data_GUI is made visible.
function Import_Brain_Vision_Data_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Import_Brain_Vision_Data_GUI (see VARARGIN)

% Choose default command line output for Import_Brain_Vision_Data_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Import_Brain_Vision_Data_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Import_Brain_Vision_Data_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dir where to save the data for Brain Vision
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Brain_Vision_Save_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Brain_Vision_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Brain_Vision_Save_Data as text
%        str2double(get(hObject,'String')) returns contents of Dir_Brain_Vision_Save_Data as a double


% --- Executes during object creation, after setting all properties.
function Dir_Brain_Vision_Save_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Brain_Vision_Save_Data (see GCBO)
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
function Folder_Brain_Vision_Save_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Folder_Brain_Vision_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Folder_Brain_Vision_Save_Data as text
%        str2double(get(hObject,'String')) returns contents of Folder_Brain_Vision_Save_Data as a double


% --- Executes during object creation, after setting all properties.
function Folder_Brain_Vision_Save_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Folder_Brain_Vision_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the mat file where to save the data for Brain Vision
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Brain_Vision_Save_Data_Callback(hObject, eventdata, handles)
% hObject    handle to File_Brain_Vision_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Brain_Vision_Save_Data as text
%        str2double(get(hObject,'String')) returns contents of File_Brain_Vision_Save_Data as a double


% --- Executes during object creation, after setting all properties.
function File_Brain_Vision_Save_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Brain_Vision_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload Brain Vision data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Brain_Vision_Data.
function Upload_Brain_Vision_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Brain_Vision_Data (see GCBO)
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

vhdr_ahdr = get(handles.Vhdr_ahdr,'Value');

if(vhdr_ahdr == 1)

    [VHDR_file_selected,VHDR_file_directory] = uigetfile('*.vhdr','Select the "vhdr" file');

else

    [VHDR_file_selected,VHDR_file_directory] = uigetfile('*.ahdr','Select the "vhdr" file');

end

%End the program, if no file has been selected
if (VHDR_file_directory == 0)

    set(handles.Brain_Vision_Data_Uploaded,'String','No_file_selected');
    
    message = 'No file has been selected';

        msgbox(message,'End of operation','warn');
    
        return;
    
end

set(handles.Brain_Vision_Data_Uploaded,'String',VHDR_file_selected);

bits_eeg = get(handles.Bits_Brain_Vision,'Value');

%Read Brain Vision data
cd(VHDR_file_directory)

pause(0.1);

%% Loading the EEG-VHDR(AHDR) file selected
%[EEG, com] = Read_loadbv_Brain_Vision(VHDR_file_directory, VHDR_file_selected);
EEG = extract_data_brain_vision(VHDR_file_directory, VHDR_file_selected, vhdr_ahdr,bits_eeg);

try
    
latency_event = zeros(length(EEG.event),1);
%type_event = cell(length(EEG.event),1);
type_event = zeros(length(EEG.event),1);

for kk = 1:length(EEG.event)
   
latency_event(kk,1) = EEG.event(kk).latency;%/EEG.srate;
%type_event(kk,1) = {EEG.event(kk).type};  
type_event(kk,1) = EEG.event(kk).type;  
   

end
    
catch
    
end

save_data_folder = get(handles.Folder_Brain_Vision_Save_Data,'String');
save_data_directory = get(handles.Dir_Brain_Vision_Save_Data,'String');
name_mat_file = get(handles.File_Brain_Vision_Save_Data,'String');

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
data_exported.events_trigger = latency_event';
data_exported.events_type = type_event';

catch
    
end

save_eeg = [name_mat_file '.' 'mat'];
save (save_eeg,'data_exported')

        
        %pause(5);
        
 try
     
 set(panel_info_tag,'Title',['File Opened: ' VHDR_file_selected]);
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
        
        %close(Import_Brain_Vision_Data_GUI);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Brain Vision data uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Brain_Vision_Data_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Brain_Vision_Data_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Brain_Vision_Data_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Brain_Vision_Data_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Brain_Vision_Data_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Brain_Vision_Data_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to import BrainVision data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Import_Brain_Vision_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Import_Brain_Vision_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Import_Brain_Vision();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select which file to open, vhdr or ahdr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Vhdr_ahdr.
function Vhdr_ahdr_Callback(hObject, eventdata, handles)
% hObject    handle to Vhdr_ahdr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Vhdr_ahdr contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Vhdr_ahdr


% --- Executes during object creation, after setting all properties.
function Vhdr_ahdr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vhdr_ahdr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Bits of the EEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Bits_Brain_Vision.
function Bits_Brain_Vision_Callback(hObject, eventdata, handles)
% hObject    handle to Bits_Brain_Vision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Bits_Brain_Vision contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Bits_Brain_Vision


% --- Executes during object creation, after setting all properties.
function Bits_Brain_Vision_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bits_Brain_Vision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
