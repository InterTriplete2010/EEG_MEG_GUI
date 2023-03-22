function varargout = Extract_DSS_ERP_EEG(varargin)
% EXTRACT_DSS_ERP_EEG M-file for Extract_DSS_ERP_EEG.fig
%      EXTRACT_DSS_ERP_EEG, by itself, creates a new EXTRACT_DSS_ERP_EEG or raises the existing
%      singleton*.
%
%      H = EXTRACT_DSS_ERP_EEG returns the handle to a new EXTRACT_DSS_ERP_EEG or the handle to
%      the existing singleton*.
%
%      EXTRACT_DSS_ERP_EEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACT_DSS_ERP_EEG.M with the given input arguments.
%
%      EXTRACT_DSS_ERP_EEG('Property','Value',...) creates a new EXTRACT_DSS_ERP_EEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Extract_DSS_ERP_EEG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Extract_DSS_ERP_EEG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Extract_DSS_ERP_EEG

% Last Modified by GUIDE v2.5 14-Jan-2022 13:33:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Extract_DSS_ERP_EEG_OpeningFcn, ...
                   'gui_OutputFcn',  @Extract_DSS_ERP_EEG_OutputFcn, ...
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


% --- Executes just before Extract_DSS_ERP_EEG is made visible.
function Extract_DSS_ERP_EEG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Extract_DSS_ERP_EEG (see VARARGIN)

% Choose default command line output for Extract_DSS_ERP_EEG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Extract_DSS_ERP_EEG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Extract_DSS_ERP_EEG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting the DSS components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extract_DSS_ERP_EEG.
function Extract_DSS_EEG_Function_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_DSS_ERP_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSS_EEG_file_selected;
global DSS_EEG_file_directory;

start_p1_time = str2double(get(handles.Start_P1_DSS_EEG,'String'))/1000;
end_p1_time = str2double(get(handles.End_P1_DSS_EEG,'String'))/1000;

start_N100_time = str2double(get(handles.Start_N100_DSS_EEG,'String'))/1000;
end_N100_time = str2double(get(handles.End_N100_DSS_EEG,'String'))/1000;

start_P200_time = str2double(get(handles.Start_P200_DSS_EEG,'String'))/1000;
end_P200_time = str2double(get(handles.End_P200_DSS_EEG,'String'))/1000;

file_name_peaks_latencies = get(handles.File_Name_Peaks_Latencies_DSS_EEG,'String');

sweeps_analysis_DSS = str2double(get(handles.Sweeps_DSS,'String'));

if (get(handles.Conc_File_DSS,'Value') == 0)

DSS_EEG(DSS_EEG_file_directory,start_p1_time,end_p1_time,start_N100_time,end_N100_time,start_P200_time,end_P200_time,file_name_peaks_latencies,sweeps_analysis_DSS)

else

  DSS_EEG_Concatenate(DSS_EEG_file_directory,start_p1_time,end_p1_time,start_N100_time,end_N100_time,start_P200_time,end_P200_time,file_name_peaks_latencies,sweeps_analysis_DSS)  
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload EEG directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Directory_EEG_DSS_ERP.
function Upload_Directory_EEG_DSS_ERP_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Directory_EEG_DSS_ERP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSS_EEG_file_selected;
global DSS_EEG_file_directory;

[DSS_EEG_file_selected,DSS_EEG_file_directory] = uigetfile('*.mat','Select the mat file');

set(handles.Directory_Uploaded_EEG_DSS_ERP,'String',DSS_EEG_file_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected for the EEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Directory_Uploaded_EEG_DSS_ERP_Callback(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_EEG_DSS_ERP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Directory_Uploaded_EEG_DSS_ERP as text
%        str2double(get(hObject,'String')) returns contents of Directory_Uploaded_EEG_DSS_ERP as a double


% --- Executes during object creation, after setting all properties.
function Directory_Uploaded_EEG_DSS_ERP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_EEG_DSS_ERP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Starting time for the P1 extraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_P1_DSS_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to Start_P1_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_P1_DSS_EEG as text
%        str2double(get(hObject,'String')) returns contents of Start_P1_DSS_EEG as a double


% --- Executes during object creation, after setting all properties.
function Start_P1_DSS_EEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_P1_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End time for the P1 extraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_P1_DSS_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to End_P1_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_P1_DSS_EEG as text
%        str2double(get(hObject,'String')) returns contents of End_P1_DSS_EEG as a double


% --- Executes during object creation, after setting all properties.
function End_P1_DSS_EEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_P1_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Starting time for the N100 extraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_N100_DSS_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to Start_N100_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_N100_DSS_EEG as text
%        str2double(get(hObject,'String')) returns contents of Start_N100_DSS_EEG as a double


% --- Executes during object creation, after setting all properties.
function Start_N100_DSS_EEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_N100_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End time for the N100 extraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_N100_DSS_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to End_N100_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_N100_DSS_EEG as text
%        str2double(get(hObject,'String')) returns contents of End_N100_DSS_EEG as a double


% --- Executes during object creation, after setting all properties.
function End_N100_DSS_EEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_N100_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Starting time for the P200 extraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_P200_DSS_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to Start_P200_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_P200_DSS_EEG as text
%        str2double(get(hObject,'String')) returns contents of Start_P200_DSS_EEG as a double


% --- Executes during object creation, after setting all properties.
function Start_P200_DSS_EEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_P200_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End time for the P200 extraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_P200_DSS_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to End_P200_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_P200_DSS_EEG as text
%        str2double(get(hObject,'String')) returns contents of End_P200_DSS_EEG as a double


% --- Executes during object creation, after setting all properties.
function End_P200_DSS_EEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_P200_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File name for peaks and latencies (DSS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Name_Peaks_Latencies_DSS_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to File_Name_Peaks_Latencies_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Name_Peaks_Latencies_DSS_EEG as text
%        str2double(get(hObject,'String')) returns contents of File_Name_Peaks_Latencies_DSS_EEG as a double


% --- Executes during object creation, after setting all properties.
function File_Name_Peaks_Latencies_DSS_EEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Name_Peaks_Latencies_DSS_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sweeps for the DSS analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Sweeps_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to Sweeps_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sweeps_DSS as text
%        str2double(get(hObject,'String')) returns contents of Sweeps_DSS as a double


% --- Executes during object creation, after setting all properties.
function Sweeps_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweeps_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the files will be concatenated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Conc_File_DSS.
function Conc_File_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to Conc_File_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Conc_File_DSS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to extract DSS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Extract_DSS_ERP_EEG_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_DSS_ERP_EEG_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Extract_DSS_ERP_EEG_Help();
