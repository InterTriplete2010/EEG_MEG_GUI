function varargout = Change_Axes_COGMO_GUI(varargin)
% CHANGE_AXES_COGMO_GUI M-file for Change_Axes_COGMO_GUI.fig
%      CHANGE_AXES_COGMO_GUI, by itself, creates a new CHANGE_AXES_COGMO_GUI or raises the existing
%      singleton*.
%
%      H = CHANGE_AXES_COGMO_GUI returns the handle to a new CHANGE_AXES_COGMO_GUI or the handle to
%      the existing singleton*.
%
%      CHANGE_AXES_COGMO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHANGE_AXES_COGMO_GUI.M with the given input arguments.
%
%      CHANGE_AXES_COGMO_GUI('Property','Value',...) creates a new CHANGE_AXES_COGMO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Change_Axes_COGMO_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Change_Axes_COGMO_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Change_Axes_COGMO_GUI

% Last Modified by GUIDE v2.5 29-Oct-2021 08:23:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Change_Axes_COGMO_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Change_Axes_COGMO_GUI_OutputFcn, ...
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


% --- Executes just before Change_Axes_COGMO_GUI is made visible.
function Change_Axes_COGMO_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Change_Axes_COGMO_GUI (see VARARGIN)

% Choose default command line output for Change_Axes_COGMO_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Change_Axes_COGMO_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Change_Axes_COGMO_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Figure to change
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Figure_Change_Axes_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Figure_Change_Axes_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Figure_Change_Axes_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Figure_Change_Axes_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Figure_Change_Axes_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Figure_Change_Axes_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%X min
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function X_min_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to X_min_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_min_COGMO as text
%        str2double(get(hObject,'String')) returns contents of X_min_COGMO as a double


% --- Executes during object creation, after setting all properties.
function X_min_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_min_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%X max
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function X_max_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to X_max_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_max_COGMO as text
%        str2double(get(hObject,'String')) returns contents of X_max_COGMO as a double


% --- Executes during object creation, after setting all properties.
function X_max_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_max_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Y min
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Y_Min_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Y_Min_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_Min_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Y_Min_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Y_Min_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_Min_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%X max
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Y_Max_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Y_Max_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_Max_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Y_Max_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Y_Max_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_Max_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Change the axes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Change_Axes_COGMO.
function Change_Axes_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Change_Axes_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global triggers_number;

figure_chosen = str2double(get(handles.Figure_Change_Axes_COGMO,'String'));
x_min = str2double(get(handles.X_min_COGMO,'String'));
x_max = str2double(get(handles.X_max_COGMO,'String'));
y_min = str2double(get(handles.Y_Min_COGMO,'String'));
y_max = str2double(get(handles.Y_Max_COGMO,'String'));

rows_subplot_number = str2double(get(handles.Rows_subplots,'String'));
columns_subplot_number = str2double(get(handles.Columns_subplots,'String'));
change_wav_pos = str2double(get(handles.Position_Change_Wave,'String'));

change_axes_COGMO_function(triggers_number,rows_subplot_number,columns_subplot_number,figure_chosen,x_min,x_max,y_min,y_max,change_wav_pos);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Row of the subplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Rows_subplots_Callback(hObject, eventdata, handles)
% hObject    handle to Rows_subplots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rows_subplots as text
%        str2double(get(hObject,'String')) returns contents of Rows_subplots as a double


% --- Executes during object creation, after setting all properties.
function Rows_subplots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rows_subplots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Seconds to be moved backward
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Backward_Shift_EEG_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Backward_Shift_EEG_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Backward_Shift_EEG_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Backward_Shift_EEG_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Backward_Shift_EEG_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Backward_Shift_EEG_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Moved backward
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Move_Backward_EEG_COGMO.
function Move_Backward_EEG_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Move_Backward_EEG_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global triggers_number;

figure_chosen = str2double(get(handles.Figure_Change_Axes_COGMO,'String'));

rows_subplot_number = str2double(get(handles.Rows_subplots,'String'));
columns_subplot_number = str2double(get(handles.Columns_subplots,'String'));
change_wav_pos = str2double(get(handles.Position_Change_Wave,'String'));

seconds_to_move = str2double(get(handles.Backward_Shift_EEG_COGMO,'String'));

move_axes_backward_COGMO_function(triggers_number,seconds_to_move,rows_subplot_number,columns_subplot_number,figure_chosen,change_wav_pos);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Seconds to be moved forward
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Shift_Forward_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Shift_Forward_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Shift_Forward_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Shift_Forward_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Shift_Forward_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Shift_Forward_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Moved backward
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Move_Forward_EEG_COGMO.
function Move_Forward_EEG_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Move_Forward_EEG_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global triggers_number;

figure_chosen = str2double(get(handles.Figure_Change_Axes_COGMO,'String'));

rows_subplot_number = str2double(get(handles.Rows_subplots,'String'));
columns_subplot_number = str2double(get(handles.Columns_subplots,'String'));
change_wav_pos = str2double(get(handles.Position_Change_Wave,'String'));

seconds_to_move = str2double(get(handles.Shift_Forward_COGMO,'String'));

move_axes_forward_COGMO_function(triggers_number,seconds_to_move,rows_subplot_number,columns_subplot_number,figure_chosen,change_wav_pos);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Column of the subplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Columns_subplots_Callback(hObject, eventdata, handles)
% hObject    handle to Columns_subplots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Columns_subplots as text
%        str2double(get(hObject,'String')) returns contents of Columns_subplots as a double


% --- Executes during object creation, after setting all properties.
function Columns_subplots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Columns_subplots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Wave to be changed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Position_Change_Wave_Callback(hObject, eventdata, handles)
% hObject    handle to Position_Change_Wave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Position_Change_Wave as text
%        str2double(get(hObject,'String')) returns contents of Position_Change_Wave as a double


% --- Executes during object creation, after setting all properties.
function Position_Change_Wave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Position_Change_Wave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to change the axes of a figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Change_Axes_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Change_Axes_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Changte_Axes();
