function varargout = Average_Trials_COGMO_GUI(varargin)
% AVERAGE_TRIALS_COGMO_GUI M-file for Average_Trials_COGMO_GUI.fig
%      AVERAGE_TRIALS_COGMO_GUI, by itself, creates a new AVERAGE_TRIALS_COGMO_GUI or raises the existing
%      singleton*.
%
%      H = AVERAGE_TRIALS_COGMO_GUI returns the handle to a new AVERAGE_TRIALS_COGMO_GUI or the handle to
%      the existing singleton*.
%
%      AVERAGE_TRIALS_COGMO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AVERAGE_TRIALS_COGMO_GUI.M with the given input arguments.
%
%      AVERAGE_TRIALS_COGMO_GUI('Property','Value',...) creates a new AVERAGE_TRIALS_COGMO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Average_Trials_COGMO_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Average_Trials_COGMO_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Average_Trials_COGMO_GUI

% Last Modified by GUIDE v2.5 10-Feb-2022 13:01:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Average_Trials_COGMO_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Average_Trials_COGMO_GUI_OutputFcn, ...
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


% --- Executes just before Average_Trials_COGMO_GUI is made visible.
function Average_Trials_COGMO_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Average_Trials_COGMO_GUI (see VARARGIN)

% Choose default command line output for Average_Trials_COGMO_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Average_Trials_COGMO_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Average_Trials_COGMO_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Average the uploaded files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Average_Files_Selected_COGMO.
function Average_Files_Selected_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Average_Files_Selected_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

standardized_data_check = get(handles.STD_Grand_Average_COGMO,'Value');

start_whole_resp = str2double(get(handles.Start_Whole,'String'));
end_whole_resp = str2double(get(handles.End_Whole,'String'));

start_tran = str2double(get(handles.Start_Trans_Grad_Av_FFR,'String'));
end_tran = str2double(get(handles.End_Trans_Grad_Av_FFR,'String'));

start_ss = str2double(get(handles.Start_SS_Grad_Av_FFR,'String'));
end_ss = str2double(get(handles.End_SS_Grad_Av_FFR,'String'));

average_trials_function_FFR(Files_Mat_file_directory,Files_Mat_file_selected,standardized_data_check,...
    start_whole_resp,end_whole_resp,start_tran,end_tran,start_ss,end_ss)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload Mat files to be averaged
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Directory_Average_Trials_COGMO.
function Upload_Directory_Average_Trials_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Directory_Average_Trials_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

[Files_Mat_file_selected,Files_Mat_file_directory] = uigetfile('*.mat','Select the mat file');

set(handles.Directory_Uploaded_Average_Trials_COGMO,'String',Files_Mat_file_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Directory_Uploaded_Average_Trials_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_Average_Trials_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Directory_Uploaded_Average_Trials_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Directory_Uploaded_Average_Trials_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Directory_Uploaded_Average_Trials_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_Average_Trials_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the grand average will be standardized
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in STD_Grand_Average_COGMO.
function STD_Grand_Average_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to STD_Grand_Average_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of STD_Grand_Average_COGMO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start point of the steady-state region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_SS_Grad_Av_FFR_Callback(hObject, eventdata, handles)
% hObject    handle to Start_SS_Grad_Av_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_SS_Grad_Av_FFR as text
%        str2double(get(hObject,'String')) returns contents of Start_SS_Grad_Av_FFR as a double


% --- Executes during object creation, after setting all properties.
function Start_SS_Grad_Av_FFR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_SS_Grad_Av_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End point of the steady-state region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_SS_Grad_Av_FFR_Callback(hObject, eventdata, handles)
% hObject    handle to End_SS_Grad_Av_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_SS_Grad_Av_FFR as text
%        str2double(get(hObject,'String')) returns contents of End_SS_Grad_Av_FFR as a double


% --- Executes during object creation, after setting all properties.
function End_SS_Grad_Av_FFR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_SS_Grad_Av_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start point of the transition region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_Trans_Grad_Av_FFR_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Trans_Grad_Av_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_Trans_Grad_Av_FFR as text
%        str2double(get(hObject,'String')) returns contents of Start_Trans_Grad_Av_FFR as a double


% --- Executes during object creation, after setting all properties.
function Start_Trans_Grad_Av_FFR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_Trans_Grad_Av_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End point of the transition region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_Trans_Grad_Av_FFR_Callback(hObject, eventdata, handles)
% hObject    handle to End_Trans_Grad_Av_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Trans_Grad_Av_FFR as text
%        str2double(get(hObject,'String')) returns contents of End_Trans_Grad_Av_FFR as a double


% --- Executes during object creation, after setting all properties.
function End_Trans_Grad_Av_FFR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Trans_Grad_Av_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start point for the whole response
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_Whole_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Whole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_Whole as text
%        str2double(get(hObject,'String')) returns contents of Start_Whole as a double


% --- Executes during object creation, after setting all properties.
function Start_Whole_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_Whole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End point for the whole response
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_Whole_Callback(hObject, eventdata, handles)
% hObject    handle to End_Whole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Whole as text
%        str2double(get(hObject,'String')) returns contents of End_Whole as a double


% --- Executes during object creation, after setting all properties.
function End_Whole_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Whole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to average the FFR files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Average_Files_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Average_Files_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Average_Trials_COGMO_GUI_Help();
