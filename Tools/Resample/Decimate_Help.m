function varargout = Decimate_Help(varargin)
% DECIMATE_HELP MATLAB code for Decimate_Help.fig
%      DECIMATE_HELP, by itself, creates a new DECIMATE_HELP or raises the existing
%      singleton*.
%
%      H = DECIMATE_HELP returns the handle to a new DECIMATE_HELP or the handle to
%      the existing singleton*.
%
%      DECIMATE_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECIMATE_HELP.M with the given input arguments.
%
%      DECIMATE_HELP('Property','Value',...) creates a new DECIMATE_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Decimate_Help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Decimate_Help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Decimate_Help

% Last Modified by GUIDE v2.5 22-Nov-2021 15:31:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Decimate_Help_OpeningFcn, ...
                   'gui_OutputFcn',  @Decimate_Help_OutputFcn, ...
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


% --- Executes just before Decimate_Help is made visible.
function Decimate_Help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Decimate_Help (see VARARGIN)

% Choose default command line output for Decimate_Help
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Decimate_Help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Decimate_Help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to decimate the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Help_Decimate_Editor_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Decimate_Editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Help_Decimate_Editor as text
%        str2double(get(hObject,'String')) returns contents of Help_Decimate_Editor as a double


% --- Executes during object creation, after setting all properties.
function Help_Decimate_Editor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Help_Decimate_Editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
