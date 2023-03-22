function varargout = Help_Corr(varargin)
% HELP_CORR MATLAB code for Help_Corr.fig
%      HELP_CORR, by itself, creates a new HELP_CORR or raises the existing
%      singleton*.
%
%      H = HELP_CORR returns the handle to a new HELP_CORR or the handle to
%      the existing singleton*.
%
%      HELP_CORR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HELP_CORR.M with the given input arguments.
%
%      HELP_CORR('Property','Value',...) creates a new HELP_CORR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Help_Corr_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Help_Corr_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Help_Corr

% Last Modified by GUIDE v2.5 10-Feb-2022 09:58:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Help_Corr_OpeningFcn, ...
                   'gui_OutputFcn',  @Help_Corr_OutputFcn, ...
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


% --- Executes just before Help_Corr is made visible.
function Help_Corr_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Help_Corr (see VARARGIN)

% Choose default command line output for Help_Corr
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Help_Corr wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Help_Corr_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to calculate the auto/cross-correlation
%and the RMS value 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Help_Corr_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Corr_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Help_Corr_Edit as text
%        str2double(get(hObject,'String')) returns contents of Help_Corr_Edit as a double


% --- Executes during object creation, after setting all properties.
function Help_Corr_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Help_Corr_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
