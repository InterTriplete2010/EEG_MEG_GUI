function varargout = Help_Import_Brain_Vision(varargin)
% HELP_IMPORT_BRAIN_VISION MATLAB code for Help_Import_Brain_Vision.fig
%      HELP_IMPORT_BRAIN_VISION, by itself, creates a new HELP_IMPORT_BRAIN_VISION or raises the existing
%      singleton*.
%
%      H = HELP_IMPORT_BRAIN_VISION returns the handle to a new HELP_IMPORT_BRAIN_VISION or the handle to
%      the existing singleton*.
%
%      HELP_IMPORT_BRAIN_VISION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HELP_IMPORT_BRAIN_VISION.M with the given input arguments.
%
%      HELP_IMPORT_BRAIN_VISION('Property','Value',...) creates a new HELP_IMPORT_BRAIN_VISION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Help_Import_Brain_Vision_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Help_Import_Brain_Vision_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Help_Import_Brain_Vision

% Last Modified by GUIDE v2.5 27-Oct-2021 09:56:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Help_Import_Brain_Vision_OpeningFcn, ...
                   'gui_OutputFcn',  @Help_Import_Brain_Vision_OutputFcn, ...
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


% --- Executes just before Help_Import_Brain_Vision is made visible.
function Help_Import_Brain_Vision_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Help_Import_Brain_Vision (see VARARGIN)

% Choose default command line output for Help_Import_Brain_Vision
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Help_Import_Brain_Vision wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Help_Import_Brain_Vision_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to import Brain Vision data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Help_Import_Brain_Vision_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Import_Brain_Vision_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Help_Import_Brain_Vision_Data as text
%        str2double(get(hObject,'String')) returns contents of Help_Import_Brain_Vision_Data as a double


% --- Executes during object creation, after setting all properties.
function Help_Import_Brain_Vision_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Help_Import_Brain_Vision_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
