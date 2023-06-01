function varargout = Fourier_PWelch_COGMO_GUI(varargin)
% FOURIER_PWELCH_COGMO_GUI M-file for Fourier_PWelch_COGMO_GUI.fig
%      FOURIER_PWELCH_COGMO_GUI, by itself, creates a new FOURIER_PWELCH_COGMO_GUI or raises the existing
%      singleton*.
%
%      H = FOURIER_PWELCH_COGMO_GUI returns the handle to a new FOURIER_PWELCH_COGMO_GUI or the handle to
%      the existing singleton*.
%
%      FOURIER_PWELCH_COGMO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIER_PWELCH_COGMO_GUI.M with the given input arguments.
%
%      FOURIER_PWELCH_COGMO_GUI('Property','Value',...) creates a new FOURIER_PWELCH_COGMO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fourier_PWelch_COGMO_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fourier_PWelch_COGMO_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fourier_PWelch_COGMO_GUI

% Last Modified by GUIDE v2.5 10-Feb-2022 14:26:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fourier_PWelch_COGMO_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Fourier_PWelch_COGMO_GUI_OutputFcn, ...
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


% --- Executes just before Fourier_PWelch_COGMO_GUI is made visible.
function Fourier_PWelch_COGMO_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fourier_PWelch_COGMO_GUI (see VARARGIN)

% Choose default command line output for Fourier_PWelch_COGMO_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Fourier_PWelch_COGMO_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fourier_PWelch_COGMO_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Window value for the PWelch analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Window_EEG_PWelch_Callback(hObject, eventdata, handles)
% hObject    handle to Window_EEG_PWelch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Window_EEG_PWelch as text
%        str2double(get(hObject,'String')) returns contents of Window_EEG_PWelch as a double


% --- Executes during object creation, after setting all properties.
function Window_EEG_PWelch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Window_EEG_PWelch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NoOverlap value for the PWelch analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function NoOverlap_PWelch_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to NoOverlap_PWelch_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoOverlap_PWelch_EEG as text
%        str2double(get(hObject,'String')) returns contents of NoOverlap_PWelch_EEG as a double


% --- Executes during object creation, after setting all properties.
function NoOverlap_PWelch_EEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoOverlap_PWelch_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Nfft value for the PWelch analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Nfft_EEG_PWelch_Callback(hObject, eventdata, handles)
% hObject    handle to Nfft_EEG_PWelch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nfft_EEG_PWelch as text
%        str2double(get(hObject,'String')) returns contents of Nfft_EEG_PWelch as a double


% --- Executes during object creation, after setting all properties.
function Nfft_EEG_PWelch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nfft_EEG_PWelch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload Mat file for the PWelch analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Mat_PWelch_EEG.
function Upload_Mat_PWelch_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Mat_PWelch_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_Mat_file_selected;
global EEG_Mat_file_directory;

[EEG_Mat_file_selected,EEG_Mat_file_directory] = uigetfile('*.mat','Select the mat file');

cd(EEG_Mat_file_directory);
load(EEG_Mat_file_selected);

set(handles.File_Uploaded_EEG_PWelch,'String',EEG_Mat_file_selected);
set(handles.Channel_PWelch_Selected_EEG,'Value',1)
set(handles.Channel_PWelch_Selected_EEG,'String',data_exported.labels);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mat file uploaded for the PWelch analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Uploaded_EEG_PWelch_Callback(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_EEG_PWelch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Uploaded_EEG_PWelch as text
%        str2double(get(hObject,'String')) returns contents of File_Uploaded_EEG_PWelch as a double


% --- Executes during object creation, after setting all properties.
function File_Uploaded_EEG_PWelch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_EEG_PWelch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate PWelch of the uploaded file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Calculate_PWelch_EEG.
function Calculate_PWelch_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate_PWelch_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_Mat_file_selected;
global EEG_Mat_file_directory;

eegfile = [EEG_Mat_file_directory '\' EEG_Mat_file_selected];
eegfileloaded = load(eegfile);

try

    data_time = eegfileloaded.data_exported.time;

catch

    data_time = eegfileloaded.data_exported.time_average;

end

channel_selected = get(handles.Channel_PWelch_Selected_EEG,'Value');
channel_name_get = get(handles.Channel_PWelch_Selected_EEG,'String');
channel_name = channel_name_get(channel_selected);

sampling_frequency = eegfileloaded.data_exported.sampling_frequency;
start_time = find(data_time >= str2double(get(handles.Start_Time_FFT,'String')),1,'first');
end_time = find(data_time <= str2double(get(handles.End_Time_FFT,'String')),1,'last');

if (get(handles.FFT_Whole_Signal_COGMO,'Value') == 1)

    time_plot = data_time;

else

time_plot = data_time(start_time:end_time);

end

% start_time = round(str2double(get(handles.Start_Time_FFT,'String'))*sampling_frequency);
% end_time = round(str2double(get(handles.End_Time_FFT,'String'))*sampling_frequency);

all_chan_choice = get(handles.All_Chan_FFT,'Value');

%% Checking which type of data needs to be analyzed
try
switch get(handles.Signal_Analyze_FFT,'Value')
 
    case 1
   
        if all_chan_choice ~= 1
            
        eegfiledata_temp = eegfileloaded.data_exported.eeg_data(channel_selected,:); 
   
        else
            
            eegfiledata_temp = eegfileloaded.data_exported.eeg_data;
            
        end
        
    case 2
        
        if all_chan_choice ~= 1
        
    eegfiledata_temp = eegfileloaded.data_exported.average_trials(channel_selected,:);
    
        else
            
            eegfiledata_temp = eegfileloaded.data_exported.average_trials;
    
        end
    
    case 3
        
eegfiledata_temp = eegfileloaded.data_exported.average_add(:,:);
channel_selected = 'Cz';

    case 4

        eegfiledata_temp = eegfileloaded.data_exported.average_sub(:,:);
        channel_selected = 'Cz';
        
end

catch
   
     message = 'Invalid choice. Please, make sure your set of data support your choice. Check also the duration of the signal.';

        msgbox(message,'Error','warn');
    
        return;
        
end

if (get(handles.FFT_Whole_Signal_COGMO,'Value') == 1)
    
    eegfiledata = eegfiledata_temp;
    start_time = 0;
    
else
    
      eegfiledata = eegfiledata_temp(:,start_time:end_time);
      
end

window_variable = str2double(get(handles.Window_EEG_PWelch,'String'))./1000;
if isnan(window_variable)
    
    window_variable = [];
    
end

noverlap_variable = str2double(get(handles.NoOverlap_PWelch_EEG,'String'))./1000;
if isnan(noverlap_variable)
    
    noverlap_variable = [];
    
end

nfft_variable = str2double(get(handles.Nfft_EEG_PWelch,'String'))./1000;
if isnan(nfft_variable)
    
    nfft_variable = [];
    
end

PWelch_COGMO_Function(channel_name,eegfiledata,window_variable,noverlap_variable,nfft_variable,sampling_frequency,all_chan_choice,start_time,time_plot)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Channel selected for the PWelch analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Channel_PWelch_Selected_EEG.
function Channel_PWelch_Selected_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to Channel_PWelch_Selected_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Channel_PWelch_Selected_EEG contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Channel_PWelch_Selected_EEG


% --- Executes during object creation, after setting all properties.
function Channel_PWelch_Selected_EEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Channel_PWelch_Selected_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_Time_FFT_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Time_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_Time_FFT as text
%        str2double(get(hObject,'String')) returns contents of Start_Time_FFT as a double


% --- Executes during object creation, after setting all properties.
function Start_Time_FFT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_Time_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_Time_FFT_Callback(hObject, eventdata, handles)
% hObject    handle to End_Time_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Time_FFT as text
%        str2double(get(hObject,'String')) returns contents of End_Time_FFT as a double


% --- Executes during object creation, after setting all properties.
function End_Time_FFT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Time_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the whole signal will be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in FFT_Whole_Signal_COGMO.
function FFT_Whole_Signal_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to FFT_Whole_Signal_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FFT_Whole_Signal_COGMO
if(get(handles.FFT_Whole_Signal_COGMO,'Value') == 1)
   
    set(handles.Start_Time_FFT,'Enable','Off');
    set(handles.End_Time_FFT,'Enable','Off');
    
else
    
    set(handles.Start_Time_FFT,'Enable','On');
    set(handles.End_Time_FFT,'Enable','On');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Signal to be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Signal_Analyze_FFT.
function Signal_Analyze_FFT_Callback(hObject, eventdata, handles)
% hObject    handle to Signal_Analyze_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Signal_Analyze_FFT contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Signal_Analyze_FFT


% --- Executes during object creation, after setting all properties.
function Signal_Analyze_FFT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Signal_Analyze_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the FFT of all channels will be calculated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in All_Chan_FFT.
function All_Chan_FFT_Callback(hObject, eventdata, handles)
% hObject    handle to All_Chan_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of All_Chan_FFT
if(get(handles.All_Chan_FFT,'Value') == 1)
   
    set(handles.Channel_PWelch_Selected_EEG,'Enable','Off');
    
else
    
    set(handles.Channel_PWelch_Selected_EEG,'Enable','On');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI for the PWelch analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_PWelch_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_PWelch_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fourier_PWelch_Help();
