function varargout = cABR_GUI(varargin)
% CABR_GUI MATLAB code for cABR_GUI.fig
%      CABR_GUI, by itself, creates a new CABR_GUI or raises the existing
%      singleton*.
%
%      H = CABR_GUI returns the handle to a new CABR_GUI or the handle to
%      the existing singleton*.
%
%      CABR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CABR_GUI.M with the given input arguments.
%
%      CABR_GUI('Property','Value',...) creates a new CABR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cABR_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cABR_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cABR_GUI

% Last Modified by GUIDE v2.5 13-Jan-2022 13:46:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cABR_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @cABR_GUI_OutputFcn, ...
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


% --- Executes just before cABR_GUI is made visible.
function cABR_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cABR_GUI (see VARARGIN)

% Choose default command line output for cABR_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cABR_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cABR_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Low pass filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function LF_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to LF_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LF_cABR as text
%        str2double(get(hObject,'String')) returns contents of LF_cABR as a double


% --- Executes during object creation, after setting all properties.
function LF_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LF_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%High pass filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function HF_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to HF_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HF_cABR as text
%        str2double(get(hObject,'String')) returns contents of HF_cABR as a double


% --- Executes during object creation, after setting all properties.
function HF_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HF_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Order filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Order_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to Order_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Order_cABR as text
%        str2double(get(hObject,'String')) returns contents of Order_cABR as a double


% --- Executes during object creation, after setting all properties.
function Order_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Order_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate the RMS and the FFT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in RMS_FFT_IHS.
function RMS_FFT_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to RMS_FFT_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IHS_file_directory;

lf_buttw_filt = str2double(get(handles.LF_cABR,'String'));
hf_buttw_filt = str2double(get(handles.HF_cABR,'String'));
order_buttw_filt = str2double(get(handles.Order_cABR,'String'));

pre_stim_start = str2double(get(handles.Pre_stim_start_cABR,'String'));
pre_stim_end = str2double(get(handles.Pre_stim_end_cABR,'String'));

post_stim_start = str2double(get(handles.Post_stim_cABR_start,'String'));
post_stim_end = str2double(get(handles.Post_stim_cABR_end,'String'));

minimum_threshold_peaks = str2double(get(handles.Threshold_Peaks_IHS,'String'));
minimum_distance_peaks = str2double(get(handles.Distance_Peaks_IHS,'String'));

norm_factor = str2num(get(handles.Normalization_Factor_Peaks,'String'));

filter_data_FFR = get(handles.Filter_data_Smart_EP,'Value');
wfft = str2double(get(handles.Window_FFT_FFR,'String'))./1000;
if isnan(wfft)
    
    wfft = [];
    
end

offt = str2double(get(handles.Noverlap_FFT_FFR,'String'))./1000;
if isnan(offt)
    
    offt = [];
    
end

nfft = str2double(get(handles.nfft_FFT_FFR,'String'))./1000;
if isnan(nfft)
    
    nfft = [];
    
end


rms_fft_cABR_function(IHS_file_directory,lf_buttw_filt,hf_buttw_filt,order_buttw_filt,pre_stim_start, ...
    pre_stim_end,post_stim_start,post_stim_end,minimum_threshold_peaks,minimum_distance_peaks,norm_factor,...
    filter_data_FFR,wfft,offt,nfft)

message = 'RMS and FFT have been calculated and saved';

        msgbox(message,'Analysis completed','warn');
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose the directory 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_cABR as text
%        str2double(get(hObject,'String')) returns contents of Dir_cABR as a double


% --- Executes during object creation, after setting all properties.
function Dir_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_cABR.
function Upload_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IHS_file_directory;

[IHS_file_selected,IHS_file_directory] = uigetfile('*.mat','Select the directory');

set(handles.Dir_cABR,'String',IHS_file_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pre-stim start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Pre_stim_start_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to Pre_stim_start_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pre_stim_start_cABR as text
%        str2double(get(hObject,'String')) returns contents of Pre_stim_start_cABR as a double


% --- Executes during object creation, after setting all properties.
function Pre_stim_start_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pre_stim_start_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pre-stim end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Pre_stim_end_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to Pre_stim_end_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pre_stim_end_cABR as text
%        str2double(get(hObject,'String')) returns contents of Pre_stim_end_cABR as a double


% --- Executes during object creation, after setting all properties.
function Pre_stim_end_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pre_stim_end_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Post-stim start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Post_stim_cABR_start_Callback(hObject, eventdata, handles)
% hObject    handle to Post_stim_cABR_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Post_stim_cABR_start as text
%        str2double(get(hObject,'String')) returns contents of Post_stim_cABR_start as a double


% --- Executes during object creation, after setting all properties.
function Post_stim_cABR_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Post_stim_cABR_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Post-stim end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Post_stim_cABR_end_Callback(hObject, eventdata, handles)
% hObject    handle to Post_stim_cABR_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Post_stim_cABR_end as text
%        str2double(get(hObject,'String')) returns contents of Post_stim_cABR_end as a double


% --- Executes during object creation, after setting all properties.
function Post_stim_cABR_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Post_stim_cABR_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Threshold to accept the peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Threshold_Peaks_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_Peaks_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold_Peaks_IHS as text
%        str2double(get(hObject,'String')) returns contents of Threshold_Peaks_IHS as a double


% --- Executes during object creation, after setting all properties.
function Threshold_Peaks_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold_Peaks_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Minimum distance to accept the peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Distance_Peaks_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Distance_Peaks_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Distance_Peaks_IHS as text
%        str2double(get(hObject,'String')) returns contents of Distance_Peaks_IHS as a double


% --- Executes during object creation, after setting all properties.
function Distance_Peaks_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Distance_Peaks_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Normalization factor for the peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Normalization_Factor_Peaks_Callback(hObject, eventdata, handles)
% hObject    handle to Normalization_Factor_Peaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Normalization_Factor_Peaks as text
%        str2double(get(hObject,'String')) returns contents of Normalization_Factor_Peaks as a double


% --- Executes during object creation, after setting all properties.
function Normalization_Factor_Peaks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Normalization_Factor_Peaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Window for the FFT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Window_FFT_FFR_Callback(hObject, eventdata, handles)
% hObject    handle to Window_FFT_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Window_FFT_FFR as text
%        str2double(get(hObject,'String')) returns contents of Window_FFT_FFR as a double


% --- Executes during object creation, after setting all properties.
function Window_FFT_FFR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Window_FFT_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Noverlap for the FFT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Noverlap_FFT_FFR_Callback(hObject, eventdata, handles)
% hObject    handle to Noverlap_FFT_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Noverlap_FFT_FFR as text
%        str2double(get(hObject,'String')) returns contents of Noverlap_FFT_FFR as a double


% --- Executes during object creation, after setting all properties.
function Noverlap_FFT_FFR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Noverlap_FFT_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%nfft for the FFT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function nfft_FFT_FFR_Callback(hObject, eventdata, handles)
% hObject    handle to nfft_FFT_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nfft_FFT_FFR as text
%        str2double(get(hObject,'String')) returns contents of nfft_FFT_FFR as a double


% --- Executes during object creation, after setting all properties.
function nfft_FFT_FFR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nfft_FFT_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the data will be filtered
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Filter_data_Smart_EP.
function Filter_data_Smart_EP_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_data_Smart_EP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Filter_data_Smart_EP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to analyze FFR data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function FFR_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to FFR_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cABR_GUI_Help();
