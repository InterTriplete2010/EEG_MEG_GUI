function varargout = RMS_GUI(varargin)
% RMS_GUI MATLAB code for RMS_GUI.fig
%      RMS_GUI, by itself, creates a new RMS_GUI or raises the existing
%      singleton*.
%
%      H = RMS_GUI returns the handle to a new RMS_GUI or the handle to
%      the existing singleton*.
%
%      RMS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RMS_GUI.M with the given input arguments.
%
%      RMS_GUI('Property','Value',...) creates a new RMS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RMS_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RMS_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RMS_GUI

% Last Modified by GUIDE v2.5 13-Jan-2022 10:20:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RMS_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @RMS_GUI_OutputFcn, ...
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


% --- Executes just before RMS_GUI is made visible.
function RMS_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RMS_GUI (see VARARGIN)

% Choose default command line output for RMS_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RMS_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RMS_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File to be analyzed uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Mat_File_Uploaded_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to Mat_File_Uploaded_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mat_File_Uploaded_RMS as text
%        str2double(get(hObject,'String')) returns contents of Mat_File_Uploaded_RMS as a double


% --- Executes during object creation, after setting all properties.
function Mat_File_Uploaded_RMS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mat_File_Uploaded_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the file to be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Mat_File_RMS.
function Mat_File_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to Mat_File_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_rms_file_selected;
global EEG_rms_file_directory;

[EEG_rms_file_selected,EEG_rms_file_directory] = uigetfile('*.mat','Select the mat file');

cd(EEG_rms_file_directory)
load_signal = load(EEG_rms_file_selected);

set(handles.Mat_File_Uploaded_RMS,'String',EEG_rms_file_directory);

try
   
    set(handles.Electrodes_RMS,'String',load_signal.data_exported.labels)

catch
   
    set(handles.Electrodes_RMS,'String','Cz')
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compute the RMS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Compute_RMS.
function Compute_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to Compute_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_rms_file_selected;
global EEG_rms_file_directory;

cd(EEG_rms_file_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

for ii = 3:files_number
    
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)
        
  matrix_file = mat_files(ii).name     
  
  rmsfileloaded = load(matrix_file);
  

electrode_selected_rms = get(handles.Electrodes_RMS,'Value');
electrode_names_rms = get(handles.Electrodes_RMS,'String');
%electrode_name_selected_rms = electrode_names_rms(electrode_selected_rms,:);

%rmsfile = [EEG_rms_file_directory '\' EEG_rms_file_selected];
%rmsfileloaded = load(rmsfile);

sampling_frequency = rmsfileloaded.data_exported.sampling_frequency;

try

    time_av = rmsfileloaded.data_exported.time_average;

catch
    
    time_av = rmsfileloaded.data_exported.time;
    
end

real_time_S = str2double(get(handles.Starting_Wind_RMS,'String'))/1000;
real_time_E = str2double(get(handles.End_Wind_RMS,'String'))/1000;

startT_rms = find(time_av >= real_time_S,1,'First');
endT_rms = find(time_av <= real_time_E,1,'Last');
overlap_rms = str2double(get(handles.Overlap_Wind_RMS,'String'))/100;

window_RMS_analysis = floor((str2double(get(handles.Window_Analysis_RMS,'String'))/1000)*sampling_frequency);
samples_overlap = floor(window_RMS_analysis*overlap_rms);
%samples_overlap = floor((endT_rms - startT_rms)*overlap_rms);

%% Checking which type of data needs to be analyzed
try
switch get(handles.Signal_RMS,'Value') 
 
    case 1
   
        rmsfiledata = rmsfileloaded.data_exported.eeg_data; 
   
    case 2
        
    rmsfiledata = rmsfileloaded.data_exported.average_trials;
    
    case 3
        
rmsfiledata = rmsfileloaded.data_exported.average_add;
electrode_names_rms = rmsfileloaded.data_exported.channel_trials;
set(handles.Electrodes_RMS,'String',electrode_names_rms)

    case 4

        rmsfiledata = rmsfileloaded.data_exported.average_sub;
electrode_names_rms = rmsfileloaded.data_exported.channel_trials;
set(handles.Electrodes_RMS,'String',electrode_names_rms)

end

catch
   
     message = 'Invalid choice. Please, make sure your set of data support your choice. Check also the duration of the signal.';

        msgbox(message,'Error','warn');
    
        return;
        
end 

if (isempty(rmsfiledata))

    message = 'The type of data selected is empty. Please, change your choice';

        msgbox(message,'No RMS analysis has been performed','warn','replace');

        return;

end

calculate_rms(matrix_file,rmsfiledata,startT_rms,endT_rms,samples_overlap,electrode_names_rms,sampling_frequency,time_av,...
    real_time_S,real_time_E,window_RMS_analysis,overlap_rms)

   
    
    end
    
end

%% Merging the results into one excel file
save_files(1,1) = {'Name_Files'}; 
mat_files = dir;
[files_number] = size(mat_files,1);
track_data = 1;
for ii = 3:files_number
    
    if (strcmp(mat_files(ii).name(end-3:end), '.xls') == 1)
     
        temp_file = mat_files(ii).name; 
                temp_open_file = xlsread(temp_file);               
        
        save_files(track_data + 1,1) = {temp_file};
        
        for kk = 1:length(temp_open_file)
            
            save_files(1,kk + 1) = {['Region_' num2str(kk)]};
        save_files(track_data + 1,kk + 1) = {temp_open_file(kk)};
        
        end
    
        track_data = track_data + 1;
        
    end
    
end

xlswrite ([EEG_rms_file_selected(1:end-4) '_rms_Merged_Files'],save_files)

message = 'RMS values for all the files have been calculated and saved';

        msgbox(message,'End of the RMS analysis','warn','replace');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Type of signal to be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Signal_RMS.
function Signal_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to Signal_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Signal_RMS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Signal_RMS


% --- Executes during object creation, after setting all properties.
function Signal_RMS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Signal_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Starting point for the RMS analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Starting_Wind_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to Starting_Wind_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Starting_Wind_RMS as text
%        str2double(get(hObject,'String')) returns contents of Starting_Wind_RMS as a double


% --- Executes during object creation, after setting all properties.
function Starting_Wind_RMS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Starting_Wind_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Overlap for the RMS analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Overlap_Wind_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to Overlap_Wind_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Overlap_Wind_RMS as text
%        str2double(get(hObject,'String')) returns contents of Overlap_Wind_RMS as a double


% --- Executes during object creation, after setting all properties.
function Overlap_Wind_RMS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Overlap_Wind_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End point for the RMS analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_Wind_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to End_Wind_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Wind_RMS as text
%        str2double(get(hObject,'String')) returns contents of End_Wind_RMS as a double


% --- Executes during object creation, after setting all properties.
function End_Wind_RMS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Wind_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Electrodes for the RMS analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Electrodes_RMS.
function Electrodes_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to Electrodes_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Electrodes_RMS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Electrodes_RMS


% --- Executes during object creation, after setting all properties.
function Electrodes_RMS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Electrodes_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time window for the analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Window_Analysis_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to Window_Analysis_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Window_Analysis_RMS as text
%        str2double(get(hObject,'String')) returns contents of Window_Analysis_RMS as a double


% --- Executes during object creation, after setting all properties.
function Window_Analysis_RMS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Window_Analysis_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to calculate the RMS value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function RMS_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to RMS_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RMS_Help();
