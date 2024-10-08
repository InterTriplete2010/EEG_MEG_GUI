function varargout = Frequency_Components(varargin)
% FREQUENCY_COMPONENTS MATLAB code for Frequency_Components.fig
%      FREQUENCY_COMPONENTS, by itself, creates a new FREQUENCY_COMPONENTS or raises the existing
%      singleton*.
%
%      H = FREQUENCY_COMPONENTS returns the handle to a new FREQUENCY_COMPONENTS or the handle to
%      the existing singleton*.
%
%      FREQUENCY_COMPONENTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FREQUENCY_COMPONENTS.M with the given input arguments.
%
%      FREQUENCY_COMPONENTS('Property','Value',...) creates a new FREQUENCY_COMPONENTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Frequency_Components_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Frequency_Components_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Frequency_Components

% Last Modified by GUIDE v2.5 10-Feb-2022 09:57:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Frequency_Components_OpeningFcn, ...
                   'gui_OutputFcn',  @Frequency_Components_OutputFcn, ...
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


% --- Executes just before Frequency_Components is made visible.
function Frequency_Components_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Frequency_Components (see VARARGIN)

% Choose default command line output for Frequency_Components
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Frequency_Components wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Frequency_Components_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract the frequency components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extract_Freq_Func.
function Extract_Freq_Func_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Freq_Func (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_EEG_directory;

freq_bins_number = str2double(get(handles.Freq_Bins,'String'));
freq_analysis = str2num(get(handles.Freq_to_be_Analyzed,'String'));

mode_selected = get(handles.Env_TFS,'Value');

freq_comp_function(freq_bins_number,freq_analysis,mode_selected,Files_EEG_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

message = 'Calculations completed';

        msgbox(message,'Calculations completed','warn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Frequency bins
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Freq_Bins_Callback(hObject, eventdata, handles)
% hObject    handle to Freq_Bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Freq_Bins as text
%        str2double(get(hObject,'String')) returns contents of Freq_Bins as a double


% --- Executes during object creation, after setting all properties.
function Freq_Bins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Freq_Bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Frequencies to be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Freq_to_be_Analyzed_Callback(hObject, eventdata, handles)
% hObject    handle to Freq_to_be_Analyzed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Freq_to_be_Analyzed as text
%        str2double(get(hObject,'String')) returns contents of Freq_to_be_Analyzed as a double


% --- Executes during object creation, after setting all properties.
function Freq_to_be_Analyzed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Freq_to_be_Analyzed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Selection between Envelope and TFS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Env_TFS.
function Env_TFS_Callback(hObject, eventdata, handles)
% hObject    handle to Env_TFS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Env_TFS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Env_TFS


% --- Executes during object creation, after setting all properties.
function Env_TFS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Env_TFS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Frequency_Compns_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Frequency_Compns_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Frequency_Compns_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Dir_Frequency_Compns_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Dir_Frequency_Compns_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Frequency_Compns_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_Freq_Compn.
function Upload_Dir_Freq_Compn_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_Freq_Compn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_EEG_selected;
global Files_EEG_directory;

[Files_EEG_selected,Files_EEG_directory] = uigetfile('*.fig','Select the figure');

set(handles.Dir_Frequency_Compns_Uploaded,'String',Files_EEG_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to analyze the frequency components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Frequency_Components_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Frequency_Components_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Analyze_Frequency_Components();
