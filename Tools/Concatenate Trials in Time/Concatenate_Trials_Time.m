function varargout = Concatenate_Trials_Time(varargin)
% CONCATENATE_TRIALS_TIME MATLAB code for Concatenate_Trials_Time.fig
%      CONCATENATE_TRIALS_TIME, by itself, creates a new CONCATENATE_TRIALS_TIME or raises the existing
%      singleton*.
%
%      H = CONCATENATE_TRIALS_TIME returns the handle to a new CONCATENATE_TRIALS_TIME or the handle to
%      the existing singleton*.
%
%      CONCATENATE_TRIALS_TIME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONCATENATE_TRIALS_TIME.M with the given input arguments.
%
%      CONCATENATE_TRIALS_TIME('Property','Value',...) creates a new CONCATENATE_TRIALS_TIME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Concatenate_Trials_Time_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Concatenate_Trials_Time_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Concatenate_Trials_Time

% Last Modified by GUIDE v2.5 01-Feb-2022 15:51:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Concatenate_Trials_Time_OpeningFcn, ...
                   'gui_OutputFcn',  @Concatenate_Trials_Time_OutputFcn, ...
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


% --- Executes just before Concatenate_Trials_Time is made visible.
function Concatenate_Trials_Time_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Concatenate_Trials_Time (see VARARGIN)

% Choose default command line output for Concatenate_Trials_Time
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Concatenate_Trials_Time wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Concatenate_Trials_Time_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Concatenate the uploaded files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Conc_Trials_Time.
function Conc_Trials_Time_Callback(hObject, eventdata, handles)
% hObject    handle to Conc_Trials_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

concatenate_trials_time_function(Files_Mat_file_directory,Files_Mat_file_selected)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Files_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Files_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Files_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Dir_Files_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Dir_Files_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Files_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload Mat files to be concatenated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Files.
function Upload_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

[Files_Mat_file_selected,Files_Mat_file_directory] = uigetfile('*.mat','Select the mat file');

if(Files_Mat_file_selected == 0)
    
    set(handles.Dir_Files_Uploaded,'String','No File selected');
    
    
else
    
    set(handles.Dir_Files_Uploaded,'String',Files_Mat_file_directory);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to concatenate the trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Conc_Trials_Time_Help_Callback(hObject, eventdata, handles)
% hObject    handle to Conc_Trials_Time_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Concatenate_Trials_Time_Help();
