function varargout = Merge_Raw_Data_GUI(varargin)
% MERGE_RAW_DATA_GUI M-file for Merge_Raw_Data_GUI.fig
%      MERGE_RAW_DATA_GUI, by itself, creates a new MERGE_RAW_DATA_GUI or raises the existing
%      singleton*.
%
%      H = MERGE_RAW_DATA_GUI returns the handle to a new MERGE_RAW_DATA_GUI or the handle to
%      the existing singleton*.
%
%      MERGE_RAW_DATA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MERGE_RAW_DATA_GUI.M with the given input arguments.
%
%      MERGE_RAW_DATA_GUI('Property','Value',...) creates a new MERGE_RAW_DATA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Merge_Raw_Data_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Merge_Raw_Data_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Merge_Raw_Data_GUI

% Last Modified by GUIDE v2.5 12-Jan-2022 11:16:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Merge_Raw_Data_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Merge_Raw_Data_GUI_OutputFcn, ...
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


% --- Executes just before Merge_Raw_Data_GUI is made visible.
function Merge_Raw_Data_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Merge_Raw_Data_GUI (see VARARGIN)

% Choose default command line output for Merge_Raw_Data_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Merge_Raw_Data_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Merge_Raw_Data_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Merge the uploaded files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Merge_Raw_Data_Button.
function Merge_Raw_Data_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Merge_Raw_Data_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Raw_data_file_directory;

new_merged_file_name = get(handles.Merged_Files_Name,'String');

Merge_Raw_Data_Function(Raw_data_file_directory,new_merged_file_name)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload Mat files to be merged
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Directory_Merge_Raw_Data.
function Upload_Directory_Merge_Raw_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Directory_Merge_Raw_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Raw_data_file_directory;

[Raw_data_file_selected,Raw_data_file_directory] = uigetfile('*.mat','Select the mat file');

if (Raw_data_file_selected == 0)
    
    set(handles.Directory_Uploaded_Merge_Raw_Data,'String','No File Selected');
    
else
    
    set(handles.Directory_Uploaded_Merge_Raw_Data,'String',Raw_data_file_directory);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Directory_Uploaded_Merge_Raw_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_Merge_Raw_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Directory_Uploaded_Merge_Raw_Data as text
%        str2double(get(hObject,'String')) returns contents of Directory_Uploaded_Merge_Raw_Data as a double


% --- Executes during object creation, after setting all properties.
function Directory_Uploaded_Merge_Raw_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_Merge_Raw_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the merged file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Merged_Files_Name_Callback(hObject, eventdata, handles)
% hObject    handle to Merged_Files_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Merged_Files_Name as text
%        str2double(get(hObject,'String')) returns contents of Merged_Files_Name as a double


% --- Executes during object creation, after setting all properties.
function Merged_Files_Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Merged_Files_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu of how to use the GUI to merge the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Merge_Raw_Data_Help_Callback(hObject, eventdata, handles)
% hObject    handle to Merge_Raw_Data_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Merge_Raw_Data_Help();
