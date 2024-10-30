function varargout = Re_Reference_GUI_COGMO(varargin)
% RE_REFERENCE_GUI_COGMO MATLAB code for Re_Reference_GUI_COGMO.fig
%      RE_REFERENCE_GUI_COGMO, by itself, creates a new RE_REFERENCE_GUI_COGMO or raises the existing
%      singleton*.
%
%      H = RE_REFERENCE_GUI_COGMO returns the handle to a new RE_REFERENCE_GUI_COGMO or the handle to
%      the existing singleton*.
%
%      RE_REFERENCE_GUI_COGMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RE_REFERENCE_GUI_COGMO.M with the given input arguments.
%
%      RE_REFERENCE_GUI_COGMO('Property','Value',...) creates a new RE_REFERENCE_GUI_COGMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Re_Reference_GUI_COGMO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Re_Reference_GUI_COGMO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Re_Reference_GUI_COGMO

% Last Modified by GUIDE v2.5 13-Jan-2022 10:23:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Re_Reference_GUI_COGMO_OpeningFcn, ...
                   'gui_OutputFcn',  @Re_Reference_GUI_COGMO_OutputFcn, ...
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


% --- Executes just before Re_Reference_GUI_COGMO is made visible.
function Re_Reference_GUI_COGMO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Re_Reference_GUI_COGMO (see VARARGIN)

% Choose default command line output for Re_Reference_GUI_COGMO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Re_Reference_GUI_COGMO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Re_Reference_GUI_COGMO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Channel for the re-reference
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Rereference_Channel_COGMO.
function Rereference_Channel_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Rereference_Channel_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Rereference_Channel_COGMO contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Rereference_Channel_COGMO


% --- Executes during object creation, after setting all properties.
function Rereference_Channel_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rereference_Channel_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the EEG to be re-referenced
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_EEG_Rereference_COGMO.
function Upload_EEG_Rereference_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_EEG_Rereference_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_eeg_re_reference;
global mat_file_directory_re_reference;
global load_eeg;

[mat_file_eeg_re_reference,mat_file_directory_eeg_re_reference] = uigetfile('*.mat','Select the mat file');

cd(mat_file_directory_eeg_re_reference)
load_eeg = load(mat_file_eeg_re_reference);

set(handles.EEG_Uploaded_Rereference_COGMO,'String',mat_file_eeg_re_reference);

set(handles.Rereference_Channel_COGMO,'Value',1);
set(handles.Rereference_Channel_COGMO,'String',load_eeg.data_exported.labels);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EEG to be re-referenced uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function EEG_Uploaded_Rereference_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to EEG_Uploaded_Rereference_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EEG_Uploaded_Rereference_COGMO as text
%        str2double(get(hObject,'String')) returns contents of EEG_Uploaded_Rereference_COGMO as a double


% --- Executes during object creation, after setting all properties.
function EEG_Uploaded_Rereference_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EEG_Uploaded_Rereference_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Re-reference the channels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Rereference_Button_COGMO.
function Rereference_Button_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Rereference_Button_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_eeg_re_reference;
global mat_file_directory_re_reference;
global load_eeg;

channels_recorded = get(handles.Rereference_Channel_COGMO,'String');
channel_selected_pos = get(handles.Rereference_Channel_COGMO,'Value');

%% Options for the reference
common_av = get(handles.CM_Rereference_COGMO,'Value');
ears_mastoids_av = get(handles.EMA_Rereference_COGMO,'Value');
single_channel = get(handles.SC_Rereference_COGMO,'Value');

add_old_reference_check = get(handles.Add_Old_Reference_COGMO,'Value');
name_old_reference = get(handles.Old_Reference_Name_COGMO,'String');

Re_reference_COGMO_function(mat_file_eeg_re_reference,mat_file_directory_re_reference,load_eeg,channels_recorded,...
    channel_selected_pos,common_av,ears_mastoids_av,single_channel,add_old_reference_check,name_old_reference);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Common Average reference
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in CM_Rereference_COGMO.
function CM_Rereference_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to CM_Rereference_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Add_Old_Reference_COGMO,'Enable','off');
set(handles.Old_Reference_Name_COGMO,'Enable','off');

% Hint: get(hObject,'Value') returns toggle state of CM_Rereference_COGMO
if(get(handles.CM_Rereference_COGMO,'Value') == 1)
   
    set(handles.EMA_Rereference_COGMO,'Value',0);
    set(handles.SC_Rereference_COGMO,'Value',0);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Average of the two ear lobes or mastoids reference
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in EMA_Rereference_COGMO.
function EMA_Rereference_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to EMA_Rereference_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Add_Old_Reference_COGMO,'Enable','off');
set(handles.Old_Reference_Name_COGMO,'Enable','off');

% Hint: get(hObject,'Value') returns toggle state of EMA_Rereference_COGMO
if(get(handles.EMA_Rereference_COGMO,'Value') == 1)
   
    set(handles.CM_Rereference_COGMO,'Value',0);
    set(handles.SC_Rereference_COGMO,'Value',0);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Single channel reference
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in SC_Rereference_COGMO.
function SC_Rereference_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to SC_Rereference_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Add_Old_Reference_COGMO,'Enable','on');
set(handles.Old_Reference_Name_COGMO,'Enable','on');

% Hint: get(hObject,'Value') returns toggle state of SC_Rereference_COGMO
if(get(handles.SC_Rereference_COGMO,'Value') == 1)
   
    set(handles.CM_Rereference_COGMO,'Value',0);
    set(handles.EMA_Rereference_COGMO,'Value',0);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If check, the old reference will be added to the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Add_Old_Reference_COGMO.
function Add_Old_Reference_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Add_Old_Reference_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Add_Old_Reference_COGMO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the old reference
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Old_Reference_Name_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Old_Reference_Name_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Old_Reference_Name_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Old_Reference_Name_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Old_Reference_Name_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Old_Reference_Name_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to re-reference the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Re_Reference_Data_Help_Callback(hObject, eventdata, handles)
% hObject    handle to Re_Reference_Data_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Re_Reference_Help();
