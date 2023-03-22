function varargout = Band_Stop_Filter_FIR_Help(varargin)
% BAND_STOP_FILTER_FIR_HELP MATLAB code for Band_Stop_Filter_FIR_Help.fig
%      BAND_STOP_FILTER_FIR_HELP, by itself, creates a new BAND_STOP_FILTER_FIR_HELP or raises the existing
%      singleton*.
%
%      H = BAND_STOP_FILTER_FIR_HELP returns the handle to a new BAND_STOP_FILTER_FIR_HELP or the handle to
%      the existing singleton*.
%
%      BAND_STOP_FILTER_FIR_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BAND_STOP_FILTER_FIR_HELP.M with the given input arguments.
%
%      BAND_STOP_FILTER_FIR_HELP('Property','Value',...) creates a new BAND_STOP_FILTER_FIR_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Band_Stop_Filter_FIR_Help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Band_Stop_Filter_FIR_Help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Band_Stop_Filter_FIR_Help

% Last Modified by GUIDE v2.5 10-Feb-2022 13:53:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Band_Stop_Filter_FIR_Help_OpeningFcn, ...
                   'gui_OutputFcn',  @Band_Stop_Filter_FIR_Help_OutputFcn, ...
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


% --- Executes just before Band_Stop_Filter_FIR_Help is made visible.
function Band_Stop_Filter_FIR_Help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Band_Stop_Filter_FIR_Help (see VARARGIN)

% Choose default command line output for Band_Stop_Filter_FIR_Help
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Band_Stop_Filter_FIR_Help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Band_Stop_Filter_FIR_Help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI for the FIR BSF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Help_BSF_FIR_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Help_BSF_FIR_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Help_BSF_FIR_Edit as text
%        str2double(get(hObject,'String')) returns contents of Help_BSF_FIR_Edit as a double


% --- Executes during object creation, after setting all properties.
function Help_BSF_FIR_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Help_BSF_FIR_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
