function varargout = ICA_Entropy_Help(varargin)
% ICA_ENTROPY_HELP MATLAB code for ICA_Entropy_Help.fig
%      ICA_ENTROPY_HELP, by itself, creates a new ICA_ENTROPY_HELP or raises the existing
%      singleton*.
%
%      H = ICA_ENTROPY_HELP returns the handle to a new ICA_ENTROPY_HELP or the handle to
%      the existing singleton*.
%
%      ICA_ENTROPY_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICA_ENTROPY_HELP.M with the given input arguments.
%
%      ICA_ENTROPY_HELP('Property','Value',...) creates a new ICA_ENTROPY_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ICA_Entropy_Help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ICA_Entropy_Help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ICA_Entropy_Help

% Last Modified by GUIDE v2.5 10-Feb-2022 14:47:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ICA_Entropy_Help_OpeningFcn, ...
                   'gui_OutputFcn',  @ICA_Entropy_Help_OutputFcn, ...
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


% --- Executes just before ICA_Entropy_Help is made visible.
function ICA_Entropy_Help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ICA_Entropy_Help (see VARARGIN)

% Choose default command line output for ICA_Entropy_Help
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ICA_Entropy_Help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ICA_Entropy_Help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to run ICA based on Entropy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Help_ICA_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Help_ICA_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Help_ICA_Edit as text
%        str2double(get(hObject,'String')) returns contents of Help_ICA_Edit as a double


% --- Executes during object creation, after setting all properties.
function Help_ICA_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Help_ICA_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
