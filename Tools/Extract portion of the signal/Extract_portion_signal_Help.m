function varargout = Extract_portion_signal_Help(varargin)
% EXTRACT_PORTION_SIGNAL_HELP MATLAB code for Extract_portion_signal_Help.fig
%      EXTRACT_PORTION_SIGNAL_HELP, by itself, creates a new EXTRACT_PORTION_SIGNAL_HELP or raises the existing
%      singleton*.
%
%      H = EXTRACT_PORTION_SIGNAL_HELP returns the handle to a new EXTRACT_PORTION_SIGNAL_HELP or the handle to
%      the existing singleton*.
%
%      EXTRACT_PORTION_SIGNAL_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACT_PORTION_SIGNAL_HELP.M with the given input arguments.
%
%      EXTRACT_PORTION_SIGNAL_HELP('Property','Value',...) creates a new EXTRACT_PORTION_SIGNAL_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Extract_portion_signal_Help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Extract_portion_signal_Help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Extract_portion_signal_Help

% Last Modified by GUIDE v2.5 12-Jan-2022 11:09:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Extract_portion_signal_Help_OpeningFcn, ...
                   'gui_OutputFcn',  @Extract_portion_signal_Help_OutputFcn, ...
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


% --- Executes just before Extract_portion_signal_Help is made visible.
function Extract_portion_signal_Help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Extract_portion_signal_Help (see VARARGIN)

% Choose default command line output for Extract_portion_signal_Help
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Extract_portion_signal_Help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Extract_portion_signal_Help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to extract the portion of the signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Extract_Portion_Edit_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Portion_Edit_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Extract_Portion_Edit_Menu as text
%        str2double(get(hObject,'String')) returns contents of Extract_Portion_Edit_Menu as a double


% --- Executes during object creation, after setting all properties.
function Extract_Portion_Edit_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Extract_Portion_Edit_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
