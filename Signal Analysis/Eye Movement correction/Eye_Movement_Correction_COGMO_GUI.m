function varargout = Eye_Movement_Correction_COGMO_GUI(varargin)
% EYE_MOVEMENT_CORRECTION_COGMO_GUI M-file for Eye_Movement_Correction_COGMO_GUI.fig
%      EYE_MOVEMENT_CORRECTION_COGMO_GUI, by itself, creates a new EYE_MOVEMENT_CORRECTION_COGMO_GUI or raises the existing
%      singleton*.
%
%      H = EYE_MOVEMENT_CORRECTION_COGMO_GUI returns the handle to a new EYE_MOVEMENT_CORRECTION_COGMO_GUI or the handle to
%      the existing singleton*.
%
%      EYE_MOVEMENT_CORRECTION_COGMO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EYE_MOVEMENT_CORRECTION_COGMO_GUI.M with the given input arguments.
%
%      EYE_MOVEMENT_CORRECTION_COGMO_GUI('Property','Value',...) creates a new EYE_MOVEMENT_CORRECTION_COGMO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Eye_Movement_Correction_COGMO_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Eye_Movement_Correction_COGMO_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Eye_Movement_Correction_COGMO_GUI

% Last Modified by GUIDE v2.5 14-Jan-2022 16:12:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Eye_Movement_Correction_COGMO_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Eye_Movement_Correction_COGMO_GUI_OutputFcn, ...
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


% --- Executes just before Eye_Movement_Correction_COGMO_GUI is made visible.
function Eye_Movement_Correction_COGMO_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Eye_Movement_Correction_COGMO_GUI (see VARARGIN)

% Choose default command line output for Eye_Movement_Correction_COGMO_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Eye_Movement_Correction_COGMO_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Eye_Movement_Correction_COGMO_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Remove eye movement the uploaded files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Eye_Movement_Correction_Button_COGMO.
function Eye_Movement_Correction_Button_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Eye_Movement_Correction_Button_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;
global data_selected_weights;

cd(Files_Mat_file_directory)
eeg_to_be_corrected = load(Files_Mat_file_selected);

eeg_to_be_corrected_data = eeg_to_be_corrected.data_exported.eeg_data;
vertical_eye_selected = eeg_to_be_corrected.data_exported.eeg_data(get(handles.Vertical_Eye_Correction_COGMO,'Value'),:);
horizontal_eye_selected = eeg_to_be_corrected.data_exported.eeg_data(get(handles.Horizontal_Eye_Correction_COGMO,'Value'),:);

vertical_eye_selected_weights = data_selected_weights(get(handles.Vertical_Eye_Correction_COGMO,'Value'),:);
horizontal_eye_selected_weights = data_selected_weights(get(handles.Horizontal_Eye_Correction_COGMO,'Value'),:);

save_cleaned_eeg = eye_movement_correction_function_COGMO(eeg_to_be_corrected,eeg_to_be_corrected_data,vertical_eye_selected,horizontal_eye_selected,...
    vertical_eye_selected_weights,horizontal_eye_selected_weights,data_selected_weights);

%Saving the data
load(Files_Mat_file_selected)
data_exported.eeg_data = [];
data_exported.eeg_data = save_cleaned_eeg; 

save_eeg_folder = [Files_Mat_file_selected '_Eye_Red.mat'];

save (save_eeg_folder,'data_exported')

message = 'Eye movements have been removed and data have been saved';

        msgbox(message,'Eye movement correction','warn');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload Mat files to be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_File_Eye_Movement_Correction_COGMO.
function Upload_File_Eye_Movement_Correction_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_File_Eye_Movement_Correction_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

[Files_Mat_file_selected,Files_Mat_file_directory] = uigetfile('*.mat','Select the mat file');

cd(Files_Mat_file_directory)
load(Files_Mat_file_selected)

set(handles.Directory_Uploaded_Eye_Movement_Correction_COGMO,'String',Files_Mat_file_selected);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Directory_Uploaded_Eye_Movement_Correction_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_Eye_Movement_Correction_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Directory_Uploaded_Eye_Movement_Correction_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Directory_Uploaded_Eye_Movement_Correction_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Directory_Uploaded_Eye_Movement_Correction_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_Eye_Movement_Correction_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Vertical eye electrode for correction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Vertical_Eye_Correction_COGMO.
function Vertical_Eye_Correction_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Vertical_Eye_Correction_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Vertical_Eye_Correction_COGMO contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Vertical_Eye_Correction_COGMO


% --- Executes during object creation, after setting all properties.
function Vertical_Eye_Correction_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vertical_Eye_Correction_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Horizontal eye electrode for correction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Horizontal_Eye_Correction_COGMO.
function Horizontal_Eye_Correction_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Horizontal_Eye_Correction_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Horizontal_Eye_Correction_COGMO contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Horizontal_Eye_Correction_COGMO


% --- Executes during object creation, after setting all properties.
function Horizontal_Eye_Correction_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Horizontal_Eye_Correction_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the file to calculte the weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_file_weights.
function Upload_file_weights_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_file_weights (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data_selected_weights;

[Files_Mat_file_selected_weights,Files_Mat_file_directory_weights] = uigetfile('*.mat','Select the mat file');

cd(Files_Mat_file_directory_weights)
load(Files_Mat_file_selected_weights)

data_selected_weights = data_exported.eeg_data;

set(handles.File_Uploaded_Weights,'String',Files_Mat_file_selected_weights);
set(handles.Vertical_Eye_Correction_COGMO,'Value',1);
set(handles.Vertical_Eye_Correction_COGMO,'String',data_exported.labels);
set(handles.Horizontal_Eye_Correction_COGMO,'Value',1);
set(handles.Horizontal_Eye_Correction_COGMO,'String',data_exported.labels);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File to calculte the weights uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Uploaded_Weights_Callback(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_Weights (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Uploaded_Weights as text
%        str2double(get(hObject,'String')) returns contents of File_Uploaded_Weights as a double


% --- Executes during object creation, after setting all properties.
function File_Uploaded_Weights_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_Weights (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to reduced artifacts due to 
%eye-movement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Eye_Movement_Correction_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Eye_Movement_Correction_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Eye_Movement_Correction_COGMO_GUI_Help();
