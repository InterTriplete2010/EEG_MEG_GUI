function varargout = CWT_PLF_Grand_Average_GUI(varargin)
% CWT_PLF_GRAND_AVERAGE_GUI MATLAB code for CWT_PLF_Grand_Average_GUI.fig
%      CWT_PLF_GRAND_AVERAGE_GUI, by itself, creates a new CWT_PLF_GRAND_AVERAGE_GUI or raises the existing
%      singleton*.
%
%      H = CWT_PLF_GRAND_AVERAGE_GUI returns the handle to a new CWT_PLF_GRAND_AVERAGE_GUI or the handle to
%      the existing singleton*.
%
%      CWT_PLF_GRAND_AVERAGE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CWT_PLF_GRAND_AVERAGE_GUI.M with the given input arguments.
%
%      CWT_PLF_GRAND_AVERAGE_GUI('Property','Value',...) creates a new CWT_PLF_GRAND_AVERAGE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CWT_PLF_Grand_Average_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CWT_PLF_Grand_Average_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CWT_PLF_Grand_Average_GUI

% Last Modified by GUIDE v2.5 15-Feb-2022 11:55:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CWT_PLF_Grand_Average_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CWT_PLF_Grand_Average_GUI_OutputFcn, ...
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


% --- Executes just before CWT_PLF_Grand_Average_GUI is made visible.
function CWT_PLF_Grand_Average_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CWT_PLF_Grand_Average_GUI (see VARARGIN)

% Choose default command line output for CWT_PLF_Grand_Average_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CWT_PLF_Grand_Average_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CWT_PLF_Grand_Average_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Av_Files_PLF.
function Av_Files_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Av_Files_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_PLF_selected;
global Files_PLF_directory;

freq_bin = str2double(get(handles.Freq_Bin_PLF,'String'));
freq_range = str2num(get(handles.Frequencies_PLF,'String'));

start_point_t = str2double(get(handles.Start_T_PLF,'String'));
end_point_t = str2double(get(handles.End_T_PLF,'String'));

start_point_ss = str2double(get(handles.Start_SS_PLF,'String'));
end_point_ss = str2double(get(handles.End_SS_PLF,'String'));

CWT_PLF_Grand_Average_Function(Files_PLF_directory,freq_bin,freq_range,start_point_t,end_point_t,start_point_ss,end_point_ss)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory with the files to be averaged
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_Av_PLF.
function Upload_Dir_Av_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_Av_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_PLF_selected;
global Files_PLF_directory;

[Files_PLF_selected,Files_PLF_directory] = uigetfile('*.mat','Select the mat file');

set(handles.Dir_Av_PLF_Uploaded,'String',Files_PLF_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Av_PLF_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Av_PLF_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Av_PLF_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Dir_Av_PLF_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Dir_Av_PLF_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Av_PLF_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Frequency bin for the PLF analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Freq_Bin_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Freq_Bin_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Freq_Bin_PLF as text
%        str2double(get(hObject,'String')) returns contents of Freq_Bin_PLF as a double


% --- Executes during object creation, after setting all properties.
function Freq_Bin_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Freq_Bin_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Frequency interval for the PLF analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Frequencies_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Frequencies_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Frequencies_PLF as text
%        str2double(get(hObject,'String')) returns contents of Frequencies_PLF as a double


% --- Executes during object creation, after setting all properties.
function Frequencies_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Frequencies_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End analysis for the Transition region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_T_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to End_T_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_T_PLF as text
%        str2double(get(hObject,'String')) returns contents of End_T_PLF as a double


% --- Executes during object creation, after setting all properties.
function End_T_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_T_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start analysis for the Transition region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_SS_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Start_SS_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_SS_PLF as text
%        str2double(get(hObject,'String')) returns contents of Start_SS_PLF as a double


% --- Executes during object creation, after setting all properties.
function Start_SS_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_SS_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End analysis for the Steady-State region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_SS_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to End_SS_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_SS_PLF as text
%        str2double(get(hObject,'String')) returns contents of End_SS_PLF as a double


% --- Executes during object creation, after setting all properties.
function End_SS_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_SS_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start analysis for the Steady-State region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_T_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Start_T_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_T_PLF as text
%        str2double(get(hObject,'String')) returns contents of Start_T_PLF as a double


% --- Executes during object creation, after setting all properties.
function Start_T_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_T_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select which data to average
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in PLF_Grand_Av_FFR_Cortex.
function PLF_Grand_Av_FFR_Cortex_Callback(hObject, eventdata, handles)
% hObject    handle to PLF_Grand_Av_FFR_Cortex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PLF_Grand_Av_FFR_Cortex contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PLF_Grand_Av_FFR_Cortex

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to calculate the average of the PLF
%files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_PLF_Average_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_PLF_Average_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CWT_PLF_Grand_Average_GUI_Help();