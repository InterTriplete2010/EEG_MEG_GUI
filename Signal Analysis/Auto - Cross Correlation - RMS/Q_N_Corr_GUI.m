function varargout = Q_N_Corr_GUI(varargin)
% Q_N_CORR_GUI MATLAB code for Q_N_Corr_GUI.fig
%      Q_N_CORR_GUI, by itself, creates a new Q_N_CORR_GUI or raises the existing
%      singleton*.
%
%      H = Q_N_CORR_GUI returns the handle to a new Q_N_CORR_GUI or the handle to
%      the existing singleton*.
%
%      Q_N_CORR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Q_N_CORR_GUI.M with the given input arguments.
%
%      Q_N_CORR_GUI('Property','Value',...) creates a new Q_N_CORR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Q_N_Corr_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Q_N_Corr_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Q_N_Corr_GUI

% Last Modified by GUIDE v2.5 10-Feb-2022 10:14:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Q_N_Corr_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Q_N_Corr_GUI_OutputFcn, ...
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


% --- Executes just before Q_N_Corr_GUI is made visible.
function Q_N_Corr_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Q_N_Corr_GUI (see VARARGIN)

% Choose default command line output for Q_N_Corr_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Q_N_Corr_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Q_N_Corr_GUI_OutputFcn(hObject, eventdata, handles) 
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
global Noise_file_selected;
global Noise_directory;

[Noise_file_selected,Noise_directory] = uigetfile('*.fig','Select the fig file');

set(handles.Dir_Uploaded_N,'String',Noise_directory);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dir Noise Uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Uploaded_N_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Uploaded_N as text
%        str2double(get(hObject,'String')) returns contents of Dir_Uploaded_N as a double


% --- Executes during object creation, after setting all properties.
function Dir_Uploaded_N_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_N (see GCBO)
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
% --- Executes on button press in Corr_Q_N.
function Corr_Q_N_Callback(hObject, eventdata, handles)
% hObject    handle to Corr_Q_N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Quiet_directory;
global Noise_directory;

response_analyzed_pos = get(handles.Response_Analyzed,'Value');
response_analyzed_names = get(handles.Response_Analyzed,'String');
response_analyzed_name_saved = response_analyzed_names(response_analyzed_pos);

start_t_ent_resp = str2double(get(handles.Starting_Time_Entire_Resp,'String'));
end_t_ent_resp = str2double(get(handles.End_Time_Entire_Resp,'String'));

Corr_Responses(Quiet_directory,Noise_directory,response_analyzed_name_saved,start_t_ent_resp,end_t_ent_resp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the Dir for Quiet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_Q.
function Upload_Dir_Q_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Quiet_file_selected;
global Quiet_directory;

[Quiet_file_selected,Quiet_directory] = uigetfile('*.fig','Select the fig file');

set(handles.Dir_Uploaded_Q,'String',Quiet_directory);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dir uploaded for Quiet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Uploaded_Q_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Uploaded_Q as text
%        str2double(get(hObject,'String')) returns contents of Dir_Uploaded_Q as a double


% --- Executes during object creation, after setting all properties.
function Dir_Uploaded_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Uploaded_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Response Analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Response_Analyzed.
function Response_Analyzed_Callback(hObject, eventdata, handles)
% hObject    handle to Response_Analyzed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Response_Analyzed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Response_Analyzed
if(get(handles.Response_Analyzed,'Value') > 1)
   
    set(handles.Starting_Time_Entire_Resp,'Enable','Off');
     set(handles.End_Time_Entire_Resp,'Enable','Off');
     
else
    
    set(handles.Starting_Time_Entire_Resp,'Enable','On');
     set(handles.End_Time_Entire_Resp,'Enable','On');
    
end

% --- Executes during object creation, after setting all properties.
function Response_Analyzed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Response_Analyzed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start time to analyze the entire response
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Starting_Time_Entire_Resp_Callback(hObject, eventdata, handles)
% hObject    handle to Starting_Time_Entire_Resp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Starting_Time_Entire_Resp as text
%        str2double(get(hObject,'String')) returns contents of Starting_Time_Entire_Resp as a double


% --- Executes during object creation, after setting all properties.
function Starting_Time_Entire_Resp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Starting_Time_Entire_Resp (see GCBO)
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
function End_Time_Entire_Resp_Callback(hObject, eventdata, handles)
% hObject    handle to End_Time_Entire_Resp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Time_Entire_Resp as text
%        str2double(get(hObject,'String')) returns contents of End_Time_Entire_Resp as a double


% --- Executes during object creation, after setting all properties.
function End_Time_Entire_Resp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Time_Entire_Resp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to calculate auto/cross correlation
%and the RMS value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Corr_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Corr_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Corr();
