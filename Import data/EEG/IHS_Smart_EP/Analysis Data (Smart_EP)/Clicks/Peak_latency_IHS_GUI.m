function varargout = Peak_latency_IHS_GUI(varargin)
% PEAK_LATENCY_IHS_GUI MATLAB code for Peak_latency_IHS_GUI.fig
%      PEAK_LATENCY_IHS_GUI, by itself, creates a new PEAK_LATENCY_IHS_GUI or raises the existing
%      singleton*.
%
%      H = PEAK_LATENCY_IHS_GUI returns the handle to a new PEAK_LATENCY_IHS_GUI or the handle to
%      the existing singleton*.
%
%      PEAK_LATENCY_IHS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEAK_LATENCY_IHS_GUI.M with the given input arguments.
%
%      PEAK_LATENCY_IHS_GUI('Property','Value',...) creates a new PEAK_LATENCY_IHS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Peak_latency_IHS_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Peak_latency_IHS_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Peak_latency_IHS_GUI

% Last Modified by GUIDE v2.5 13-Jan-2022 13:56:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Peak_latency_IHS_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Peak_latency_IHS_GUI_OutputFcn, ...
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


% --- Executes just before Peak_latency_IHS_GUI is made visible.
function Peak_latency_IHS_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Peak_latency_IHS_GUI (see VARARGIN)

% Choose default command line output for Peak_latency_IHS_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Peak_latency_IHS_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Peak_latency_IHS_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory chosen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Uploaded_Peak_Latency_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_Peak_Latency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Uploaded_Peak_Latency as text
%        str2double(get(hObject,'String')) returns contents of Dir_Uploaded_Peak_Latency as a double


% --- Executes during object creation, after setting all properties.
function Dir_Uploaded_Peak_Latency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_Peak_Latency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose the directory 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_Peak_Latency.
function Upload_Dir_Peak_Latency_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_Peak_Latency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IHS_file_directory;

[IHS_file_selected,IHS_file_directory] = uigetfile('*.mat','Select the directory');

set(handles.Dir_Uploaded_Peak_Latency,'String',IHS_file_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract the peaks and latencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extract_Peak_Latency_IHS.
function Extract_Peak_Latency_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Peak_Latency_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IHS_file_directory;

lf_buttw_filt = str2double(get(handles.LF_Butterworth,'String'));
hf_buttw_filt = str2double(get(handles.HF_Butterworth,'String'));
order_buttw_filt = str2double(get(handles.Order_Butterworth_Filter,'String'));

check_filter = get(handles.Filter_Data_Check_Peaks_IHS,'Value');

extract_peaks_latency_function(IHS_file_directory,lf_buttw_filt,hf_buttw_filt,order_buttw_filt,check_filter)

message = 'Peaks and latencies have been calculated and saved';

        msgbox(message,'Analysis completed','warn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Low frequency for the Butterworth filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function LF_Butterworth_Callback(hObject, eventdata, handles)
% hObject    handle to LF_Butterworth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LF_Butterworth as text
%        str2double(get(hObject,'String')) returns contents of LF_Butterworth as a double


% --- Executes during object creation, after setting all properties.
function LF_Butterworth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LF_Butterworth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%High frequency for the Butterworth filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function HF_Butterworth_Callback(hObject, eventdata, handles)
% hObject    handle to HF_Butterworth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HF_Butterworth as text
%        str2double(get(hObject,'String')) returns contents of HF_Butterworth as a double


% --- Executes during object creation, after setting all properties.
function HF_Butterworth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HF_Butterworth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Order of the Butterworth filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Order_Butterworth_Filter_Callback(hObject, eventdata, handles)
% hObject    handle to Order_Butterworth_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Order_Butterworth_Filter as text
%        str2double(get(hObject,'String')) returns contents of Order_Butterworth_Filter as a double


% --- Executes during object creation, after setting all properties.
function Order_Butterworth_Filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Order_Butterworth_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, data will be filtered
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Filter_Data_Check_Peaks_IHS.
function Filter_Data_Check_Peaks_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_Data_Check_Peaks_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Filter_Data_Check_Peaks_IHS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to extract information about the peaks of the clicks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Peak_Latency_IHS_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Peak_Latency_IHS_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Peak_latency_IHS_Help();
