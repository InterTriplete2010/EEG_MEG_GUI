function varargout = Corr_IHS_Averages_Help(varargin)
% CORR_IHS_AVERAGES_HELP MATLAB code for Corr_IHS_Averages_Help.fig
%      CORR_IHS_AVERAGES_HELP, by itself, creates a new CORR_IHS_AVERAGES_HELP or raises the existing
%      singleton*.
%
%      H = CORR_IHS_AVERAGES_HELP returns the handle to a new CORR_IHS_AVERAGES_HELP or the handle to
%      the existing singleton*.
%
%      CORR_IHS_AVERAGES_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CORR_IHS_AVERAGES_HELP.M with the given input arguments.
%
%      CORR_IHS_AVERAGES_HELP('Property','Value',...) creates a new CORR_IHS_AVERAGES_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Corr_IHS_Averages_Help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Corr_IHS_Averages_Help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Corr_IHS_Averages_Help

% Last Modified by GUIDE v2.5 13-Jan-2022 12:42:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Corr_IHS_Averages_Help_OpeningFcn, ...
                   'gui_OutputFcn',  @Corr_IHS_Averages_Help_OutputFcn, ...
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


% --- Executes just before Corr_IHS_Averages_Help is made visible.
function Corr_IHS_Averages_Help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Corr_IHS_Averages_Help (see VARARGIN)

% Choose default command line output for Corr_IHS_Averages_Help
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Corr_IHS_Averages_Help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Corr_IHS_Averages_Help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to calculate the correlation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Corr_Average_Edit_Help_Callback(hObject, eventdata, handles)
% hObject    handle to Corr_Average_Edit_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Corr_Average_Edit_Help as text
%        str2double(get(hObject,'String')) returns contents of Corr_Average_Edit_Help as a double


% --- Executes during object creation, after setting all properties.
function Corr_Average_Edit_Help_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Corr_Average_Edit_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
