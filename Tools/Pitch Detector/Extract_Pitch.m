function varargout = Extract_Pitch(varargin)
% EXTRACT_PITCH MATLAB code for Extract_Pitch.fig
%      EXTRACT_PITCH, by itself, creates a new EXTRACT_PITCH or raises the existing
%      singleton*.
%
%      H = EXTRACT_PITCH returns the handle to a new EXTRACT_PITCH or the handle to
%      the existing singleton*.
%
%      EXTRACT_PITCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACT_PITCH.M with the given input arguments.
%
%      EXTRACT_PITCH('Property','Value',...) creates a new EXTRACT_PITCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Extract_Pitch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Extract_Pitch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Extract_Pitch

% Last Modified by GUIDE v2.5 29-Oct-2021 08:11:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Extract_Pitch_OpeningFcn, ...
                   'gui_OutputFcn',  @Extract_Pitch_OutputFcn, ...
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


% --- Executes just before Extract_Pitch is made visible.
function Extract_Pitch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Extract_Pitch (see VARARGIN)

% Choose default command line output for Extract_Pitch
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Extract_Pitch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Extract_Pitch_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract the pitch
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extract_Pitch.
function Extract_Pitch_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path_pitch;

time_start = str2double(get(handles.Start_T,'String'));
time_end = str2double(get(handles.End_T,'String'));
loops_FFT = str2double(get(handles.Loops_Algorithm,'String'));

data_type_selected = get(handles.Data_Type,'Value');
sensor_selected = get(handles.Sensors_Pitch,'Value');

CL_level_ac = str2double(get(handles.CL_Level,'String'));

analysis_chosen = get(handles.Type_Analysis,'Value');

Pitch_Detector_Analysis(path_pitch,time_start,time_end,loops_FFT,...
    data_type_selected,sensor_selected,handles,analysis_chosen,CL_level_ac);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_Pitch.
function Upload_Dir_Pitch_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_pitch;
global path_pitch;

if (get(handles.Data_Type,'Value') == 1)
    
[file_pitch,path_pitch] = uigetfile('*.wav','Upload directory where the files have been stored');

cd(path_pitch)
set(handles.Sensors_Pitch,'String','1');

else
   
   [file_pitch,path_pitch] = uigetfile('*.mat','Upload directory where the files have been stored'); 
   
   cd(path_pitch)
   temp_file = load(file_pitch);
   
   set(handles.Sensors_Pitch,'String',temp_file.data_exported.labels);
   
end

set(handles.Dir_Uploaded_Pitch,'String',path_pitch);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Uploaded_Pitch_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Uploaded_Pitch as text
%        str2double(get(hObject,'String')) returns contents of Dir_Uploaded_Pitch as a double


% --- Executes during object creation, after setting all properties.
function Dir_Uploaded_Pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start of the time window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_T_Callback(hObject, eventdata, handles)
% hObject    handle to Start_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_T as text
%        str2double(get(hObject,'String')) returns contents of Start_T as a double


% --- Executes during object creation, after setting all properties.
function Start_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End of the time window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_T_Callback(hObject, eventdata, handles)
% hObject    handle to End_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_T as text
%        str2double(get(hObject,'String')) returns contents of End_T as a double


% --- Executes during object creation, after setting all properties.
function End_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Loops of the algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Loops_Algorithm_Callback(hObject, eventdata, handles)
% hObject    handle to Loops_Algorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Loops_Algorithm as text
%        str2double(get(hObject,'String')) returns contents of Loops_Algorithm as a double


% --- Executes during object creation, after setting all properties.
function Loops_Algorithm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Loops_Algorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Type of data to be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Data_Type.
function Data_Type_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Data_Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Data_Type


% --- Executes during object creation, after setting all properties.
function Data_Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sensors of the files to be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Sensors_Pitch.
function Sensors_Pitch_Callback(hObject, eventdata, handles)
% hObject    handle to Sensors_Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Sensors_Pitch contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Sensors_Pitch


% --- Executes during object creation, after setting all properties.
function Sensors_Pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sensors_Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Type of analysis to be done
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Type_Analysis.
function Type_Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to Type_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Type_Analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Type_Analysis

switch (get(handles.Type_Analysis,'Value'))
    
    case 1 
        
         set(handles.CL_Level,'Enable','on')
    set(handles.Loops_Algorithm,'Enable','off')
        
    case 2
        
         set(handles.CL_Level,'Enable','off')
    set(handles.Loops_Algorithm,'Enable','off')
        
    case 3
   
        set(handles.CL_Level,'Enable','off')
    set(handles.Loops_Algorithm,'Enable','on')
        
end

% --- Executes during object creation, after setting all properties.
function Type_Analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Type_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Clipping 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CL_Level_Callback(hObject, eventdata, handles)
% hObject    handle to CL_Level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CL_Level as text
%        str2double(get(hObject,'String')) returns contents of CL_Level as a double


% --- Executes during object creation, after setting all properties.
function CL_Level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CL_Level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to detect the pitch
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Pitch_Detector_GUI_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Pitch_Detector_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Pitch_Detector();
