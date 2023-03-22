function varargout = Comb_Notch_Filter_Help(varargin)
% COMB_NOTCH_FILTER_HELP MATLAB code for Comb_Notch_Filter_Help.fig
%      COMB_NOTCH_FILTER_HELP, by itself, creates a new COMB_NOTCH_FILTER_HELP or raises the existing
%      singleton*.
%
%      H = COMB_NOTCH_FILTER_HELP returns the handle to a new COMB_NOTCH_FILTER_HELP or the handle to
%      the existing singleton*.
%
%      COMB_NOTCH_FILTER_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMB_NOTCH_FILTER_HELP.M with the given input arguments.
%
%      COMB_NOTCH_FILTER_HELP('Property','Value',...) creates a new COMB_NOTCH_FILTER_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Comb_Notch_Filter_Help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Comb_Notch_Filter_Help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Comb_Notch_Filter_Help

% Last Modified by GUIDE v2.5 10-Feb-2022 13:22:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Comb_Notch_Filter_Help_OpeningFcn, ...
                   'gui_OutputFcn',  @Comb_Notch_Filter_Help_OutputFcn, ...
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


% --- Executes just before Comb_Notch_Filter_Help is made visible.
function Comb_Notch_Filter_Help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Comb_Notch_Filter_Help (see VARARGIN)

% Choose default command line output for Comb_Notch_Filter_Help
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Comb_Notch_Filter_Help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Comb_Notch_Filter_Help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI for the IIR Comb Notch Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Help_Comb_Notch_Filter_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Comb_Notch_Filter_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Help_Comb_Notch_Filter_Edit as text
%        str2double(get(hObject,'String')) returns contents of Help_Comb_Notch_Filter_Edit as a double


% --- Executes during object creation, after setting all properties.
function Help_Comb_Notch_Filter_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Help_Comb_Notch_Filter_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
