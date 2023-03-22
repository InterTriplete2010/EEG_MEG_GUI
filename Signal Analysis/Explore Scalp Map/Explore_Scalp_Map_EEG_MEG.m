function varargout = Explore_Scalp_Map_EEG_MEG(varargin)
% EXPLORE_SCALP_MAP_EEG_MEG MATLAB code for Explore_Scalp_Map_EEG_MEG.fig
%      EXPLORE_SCALP_MAP_EEG_MEG, by itself, creates a new EXPLORE_SCALP_MAP_EEG_MEG or raises the existing
%      singleton*.
%
%      H = EXPLORE_SCALP_MAP_EEG_MEG returns the handle to a new EXPLORE_SCALP_MAP_EEG_MEG or the handle to
%      the existing singleton*.
%
%      EXPLORE_SCALP_MAP_EEG_MEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPLORE_SCALP_MAP_EEG_MEG.M with the given input arguments.
%
%      EXPLORE_SCALP_MAP_EEG_MEG('Property','Value',...) creates a new EXPLORE_SCALP_MAP_EEG_MEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Explore_Scalp_Map_EEG_MEG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Explore_Scalp_Map_EEG_MEG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Explore_Scalp_Map_EEG_MEG

% Last Modified by GUIDE v2.5 14-Jan-2022 13:37:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Explore_Scalp_Map_EEG_MEG_OpeningFcn, ...
                   'gui_OutputFcn',  @Explore_Scalp_Map_EEG_MEG_OutputFcn, ...
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


% --- Executes just before Explore_Scalp_Map_EEG_MEG is made visible.
function Explore_Scalp_Map_EEG_MEG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Explore_Scalp_Map_EEG_MEG (see VARARGIN)

% Choose default command line output for Explore_Scalp_Map_EEG_MEG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Explore_Scalp_Map_EEG_MEG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Explore_Scalp_Map_EEG_MEG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_File_Explore_Scalp_Map.
function Upload_File_Explore_Scalp_Map_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_File_Explore_Scalp_Map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

[Files_Mat_file_selected,Files_Mat_file_directory] = uigetfile('*.mat','Select the mat file');

cd(Files_Mat_file_directory)

set(handles.File_Uploaded_Explore_Scalp_Map,'String',Files_Mat_file_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File Uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Uploaded_Explore_Scalp_Map_Callback(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_Explore_Scalp_Map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Uploaded_Explore_Scalp_Map as text
%        str2double(get(hObject,'String')) returns contents of File_Uploaded_Explore_Scalp_Map as a double


% --- Executes during object creation, after setting all properties.
function File_Uploaded_Explore_Scalp_Map_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_Explore_Scalp_Map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select which scalp map to use: EEG or MEG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Explore_SM_Choice.
function Explore_SM_Choice_Callback(hObject, eventdata, handles)
% hObject    handle to Explore_SM_Choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Explore_SM_Choice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Explore_SM_Choice


% --- Executes during object creation, after setting all properties.
function Explore_SM_Choice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Explore_SM_Choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Explore the scalp map of the selected file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Explore_SM.
function Explore_SM_Callback(hObject, eventdata, handles)
% hObject    handle to Explore_SM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

scalp_map_EEG_MEG = get(handles.Explore_SM_Choice,'Value');
mouse_coordinate_real_time(Files_Mat_file_directory,Files_Mat_file_selected,scalp_map_EEG_MEG);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to explore the data with the
%Scalp Map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Explore_Scalp_Map_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Explore_Scalp_Map_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Explore_Scalp_Map_EEG_MEG_Help();
