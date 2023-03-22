function varargout = Peak_latency_Right_Left_IHS_GUI(varargin)
% PEAK_LATENCY_RIGHT_LEFT_IHS_GUI MATLAB code for Peak_latency_Right_Left_IHS_GUI.fig
%      PEAK_LATENCY_RIGHT_LEFT_IHS_GUI, by itself, creates a new PEAK_LATENCY_RIGHT_LEFT_IHS_GUI or raises the existing
%      singleton*.
%
%      H = PEAK_LATENCY_RIGHT_LEFT_IHS_GUI returns the handle to a new PEAK_LATENCY_RIGHT_LEFT_IHS_GUI or the handle to
%      the existing singleton*.
%
%      PEAK_LATENCY_RIGHT_LEFT_IHS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEAK_LATENCY_RIGHT_LEFT_IHS_GUI.M with the given input arguments.
%
%      PEAK_LATENCY_RIGHT_LEFT_IHS_GUI('Property','Value',...) creates a new PEAK_LATENCY_RIGHT_LEFT_IHS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Peak_latency_Right_Left_IHS_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Peak_latency_Right_Left_IHS_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Peak_latency_Right_Left_IHS_GUI

% Last Modified by GUIDE v2.5 13-Jan-2022 14:26:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Peak_latency_Right_Left_IHS_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Peak_latency_Right_Left_IHS_GUI_OutputFcn, ...
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


% --- Executes just before Peak_latency_Right_Left_IHS_GUI is made visible.
function Peak_latency_Right_Left_IHS_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Peak_latency_Right_Left_IHS_GUI (see VARARGIN)

% Choose default command line output for Peak_latency_Right_Left_IHS_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Peak_latency_Right_Left_IHS_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Peak_latency_Right_Left_IHS_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Right Ear chosen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Uploaded_Peak_Latency_Right_Ear_Callback(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_Peak_Latency_Right_Ear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Uploaded_Peak_Latency_Right_Ear as text
%        str2double(get(hObject,'String')) returns contents of File_Uploaded_Peak_Latency_Right_Ear as a double


% --- Executes during object creation, after setting all properties.
function File_Uploaded_Peak_Latency_Right_Ear_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_Peak_Latency_Right_Ear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose the Right Ear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_File_Peak_Latency_Right_Ear.
function Upload_File_Peak_Latency_Right_Ear_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_File_Peak_Latency_Right_Ear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IHS_file_directory_Right;
global IHS_file_selected_Right;

[IHS_file_selected_Right,IHS_file_directory_Right] = uigetfile('*.mat','Select the Right Ear');

set(handles.File_Uploaded_Peak_Latency_Right_Ear,'String',IHS_file_selected_Right);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract the peaks and latencies of the difference between right and left
%ears
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extract_Peak_Latency_IHS.
function Extract_Peak_Latency_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Peak_Latency_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IHS_file_directory_Right;
global IHS_file_selected_Right;
global IHS_file_directory_Left;
global IHS_file_selected_Left;

lf_buttw_filt = str2double(get(handles.LPC_LR_Clicks,'String'));
hf_buttw_filt = str2double(get(handles.HPC_LR_Clicks,'String'));
order_buttw_filt = str2double(get(handles.Order_LR_Clicks,'String'));

check_filter = get(handles.Filter_Data_LR_Clicks,'Value');

extract_peaks_latency_function_right_left_ear(IHS_file_directory_Right,IHS_file_selected_Right,IHS_file_directory_Left,IHS_file_selected_Left,lf_buttw_filt,hf_buttw_filt,order_buttw_filt,check_filter)

message = 'Peaks and latencies have been calculated and saved';

        msgbox(message,'Analysis completed','warn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Left Ear chosen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Uploaded_Peak_Latency_Left_Ear_Callback(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_Peak_Latency_Left_Ear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Uploaded_Peak_Latency_Left_Ear as text
%        str2double(get(hObject,'String')) returns contents of File_Uploaded_Peak_Latency_Left_Ear as a double


% --- Executes during object creation, after setting all properties.
function File_Uploaded_Peak_Latency_Left_Ear_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_Peak_Latency_Left_Ear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose the Left Ear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_File_Peak_Latency_Left_Ear.
function Upload_File_Peak_Latency_Left_Ear_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_File_Peak_Latency_Left_Ear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IHS_file_directory_Left;
global IHS_file_selected_Left;

[IHS_file_selected_Left,IHS_file_directory_Left] = uigetfile('*.mat','Select the Left Ear');

set(handles.File_Uploaded_Peak_Latency_Left_Ear,'String',IHS_file_selected_Left);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to extract information about the peaks of the 
%"left - right ear clicks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Peak_Latency_Right_Left_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Peak_Latency_Right_Left_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Peak_latency_Right_Left_IHS_Help();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%High-Pass cut-off frequency of the filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function HPC_LR_Clicks_Callback(hObject, eventdata, handles)
% hObject    handle to HPC_LR_Clicks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HPC_LR_Clicks as text
%        str2double(get(hObject,'String')) returns contents of HPC_LR_Clicks as a double


% --- Executes during object creation, after setting all properties.
function HPC_LR_Clicks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HPC_LR_Clicks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Low-Pass cut-off frequency of the filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function LPC_LR_Clicks_Callback(hObject, eventdata, handles)
% hObject    handle to LPC_LR_Clicks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LPC_LR_Clicks as text
%        str2double(get(hObject,'String')) returns contents of LPC_LR_Clicks as a double


% --- Executes during object creation, after setting all properties.
function LPC_LR_Clicks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LPC_LR_Clicks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Order of the filter of the filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Order_LR_Clicks_Callback(hObject, eventdata, handles)
% hObject    handle to Order_LR_Clicks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Order_LR_Clicks as text
%        str2double(get(hObject,'String')) returns contents of Order_LR_Clicks as a double


% --- Executes during object creation, after setting all properties.
function Order_LR_Clicks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Order_LR_Clicks (see GCBO)
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
% --- Executes on button press in Filter_Data_LR_Clicks.
function Filter_Data_LR_Clicks_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_Data_LR_Clicks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Filter_Data_LR_Clicks
