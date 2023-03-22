function varargout = Regression_Line_GUI(varargin)
% REGRESSION_LINE_GUI MATLAB code for Regression_Line_GUI.fig
%      REGRESSION_LINE_GUI, by itself, creates a new REGRESSION_LINE_GUI or raises the existing
%      singleton*.
%
%      H = REGRESSION_LINE_GUI returns the handle to a new REGRESSION_LINE_GUI or the handle to
%      the existing singleton*.
%
%      REGRESSION_LINE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGRESSION_LINE_GUI.M with the given input arguments.
%
%      REGRESSION_LINE_GUI('Property','Value',...) creates a new REGRESSION_LINE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Regression_Line_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Regression_Line_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Regression_Line_GUI

% Last Modified by GUIDE v2.5 12-Jan-2022 12:12:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Regression_Line_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Regression_Line_GUI_OutputFcn, ...
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


% --- Executes just before Regression_Line_GUI is made visible.
function Regression_Line_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Regression_Line_GUI (see VARARGIN)

% Choose default command line output for Regression_Line_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Regression_Line_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Regression_Line_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select the type of correlation to be calculated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Corr_Type_LR.
function Corr_Type_LR_Callback(hObject, eventdata, handles)
% hObject    handle to Corr_Type_LR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Corr_Type_LR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Corr_Type_LR


% --- Executes during object creation, after setting all properties.
function Corr_Type_LR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Corr_Type_LR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate the selected correlation and plot the regression line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Regr_Line.
function Regr_Line_Callback(hObject, eventdata, handles)
% hObject    handle to Regr_Line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


corr_selected = get(handles.Corr_Type_LR,'Value');
regr_line_corr_function(corr_selected);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to create a regression line + correlation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Regression_Line_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Regression_Line_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
