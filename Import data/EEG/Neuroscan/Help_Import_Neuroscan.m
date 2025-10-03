function varargout = Help_Import_Neuroscan(varargin)
% HELP_IMPORT_NEUROSCAN MATLAB code for Help_Import_Neuroscan.fig
%      HELP_IMPORT_NEUROSCAN, by itself, creates a new HELP_IMPORT_NEUROSCAN or raises the existing
%      singleton*.
%
%      H = HELP_IMPORT_NEUROSCAN returns the handle to a new HELP_IMPORT_NEUROSCAN or the handle to
%      the existing singleton*.
%
%      HELP_IMPORT_NEUROSCAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HELP_IMPORT_NEUROSCAN.M with the given input arguments.
%
%      HELP_IMPORT_NEUROSCAN('Property','Value',...) creates a new HELP_IMPORT_NEUROSCAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Help_Import_Neuroscan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Help_Import_Neuroscan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Help_Import_Neuroscan

% Last Modified by GUIDE v2.5 27-Oct-2021 10:35:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Help_Import_Neuroscan_OpeningFcn, ...
                   'gui_OutputFcn',  @Help_Import_Neuroscan_OutputFcn, ...
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


% --- Executes just before Help_Import_Neuroscan is made visible.
function Help_Import_Neuroscan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Help_Import_Neuroscan (see VARARGIN)

% Choose default command line output for Help_Import_Neuroscan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Help_Import_Neuroscan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Help_Import_Neuroscan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to import Neuroscan data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Help_Import_Neuroscan_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Import_Neuroscan_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Help_Import_Neuroscan_Data as text
%        str2double(get(hObject,'String')) returns contents of Help_Import_Neuroscan_Data as a double


% --- Executes during object creation, after setting all properties.
function Help_Import_Neuroscan_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Help_Import_Neuroscan_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
