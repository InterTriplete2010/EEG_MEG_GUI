function varargout = MMN_GUI(varargin)
% MMN_GUI MATLAB code for MMN_GUI.fig
%      MMN_GUI, by itself, creates a new MMN_GUI or raises the existing
%      singleton*.
%
%      H = MMN_GUI returns the handle to a new MMN_GUI or the handle to
%      the existing singleton*.
%
%      MMN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MMN_GUI.M with the given input arguments.
%
%      MMN_GUI('Property','Value',...) creates a new MMN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MMN_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MMN_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MMN_GUI

% Last Modified by GUIDE v2.5 12-May-2025 10:52:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MMN_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MMN_GUI_OutputFcn, ...
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


% --- Executes just before MMN_GUI is made visible.
function MMN_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MMN_GUI (see VARARGIN)

% Choose default command line output for MMN_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MMN_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MMN_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory with deviant stimuli
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Deviant_Stimuli.
function Upload_Deviant_Stimuli_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Deviant_Stimuli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global deviant_stimuli_files;
global dir_folder_data_deviant;

dir_folder_data_deviant = uigetdir('.*','Select the folder with the deviant stimuli');

if (dir_folder_data_deviant == 0)

    set(handles.Folder_Uploaded,'String','Invalid folder');

    msgbox('Invalid selection. Please, select a valid folder','Warning')

    return;

else

    temp_del = strfind(dir_folder_data_deviant,'\');

    set(handles.Deviant_Stimuli_Uploaded,'String', dir_folder_data_deviant(temp_del(end) + 1:end));

end

%Upload all the files and save them in the global variable named "deviant_stimuli_files"
deviant_stimuli_files = [];

cd(dir_folder_data_deviant);
curr_dir = dir;

for kk = 3:length(curr_dir)

    if(strcmp(curr_dir(kk).name(end-3:end),'.mat'))

        deviant_stimuli_files = [deviant_stimuli_files;{curr_dir(kk).name}];

    end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory with deviant stimuli uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Deviant_Stimuli_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Deviant_Stimuli_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Deviant_Stimuli_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Deviant_Stimuli_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Deviant_Stimuli_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Deviant_Stimuli_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory with standard stimuli
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Standard_Stimuli.
function Upload_Standard_Stimuli_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Standard_Stimuli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global standard_stimuli_files;
global dir_folder_data_standard;

dir_folder_data_standard = uigetdir('.*','Select the folder with the standard stimuli');

if (dir_folder_data_standard == 0)

    set(handles.Folder_Uploaded,'String','Invalid folder');

    msgbox('Invalid selection. Please, select a valid folder','Warning')

    return;

else

    temp_del = strfind(dir_folder_data_standard,'\');

    set(handles.Standard_Stimuli_Uploaded,'String', dir_folder_data_standard(temp_del(end) + 1:end));

end

%Upload all the files and save them in the global variable named "standard_stimuli_files"
standard_stimuli_files = [];

cd(dir_folder_data_standard);
curr_dir = dir;

for kk = 3:length(curr_dir)

    if(strcmp(curr_dir(kk).name(end-3:end),'.mat'))

        standard_stimuli_files = [standard_stimuli_files;{curr_dir(kk).name}];

    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory with standard stimuli uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Standard_Stimuli_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Standard_Stimuli_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Standard_Stimuli_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Standard_Stimuli_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Standard_Stimuli_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Standard_Stimuli_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Starting value of the window to calculate the Peak and the RMS of the MMN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_MMN_Callback(hObject, eventdata, handles)
% hObject    handle to Start_MMN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_MMN as text
%        str2double(get(hObject,'String')) returns contents of Start_MMN as a double


% --- Executes during object creation, after setting all properties.
function Start_MMN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_MMN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ending value of the window to calculate the Peak and RMS of the MMN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_MMN_Callback(hObject, eventdata, handles)
% hObject    handle to End_MMN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_MMN as text
%        str2double(get(hObject,'String')) returns contents of End_MMN as a double


% --- Executes during object creation, after setting all properties.
function End_MMN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_MMN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract MMN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extract_MMN.
function Extract_MMN_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_MMN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global standard_stimuli_files;
global dir_folder_data_standard;
global deviant_stimuli_files;
global dir_folder_data_deviant;

%Check if the number of files of the standard and deviant stimuli is the same
if (length(standard_stimuli_files) ~= length(deviant_stimuli_files) || isempty(standard_stimuli_files) || isempty(deviant_stimuli_files))

    msgbox("Operation aborted. The number of files of of the standard and deviant stimuli needs to be the same","Error");

    return;

end

start_window = str2double(get(handles.Start_MMN,'String'));
end_window = str2double(get(handles.End_MMN,'String'));

abs_val = get(handles.Absolute_Value,'Value');

extract_MMN(standard_stimuli_files,dir_folder_data_standard,deviant_stimuli_files,dir_folder_data_deviant,start_window,end_window,abs_val);

msgbox("MMN has been extracted for each file","End of the analysis");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the absolute value of the standard and deviant will be used 
% to calculate the MMN 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Absolute_Value.
function Absolute_Value_Callback(hObject, eventdata, handles)
% hObject    handle to Absolute_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Absolute_Value

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to calculate MMN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_MMN_Callback(hObject, eventdata, handles)
% hObject    handle to Help_MMN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MMN_GUI_Help();
