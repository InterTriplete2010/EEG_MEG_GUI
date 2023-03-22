function varargout = Decimation_COGMO_GUI(varargin)
% DECIMATION_COGMO_GUI M-file for Decimation_COGMO_GUI.fig
%      DECIMATION_COGMO_GUI, by itself, creates a new DECIMATION_COGMO_GUI or raises the existing
%      singleton*.
%
%      H = DECIMATION_COGMO_GUI returns the handle to a new DECIMATION_COGMO_GUI or the handle to
%      the existing singleton*.
%
%      DECIMATION_COGMO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECIMATION_COGMO_GUI.M with the given input arguments.
%
%      DECIMATION_COGMO_GUI('Property','Value',...) creates a new DECIMATION_COGMO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Decimation_COGMO_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Decimation_COGMO_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Decimation_COGMO_GUI

% Last Modified by GUIDE v2.5 22-Nov-2021 15:39:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Decimation_COGMO_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Decimation_COGMO_GUI_OutputFcn, ...
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


% --- Executes just before Decimation_COGMO_GUI is made visible.
function Decimation_COGMO_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Decimation_COGMO_GUI (see VARARGIN)

% Choose default command line output for Decimation_COGMO_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Decimation_COGMO_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Decimation_COGMO_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the "mat" file that needs to be decimated 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Mat_File_COGMO_Decimation.
function Mat_File_COGMO_Decimation_Callback(hObject, eventdata, handles)
% hObject    handle to Mat_File_COGMO_Decimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Mat_file_decimation;
global Mat_directory_decimation;

[Mat_file_decimation,Mat_directory_decimation] = uigetfile('*.mat','Select the neuroscan file');


if(Mat_file_decimation == 0)
   
    set(handles.File_Uploaded_COGMO_Decimation_EEG,'String','No file selected');
    
else
    
    set(handles.File_Uploaded_COGMO_Decimation_EEG,'String',Mat_file_decimation);

    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Returns the "mat" file that needs to be filtered 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Uploaded_COGMO_Decimation_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_COGMO_Decimation_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Uploaded_COGMO_Decimation_EEG as text
%        str2double(get(hObject,'String')) returns contents of File_Uploaded_COGMO_Decimation_EEG as a double


% --- Executes during object creation, after setting all properties.
function File_Uploaded_COGMO_Decimation_EEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_COGMO_Decimation_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decimation factor Denominator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Decimation_Factor_COGMO_Denominator_Callback(hObject, eventdata, handles)
% hObject    handle to Decimation_Factor_COGMO_Denominator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Decimation_Factor_COGMO_Denominator as text
%        str2double(get(hObject,'String')) returns contents of Decimation_Factor_COGMO_Denominator as a double


% --- Executes during object creation, after setting all properties.
function Decimation_Factor_COGMO_Denominator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Decimation_Factor_COGMO_Denominator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decimate the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Decimate_Mat_File_COGMO.
function Decimate_Mat_File_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Decimate_Mat_File_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Mat_file_decimation;
global Mat_directory_decimation;

decimation_factor_numerator = str2double(get(handles.Decimation_Factor_COGMO_Numerator,'String'));
decimation_factor_denominator = str2double(get(handles.Decimation_Factor_COGMO_Denominator,'String'));

decimation_function_COGMO(Mat_file_decimation,Mat_directory_decimation,decimation_factor_numerator,decimation_factor_denominator);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decimation factor Numerator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Decimation_Factor_COGMO_Numerator_Callback(hObject, eventdata, handles)
% hObject    handle to Decimation_Factor_COGMO_Numerator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Decimation_Factor_COGMO_Numerator as text
%        str2double(get(hObject,'String')) returns contents of Decimation_Factor_COGMO_Numerator as a double


% --- Executes during object creation, after setting all properties.
function Decimation_Factor_COGMO_Numerator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Decimation_Factor_COGMO_Numerator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to decimate the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Decimate_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Decimate_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Decimate_Help();
