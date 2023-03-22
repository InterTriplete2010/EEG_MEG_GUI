function varargout = Corr_DSS_GUI(varargin)
% CORR_DSS_GUI MATLAB code for Corr_DSS_GUI.fig
%      CORR_DSS_GUI, by itself, creates a new CORR_DSS_GUI or raises the existing
%      singleton*.
%
%      H = CORR_DSS_GUI returns the handle to a new CORR_DSS_GUI or the handle to
%      the existing singleton*.
%
%      CORR_DSS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CORR_DSS_GUI.M with the given input arguments.
%
%      CORR_DSS_GUI('Property','Value',...) creates a new CORR_DSS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Corr_DSS_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Corr_DSS_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Corr_DSS_GUI

% Last Modified by GUIDE v2.5 14-Jan-2022 13:49:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Corr_DSS_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Corr_DSS_GUI_OutputFcn, ...
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


% --- Executes just before Corr_DSS_GUI is made visible.
function Corr_DSS_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Corr_DSS_GUI (see VARARGIN)

% Choose default command line output for Corr_DSS_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Corr_DSS_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Corr_DSS_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the Dir for the Noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_N.
function Upload_Dir_N_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_II_selected;
global file_II_directory;

[file_II_selected,file_II_directory] = uigetfile('*.mat','Select the fig file');

set(handles.Dir_Uploaded_File_II,'String',file_II_directory);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dir Noise Uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Uploaded_File_II_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_File_II (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Uploaded_File_II as text
%        str2double(get(hObject,'String')) returns contents of Dir_Uploaded_File_II as a double


% --- Executes during object creation, after setting all properties.
function Dir_Uploaded_File_II_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_File_II (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate correlation Quiet/Noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Corr_DSS_Analysis.
function Corr_DSS_Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to Corr_DSS_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_I_directory;
global file_II_directory;


start_t_ent_resp = str2double(get(handles.Starting_Time_Correlation_DSS,'String'));
end_t_ent_resp = str2double(get(handles.End_Time_Correlation_DSS,'String'));

Corr_response_Average_Trials(file_I_directory,file_II_directory,start_t_ent_resp,end_t_ent_resp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the Dir for the first file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_File_I.
function Upload_Dir_File_I_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_File_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_I_selected;
global file_I_directory;

[file_I_selected,file_I_directory] = uigetfile('*.mat','Select the fig file');

set(handles.Dir_Uploaded_File_I,'String',file_I_directory);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dir uploaded for the first file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Uploaded_File_I_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_File_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Uploaded_File_I as text
%        str2double(get(hObject,'String')) returns contents of Dir_Uploaded_File_I as a double


% --- Executes during object creation, after setting all properties.
function Dir_Uploaded_File_I_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_File_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start time to analyze the entire response
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Starting_Time_Correlation_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to Starting_Time_Correlation_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Starting_Time_Correlation_DSS as text
%        str2double(get(hObject,'String')) returns contents of Starting_Time_Correlation_DSS as a double


% --- Executes during object creation, after setting all properties.
function Starting_Time_Correlation_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Starting_Time_Correlation_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End time to analyze the entire response
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_Time_Correlation_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to End_Time_Correlation_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Time_Correlation_DSS as text
%        str2double(get(hObject,'String')) returns contents of End_Time_Correlation_DSS as a double


% --- Executes during object creation, after setting all properties.
function End_Time_Correlation_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Time_Correlation_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to calculate the correlation 
%values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Corr_DSS_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Corr_DSS_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Corr_DSS_GUI_Help();
