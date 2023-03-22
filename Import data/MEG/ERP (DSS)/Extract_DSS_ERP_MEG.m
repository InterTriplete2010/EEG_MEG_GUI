function varargout = Extract_DSS_ERP_MEG(varargin)
% EXTRACT_DSS_ERP_MEG M-file for Extract_DSS_ERP_MEG.fig
%      EXTRACT_DSS_ERP_MEG, by itself, creates a new EXTRACT_DSS_ERP_MEG or raises the existing
%      singleton*.
%
%      H = EXTRACT_DSS_ERP_MEG returns the handle to a new EXTRACT_DSS_ERP_MEG or the handle to
%      the existing singleton*.
%
%      EXTRACT_DSS_ERP_MEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACT_DSS_ERP_MEG.M with the given input arguments.
%
%      EXTRACT_DSS_ERP_MEG('Property','Value',...) creates a new EXTRACT_DSS_ERP_MEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Extract_DSS_ERP_MEG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Extract_DSS_ERP_MEG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Extract_DSS_ERP_MEG

% Last Modified by GUIDE v2.5 16-Feb-2022 14:56:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Extract_DSS_ERP_MEG_OpeningFcn, ...
                   'gui_OutputFcn',  @Extract_DSS_ERP_MEG_OutputFcn, ...
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


% --- Executes just before Extract_DSS_ERP_MEG is made visible.
function Extract_DSS_ERP_MEG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Extract_DSS_ERP_MEG (see VARARGIN)

% Choose default command line output for Extract_DSS_ERP_MEG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Extract_DSS_ERP_MEG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Extract_DSS_ERP_MEG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting the DSS components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extract_DSS_ERP_MEG.
function Extract_DSS_MEG_Function_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_DSS_ERP_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSS_MEG_file_selected;
global DSS_MEG_file_directory;

start_p1_time = str2double(get(handles.Start_P1_DSS,'String'))/1000;
end_p1_time = str2double(get(handles.End_P1_DSS,'String'))/1000;

start_N100_time = str2double(get(handles.Start_N100_DSS,'String'))/1000;
end_N100_time = str2double(get(handles.End_N100_DSS,'String'))/1000;

start_P200_time = str2double(get(handles.Start_P200_DSS,'String'))/1000;
end_P200_time = str2double(get(handles.End_P200_DSS,'String'))/1000;

file_name_peaks_latencies = get(handles.File_Name_Peaks_Latencies_DSS,'String');

DoDssIIR2Alex_ERP_DSS(DSS_MEG_file_directory,start_p1_time,end_p1_time,start_N100_time,end_N100_time,start_P200_time,end_P200_time,file_name_peaks_latencies)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload MEG directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Directory_MEG_DSS_ERP.
function Upload_Directory_MEG_DSS_ERP_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Directory_MEG_DSS_ERP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSS_MEG_file_selected;
global DSS_MEG_file_directory;

[DSS_MEG_file_selected,DSS_MEG_file_directory] = uigetfile('*.mat','Select the mat file');

set(handles.Directory_Uploaded_MEG_DSS_ERP,'String',DSS_MEG_file_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected for the MEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Directory_Uploaded_MEG_DSS_ERP_Callback(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_MEG_DSS_ERP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Directory_Uploaded_MEG_DSS_ERP as text
%        str2double(get(hObject,'String')) returns contents of Directory_Uploaded_MEG_DSS_ERP as a double


% --- Executes during object creation, after setting all properties.
function Directory_Uploaded_MEG_DSS_ERP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_MEG_DSS_ERP (see GCBO)
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
function Start_P1_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to Start_P1_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_P1_DSS as text
%        str2double(get(hObject,'String')) returns contents of Start_P1_DSS as a double


% --- Executes during object creation, after setting all properties.
function Start_P1_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_P1_DSS (see GCBO)
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
function End_P1_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to End_P1_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_P1_DSS as text
%        str2double(get(hObject,'String')) returns contents of End_P1_DSS as a double


% --- Executes during object creation, after setting all properties.
function End_P1_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_P1_DSS (see GCBO)
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
function Start_N100_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to Start_N100_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_N100_DSS as text
%        str2double(get(hObject,'String')) returns contents of Start_N100_DSS as a double


% --- Executes during object creation, after setting all properties.
function Start_N100_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_N100_DSS (see GCBO)
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
function End_N100_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to End_N100_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_N100_DSS as text
%        str2double(get(hObject,'String')) returns contents of End_N100_DSS as a double


% --- Executes during object creation, after setting all properties.
function End_N100_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_N100_DSS (see GCBO)
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
function Start_P200_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to Start_P200_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_P200_DSS as text
%        str2double(get(hObject,'String')) returns contents of Start_P200_DSS as a double


% --- Executes during object creation, after setting all properties.
function Start_P200_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_P200_DSS (see GCBO)
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
function End_P200_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to End_P200_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_P200_DSS as text
%        str2double(get(hObject,'String')) returns contents of End_P200_DSS as a double


% --- Executes during object creation, after setting all properties.
function End_P200_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_P200_DSS (see GCBO)
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
function File_Name_Peaks_Latencies_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to File_Name_Peaks_Latencies_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Name_Peaks_Latencies_DSS as text
%        str2double(get(hObject,'String')) returns contents of File_Name_Peaks_Latencies_DSS as a double


% --- Executes during object creation, after setting all properties.
function File_Name_Peaks_Latencies_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Name_Peaks_Latencies_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to extract the DSS from MEG 
%data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_DSS_MEG_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_DSS_MEG_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Extract_DSS_ERP_MEG_Help();