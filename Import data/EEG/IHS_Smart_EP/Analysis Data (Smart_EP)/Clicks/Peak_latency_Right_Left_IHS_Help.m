function varargout = Peak_latency_Right_Left_IHS_Help(varargin)
% PEAK_LATENCY_RIGHT_LEFT_IHS_HELP MATLAB code for Peak_latency_Right_Left_IHS_Help.fig
%      PEAK_LATENCY_RIGHT_LEFT_IHS_HELP, by itself, creates a new PEAK_LATENCY_RIGHT_LEFT_IHS_HELP or raises the existing
%      singleton*.
%
%      H = PEAK_LATENCY_RIGHT_LEFT_IHS_HELP returns the handle to a new PEAK_LATENCY_RIGHT_LEFT_IHS_HELP or the handle to
%      the existing singleton*.
%
%      PEAK_LATENCY_RIGHT_LEFT_IHS_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PEAK_LATENCY_RIGHT_LEFT_IHS_HELP.M with the given input arguments.
%
%      PEAK_LATENCY_RIGHT_LEFT_IHS_HELP('Property','Value',...) creates a new PEAK_LATENCY_RIGHT_LEFT_IHS_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Peak_latency_Right_Left_IHS_Help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Peak_latency_Right_Left_IHS_Help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Peak_latency_Right_Left_IHS_Help

% Last Modified by GUIDE v2.5 13-Jan-2022 14:16:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Peak_latency_Right_Left_IHS_Help_OpeningFcn, ...
                   'gui_OutputFcn',  @Peak_latency_Right_Left_IHS_Help_OutputFcn, ...
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


% --- Executes just before Peak_latency_Right_Left_IHS_Help is made visible.
function Peak_latency_Right_Left_IHS_Help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Peak_latency_Right_Left_IHS_Help (see VARARGIN)

% Choose default command line output for Peak_latency_Right_Left_IHS_Help
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Peak_latency_Right_Left_IHS_Help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Peak_latency_Right_Left_IHS_Help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to extract the "left - right" ears
%latencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Peak_latency_Right_Left_IHS_Edit_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Peak_latency_Right_Left_IHS_Edit_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Peak_latency_Right_Left_IHS_Edit_Menu as text
%        str2double(get(hObject,'String')) returns contents of Peak_latency_Right_Left_IHS_Edit_Menu as a double


% --- Executes during object creation, after setting all properties.
function Peak_latency_Right_Left_IHS_Edit_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Peak_latency_Right_Left_IHS_Edit_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
