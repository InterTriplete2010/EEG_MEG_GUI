function varargout = MMN_GUI_Help(varargin)
% MMN_GUI_HELP MATLAB code for MMN_GUI_Help.fig
%      MMN_GUI_HELP, by itself, creates a new MMN_GUI_HELP or raises the existing
%      singleton*.
%
%      H = MMN_GUI_HELP returns the handle to a new MMN_GUI_HELP or the handle to
%      the existing singleton*.
%
%      MMN_GUI_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MMN_GUI_HELP.M with the given input arguments.
%
%      MMN_GUI_HELP('Property','Value',...) creates a new MMN_GUI_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MMN_GUI_Help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MMN_GUI_Help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MMN_GUI_Help

% Last Modified by GUIDE v2.5 12-May-2025 10:51:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MMN_GUI_Help_OpeningFcn, ...
                   'gui_OutputFcn',  @MMN_GUI_Help_OutputFcn, ...
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


% --- Executes just before MMN_GUI_Help is made visible.
function MMN_GUI_Help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MMN_GUI_Help (see VARARGIN)

% Choose default command line output for MMN_GUI_Help
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MMN_GUI_Help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MMN_GUI_Help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to calculate PCA components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function MMN_Help_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to MMN_Help_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MMN_Help_Edit as text
%        str2double(get(hObject,'String')) returns contents of MMN_Help_Edit as a double


% --- Executes during object creation, after setting all properties.
function MMN_Help_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MMN_Help_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
