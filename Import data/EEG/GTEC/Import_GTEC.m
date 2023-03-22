function varargout = Import_GTEC(varargin)
% IMPORT_GTEC MATLAB code for Import_GTEC.fig
%      IMPORT_GTEC, by itself, creates a new IMPORT_GTEC or raises the existing
%      singleton*.
%
%      H = IMPORT_GTEC returns the handle to a new IMPORT_GTEC or the handle to
%      the existing singleton*.
%
%      IMPORT_GTEC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORT_GTEC.M with the given input arguments.
%
%      IMPORT_GTEC('Property','Value',...) creates a new IMPORT_GTEC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Import_GTEC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Import_GTEC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Import_GTEC

% Last Modified by GUIDE v2.5 27-Oct-2021 10:16:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Import_GTEC_OpeningFcn, ...
                   'gui_OutputFcn',  @Import_GTEC_OutputFcn, ...
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


% --- Executes just before Import_GTEC is made visible.
function Import_GTEC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Import_GTEC (see VARARGIN)

% Choose default command line output for Import_GTEC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Import_GTEC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Import_GTEC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select the "hdf5" file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Select_GTEC.
function Select_GTEC_Callback(hObject, eventdata, handles)
% hObject    handle to Select_GTEC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hdf5_file_selected;
global hdf5_file_directory;
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

[hdf5_file_selected,hdf5_file_directory] = uigetfile('*.hdf5','Select the "hdf5" file');

%End the program, if no file has been selected
if (hdf5_file_directory == 0)

    set(handles.HDF5_File,'String','No_file_selected');
    
    message = 'No file has been selected';

        msgbox(message,'End of operation','warn');
    
        return;
    
end


set(handles.HDF5_File,'String',hdf5_file_selected);

cd(hdf5_file_directory)

pause(0.1);

%% Loading the EEG-CNT file selected
hdf5_file_info = hdf5info(hdf5_file_selected);

Groups_Index = 0;
Datasets_Index = 0;

for kk = 1:length(hdf5_file_info.GroupHierarchy.Groups)  
    
    if (strcmp(hdf5_file_info.GroupHierarchy.Groups(kk).Name,'/RawData'))
        
        Groups_Index = kk;
        
        for ll = 1:length(hdf5_file_info.GroupHierarchy.Groups(Groups_Index).Datasets) 
        
       if (strcmp(hdf5_file_info.GroupHierarchy.Groups(kk).Datasets(ll).Name,'/RawData/Samples'))
           
           Datasets_Index = ll;
                     
            end
            
        end
    
    end
end

name_hdf5_file_info = hdf5_file_info.GroupHierarchy.Groups(Groups_Index).Datasets(Datasets_Index).Name;

hdf5_data = h5read(hdf5_file_selected,name_hdf5_file_info);    %Saving the data in a file named "hdf5_data"

info_channels = cell2mat(h5read(hdf5_file_selected,'/RawData/AcquisitionTaskDescription'));

%% Loop to find the sampling frequency
find_sf = 1;
for mmm = 1:length(info_channels)

    if (strcmp(info_channels(1,mmm),'<') && (find_sf == 1))

        if strcmp(info_channels(1,mmm + 1),'S') && strcmp(info_channels(1,mmm + 2),'a') && strcmp(info_channels(1,mmm + 3),'m') && strcmp(info_channels(1,mmm + 4),'p') && strcmp(info_channels(1,mmm + 5),'l') && strcmp(info_channels(1,mmm + 6),'e')
            
            track_sf_char = 1; 
            
            for jjj = mmm + 12:mmm + 16
                
               if strcmp(info_channels(1,jjj),'<') ~= 1 && strcmp(info_channels(1,jjj),'/') ~=1
                
                save_sf (track_sf_char) = info_channels(1,jjj);   
                   
                track_sf_char = track_sf_char + 1;
                
               end
                              
            end
            
            sampling_frequency = str2double(save_sf);
            find_sf = 0;
            
        end
        
    end
        
end

%% Loop to find the names of the channels
track_channel_position = 1;
for mmm = 1:length(info_channels)

    if strcmp(info_channels(1,mmm),'<') 

        if strcmp(info_channels(1,mmm + 1),'C') && strcmp(info_channels(1,mmm + 2),'h') && strcmp(info_channels(1,mmm + 3),'a') && strcmp(info_channels(1,mmm + 4),'n') && strcmp(info_channels(1,mmm + 5),'n') && strcmp(info_channels(1,mmm + 6),'e') && strcmp(info_channels(1,mmm + 7),'l') && strcmp(info_channels(1,mmm + 8),'N')
            
            track_channel_char = 1; 
            
            for jjj = mmm + 13:mmm + 16
                
                if strcmp(info_channels(1,jjj),'<') ~= 1 && strcmp(info_channels(1,jjj),'/') ~= 1
                
                    track_cell_position = jjj;
                                              
                end          
            end
            
            save_channels_name (track_channel_position,track_channel_char) = {info_channels(1,mmm + 13:track_cell_position)};   
               
            track_channel_position = track_channel_position + 1;
                        
        end
        
    end
        
        end
        
[number_of_channels number_of_samples] = size(hdf5_data);

save_data_folder = get(handles.Folder_HDF5,'String');
save_data_directory = get(handles.Dir_Save_HDF5,'String');
name_mat_file = get(handles.Mat_File_HDF5,'String');

events_trigger = h5read(hdf5_file_selected,'/AsynchronData/Time');
events_type = h5read(hdf5_file_selected,'/AsynchronData/Value');

events_type_ID = h5read(hdf5_file_selected,'/AsynchronData/TypeID');


cd([save_data_directory])
mkdir(save_data_folder)
cd([save_data_directory '\' save_data_folder])

%% Saving the names and locations of the electrodes;
labels_electrodes = cellstr(save_channels_name);
xlswrite ('Electrodes_Recorded',labels_electrodes);

data_exported.eeg_data = double(hdf5_data); 
data_exported.channels = number_of_channels;
data_exported.samples = number_of_samples;
data_exported.sampling_frequency = sampling_frequency;
data_exported.time = (0:size(hdf5_data,2)-1)./sampling_frequency;
data_exported.trial_duration = (number_of_samples - 1)/sampling_frequency;
data_exported.labels = labels_electrodes;
data_exported.events_trigger = double(events_trigger);
data_exported.events_type = double(events_type);
data_exported.chanlocs = 0;

save_eeg = [name_mat_file '.' 'mat'];
save (save_eeg,'data_exported')

try

 set(panel_info_tag,'Title',['File Opened: ' hdf5_file_selected]);
 set(name_file_tag,'String',hdf5_file_selected);
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%"hdf5" file selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function HDF5_File_Callback(hObject, eventdata, handles)
% hObject    handle to HDF5_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HDF5_File as text
%        str2double(get(hObject,'String')) returns contents of HDF5_File as a double


% --- Executes during object creation, after setting all properties.
function HDF5_File_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HDF5_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory where to save the "hdf5" file selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Save_HDF5_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Save_HDF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Save_HDF5 as text
%        str2double(get(hObject,'String')) returns contents of Dir_Save_HDF5 as a double


% --- Executes during object creation, after setting all properties.
function Dir_Save_HDF5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Save_HDF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Folder where to save the "hdf5" file selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Folder_HDF5_Callback(hObject, eventdata, handles)
% hObject    handle to Folder_HDF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Folder_HDF5 as text
%        str2double(get(hObject,'String')) returns contents of Folder_HDF5 as a double


% --- Executes during object creation, after setting all properties.
function Folder_HDF5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Folder_HDF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the "mat" file for the "hdf5" file selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Mat_File_HDF5_Callback(hObject, eventdata, handles)
% hObject    handle to Mat_File_HDF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mat_File_HDF5 as text
%        str2double(get(hObject,'String')) returns contents of Mat_File_HDF5 as a double


% --- Executes during object creation, after setting all properties.
function Mat_File_HDF5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mat_File_HDF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to import Emotiv data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Import_GTEC_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Import_GTEC_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Import_GTEC();
