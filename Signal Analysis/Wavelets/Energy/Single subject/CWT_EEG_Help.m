function varargout = CWT_EEG_Help(varargin)
% CWT_EEG_HELP MATLAB code for CWT_EEG_Help.fig
%      CWT_EEG_HELP, by itself, creates a new CWT_EEG_HELP or raises the existing
%      singleton*.
%
%      H = CWT_EEG_HELP returns the handle to a new CWT_EEG_HELP or the handle to
%      the existing singleton*.
%
%      CWT_EEG_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CWT_EEG_HELP.M with the given input arguments.
%
%      CWT_EEG_HELP('Property','Value',...) creates a new CWT_EEG_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CWT_EEG_Help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CWT_EEG_Help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CWT_EEG_Help

% Last Modified by GUIDE v2.5 11-Feb-2022 10:10:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CWT_EEG_Help_OpeningFcn, ...
                   'gui_OutputFcn',  @CWT_EEG_Help_OutputFcn, ...
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


% --- Executes just before CWT_EEG_Help is made visible.
function CWT_EEG_Help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CWT_EEG_Help (see VARARGIN)

% Choose default command line output for CWT_EEG_Help
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CWT_EEG_Help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CWT_EEG_Help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to run the CWT analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Help_CWT_Energy_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Help_CWT_Energy_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Help_CWT_Energy_Edit as text
%        str2double(get(hObject,'String')) returns contents of Help_CWT_Energy_Edit as a double


% --- Executes during object creation, after setting all properties.
function Help_CWT_Energy_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Help_CWT_Energy_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
