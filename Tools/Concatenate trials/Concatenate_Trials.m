function varargout = Concatenate_Trials(varargin)
% CONCATENATE_TRIALS M-file for Concatenate_Trials.fig
%      CONCATENATE_TRIALS, by itself, creates a new CONCATENATE_TRIALS or raises the existing
%      singleton*.
%
%      H = CONCATENATE_TRIALS returns the handle to a new CONCATENATE_TRIALS or the handle to
%      the existing singleton*.
%
%      CONCATENATE_TRIALS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONCATENATE_TRIALS.M with the given input arguments.
%
%      CONCATENATE_TRIALS('Property','Value',...) creates a new CONCATENATE_TRIALS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Concatenate_Trials_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Concatenate_Trials_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Concatenate_Trials

% Last Modified by GUIDE v2.5 14-Oct-2025 12:49:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Concatenate_Trials_OpeningFcn, ...
                   'gui_OutputFcn',  @Concatenate_Trials_OutputFcn, ...
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


% --- Executes just before Concatenate_Trials is made visible.
function Concatenate_Trials_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Concatenate_Trials (see VARARGIN)

% Choose default command line output for Concatenate_Trials
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Concatenate_Trials wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Concatenate_Trials_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Concatenate the uploaded files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Conc_Trials.
function Conc_Trials_Callback(hObject, eventdata, handles)
% hObject    handle to Conc_Trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

concatenate_choice = get(handles.Concatenate_Cortical_FFR,'Value'); 

if (concatenate_choice == 1)
    
    concatenate_trials_function_cortical(Files_Mat_file_directory,Files_Mat_file_selected)
    
else
    
    concatenate_trials_function(Files_Mat_file_directory,Files_Mat_file_selected)
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload Mat files to be concatenated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_Conc.
function Upload_Dir_Conc_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_Conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

[Files_Mat_file_selected,Files_Mat_file_directory] = uigetfile('*.mat','Select the mat file');

set(handles.Directory_Uploaded_Conc,'String',Files_Mat_file_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Directory_Uploaded_Conc_Callback(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_Conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Directory_Uploaded_Conc as text
%        str2double(get(hObject,'String')) returns contents of Directory_Uploaded_Conc as a double


% --- Executes during object creation, after setting all properties.
function Directory_Uploaded_Conc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_Conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to concatenate the trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Concatenate_Trials_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Concatenate_Trials_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Concatenate_Trials_Help();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose if concatenate trials extracted with the FFR GUI or with the
%"Extract trials" GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Concatenate_Cortical_FFR.
function Concatenate_Cortical_FFR_Callback(hObject, eventdata, handles)
% hObject    handle to Concatenate_Cortical_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Concatenate_Cortical_FFR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Concatenate_Cortical_FFR


% --- Executes during object creation, after setting all properties.
function Concatenate_Cortical_FFR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Concatenate_Cortical_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
