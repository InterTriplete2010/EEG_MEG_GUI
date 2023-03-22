function varargout = GFP_GUI(varargin)
% GFP_GUI MATLAB code for GFP_GUI.fig
%      GFP_GUI, by itself, creates a new GFP_GUI or raises the existing
%      singleton*.
%
%      H = GFP_GUI returns the handle to a new GFP_GUI or the handle to
%      the existing singleton*.
%
%      GFP_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GFP_GUI.M with the given input arguments.
%
%      GFP_GUI('Property','Value',...) creates a new GFP_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GFP_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GFP_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GFP_GUI

% Last Modified by GUIDE v2.5 03-Feb-2022 12:12:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GFP_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GFP_GUI_OutputFcn, ...
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


% --- Executes just before GFP_GUI is made visible.
function GFP_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GFP_GUI (see VARARGIN)

% Choose default command line output for GFP_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GFP_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GFP_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in GFP_Cort.
function GFP_Cort_Callback(hObject, eventdata, handles)
% hObject    handle to GFP_Cort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GFP_Mat_file_selected;
global GFP_Mat_file_directory;

GFP_function_Cortical(GFP_Mat_file_directory,GFP_Mat_file_selected)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory with the files to be averaged
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_GFP_Cortical.
function Upload_Dir_GFP_Cortical_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_GFP_Cortical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GFP_Mat_file_selected;
global GFP_Mat_file_directory;

[GFP_Mat_file_selected,GFP_Mat_file_directory] = uigetfile('*.mat','Select the mat file');

if(GFP_Mat_file_directory == 0)

    set(handles.Dir_GFP_Cortical_Uploaded,'String','No File selected');
    
else

    set(handles.Dir_GFP_Cortical_Uploaded,'String',GFP_Mat_file_directory);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_GFP_Cortical_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_GFP_Cortical_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_GFP_Cortical_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Dir_GFP_Cortical_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Dir_GFP_Cortical_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_GFP_Cortical_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to calculate the GFP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_GFP_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_GFP_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GFP_GUI_Help();
