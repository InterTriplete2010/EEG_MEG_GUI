function varargout = Average_Files_Cortical_GUI(varargin)
% AVERAGE_FILES_CORTICAL_GUI MATLAB code for Average_Files_Cortical_GUI.fig
%      AVERAGE_FILES_CORTICAL_GUI, by itself, creates a new AVERAGE_FILES_CORTICAL_GUI or raises the existing
%      singleton*.
%
%      H = AVERAGE_FILES_CORTICAL_GUI returns the handle to a new AVERAGE_FILES_CORTICAL_GUI or the handle to
%      the existing singleton*.
%
%      AVERAGE_FILES_CORTICAL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AVERAGE_FILES_CORTICAL_GUI.M with the given input arguments.
%
%      AVERAGE_FILES_CORTICAL_GUI('Property','Value',...) creates a new AVERAGE_FILES_CORTICAL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Average_Files_Cortical_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Average_Files_Cortical_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Average_Files_Cortical_GUI

% Last Modified by GUIDE v2.5 14-Jan-2022 10:59:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Average_Files_Cortical_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Average_Files_Cortical_GUI_OutputFcn, ...
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


% --- Executes just before Average_Files_Cortical_GUI is made visible.
function Average_Files_Cortical_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Average_Files_Cortical_GUI (see VARARGIN)

% Choose default command line output for Average_Files_Cortical_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Average_Files_Cortical_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Average_Files_Cortical_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Average the files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Av_Files_Cort.
function Av_Files_Cort_Callback(hObject, eventdata, handles)
% hObject    handle to Av_Files_Cort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

standardized_data_check = get(handles.STD_Grand_Average_Cortical,'Value');
fft_check = get(handles.FFT_Av_Cortex,'Value');

average_trials_function_Cortical(Files_Mat_file_directory,Files_Mat_file_selected,standardized_data_check,fft_check)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory with the files to be averaged
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_Av_Cortical.
function Upload_Dir_Av_Cortical_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_Av_Cortical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

[Files_Mat_file_selected,Files_Mat_file_directory] = uigetfile('*.mat','Select the mat file');

set(handles.Dir_Av_Cortical_Uploaded,'String',Files_Mat_file_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Av_Cortical_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Av_Cortical_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Av_Cortical_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Dir_Av_Cortical_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Dir_Av_Cortical_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Av_Cortical_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Standardize the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in STD_Grand_Average_Cortical.
function STD_Grand_Average_Cortical_Callback(hObject, eventdata, handles)
% hObject    handle to STD_Grand_Average_Cortical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of STD_Grand_Average_Cortical


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, FFT will be calculated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in FFT_Av_Cortex.
function FFT_Av_Cortex_Callback(hObject, eventdata, handles)
% hObject    handle to FFT_Av_Cortex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FFT_Av_Cortex

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to average cortical data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Average_Files_Cortical_GUI_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Average_Files_Cortical_GUI_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Average_File_Cortical_GUI_Help();
