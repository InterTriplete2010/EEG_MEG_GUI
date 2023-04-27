function varargout = Silence_Removal_Speech(varargin)
% SILENCE_REMOVAL_SPEECH MATLAB code for Silence_Removal_Speech.fig
%      SILENCE_REMOVAL_SPEECH, by itself, creates a new SILENCE_REMOVAL_SPEECH or raises the existing
%      singleton*.
%
%      H = SILENCE_REMOVAL_SPEECH returns the handle to a new SILENCE_REMOVAL_SPEECH or the handle to
%      the existing singleton*.
%
%      SILENCE_REMOVAL_SPEECH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SILENCE_REMOVAL_SPEECH.M with the given input arguments.
%
%      SILENCE_REMOVAL_SPEECH('Property','Value',...) creates a new SILENCE_REMOVAL_SPEECH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Silence_Removal_Speech_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Silence_Removal_Speech_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Silence_Removal_Speech

% Last Modified by GUIDE v2.5 29-Oct-2021 08:06:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Silence_Removal_Speech_OpeningFcn, ...
                   'gui_OutputFcn',  @Silence_Removal_Speech_OutputFcn, ...
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


% --- Executes just before Silence_Removal_Speech is made visible.
function Silence_Removal_Speech_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Silence_Removal_Speech (see VARARGIN)

% Choose default command line output for Silence_Removal_Speech
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Silence_Removal_Speech wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Silence_Removal_Speech_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the training waveform 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Training_Waveform.
function Upload_Training_Waveform_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Training_Waveform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_training;
global wav_path_training;

[wav_file_training,wav_path_training] = uigetfile('*.wav','Upload the waveform used for training the algorithm');

set(handles.Training_Waveform_Uploaded,'String',wav_file_training);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Training waveform uploaded 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Training_Waveform_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Training_Waveform_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Training_Waveform_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Training_Waveform_Uploaded as a double

% --- Executes during object creation, after setting all properties.
function Training_Waveform_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Training_Waveform_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Order of the low pass filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Order_LP_Filt_Callback(hObject, eventdata, handles)
% hObject    handle to Order_LP_Filt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Order_LP_Filt as text
%        str2double(get(hObject,'String')) returns contents of Order_LP_Filt as a double


% --- Executes during object creation, after setting all properties.
function Order_LP_Filt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Order_LP_Filt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Cut-off frequency of the low pass filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CF_HP_Filter_Callback(hObject, eventdata, handles)
% hObject    handle to CF_HP_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CF_HP_Filter as text
%        str2double(get(hObject,'String')) returns contents of CF_HP_Filter as a double


% --- Executes during object creation, after setting all properties.
function CF_HP_Filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CF_HP_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time window for the training data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Time_Window_Training_Callback(hObject, eventdata, handles)
% hObject    handle to Time_Window_Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_Window_Training as text
%        str2double(get(hObject,'String')) returns contents of Time_Window_Training as a double


% --- Executes during object creation, after setting all properties.
function Time_Window_Training_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_Window_Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time shift for the training data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Time_Shift_Training_Callback(hObject, eventdata, handles)
% hObject    handle to Time_Shift_Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_Shift_Training as text
%        str2double(get(hObject,'String')) returns contents of Time_Shift_Training as a double


% --- Executes during object creation, after setting all properties.
function Time_Shift_Training_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_Shift_Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prior of the silence for the training data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Prior_Silence_Training_Callback(hObject, eventdata, handles)
% hObject    handle to Prior_Silence_Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Prior_Silence_Training as text
%        str2double(get(hObject,'String')) returns contents of Prior_Silence_Training as a double


% --- Executes during object creation, after setting all properties.
function Prior_Silence_Training_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Prior_Silence_Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prior of the voice for the training data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Prior_Voice_Training_Callback(hObject, eventdata, handles)
% hObject    handle to Prior_Voice_Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Prior_Voice_Training as text
%        str2double(get(hObject,'String')) returns contents of Prior_Voice_Training as a double


% --- Executes during object creation, after setting all properties.
function Prior_Voice_Training_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Prior_Voice_Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Threshold for the silence for the training data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Threshold_Silence_Training_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_Silence_Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold_Silence_Training as text
%        str2double(get(hObject,'String')) returns contents of Threshold_Silence_Training as a double


% --- Executes during object creation, after setting all properties.
function Threshold_Silence_Training_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold_Silence_Training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the waveform that will have silence segments removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Waveform_Test.
function Upload_Waveform_Test_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Waveform_Test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_testing;
global wav_path_testing;

[wav_file_testing,wav_path_testing] = uigetfile('*.wav','Upload the waveform that needs to have silent segment removed');

set(handles.Waveform_Test_Uploaded,'String',wav_path_testing);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Waveform that will have silence segments removed uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Waveform_Test_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Waveform_Test_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Waveform_Test_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Waveform_Test_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Waveform_Test_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Waveform_Test_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Remove silence segments from the uploaded waveform
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Remove_Silence.
function Remove_Silence_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_Silence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_training;
global wav_path_training;
global wav_file_testing;
global wav_path_testing;

order_filt = str2double(get(handles.Order_LP_Filt,'String'));
cf_filt = str2double(get(handles.CF_HP_Filter,'String'));
time_w = str2double(get(handles.Time_Window_Training,'String'))/1000;
time_shift = str2double(get(handles.Time_Shift_Training,'String'))/1000;
prior_silence_train = str2double(get(handles.Prior_Silence_Training,'String'));
prior_voice_train = str2double(get(handles.Prior_Voice_Training,'String'));
threshold_silence_train = str2double(get(handles.Threshold_Silence_Training,'String'));
max_silence = str2double(get(handles.Max_Allowable_Silence_Segment,'String'))/1000;
loops_EM_algorithm = str2double(get(handles.Loops_EM,'String'));

Voice_Unvoiced_Silence_Detection_Training(wav_file_training,wav_path_training,wav_path_testing,...
    max_silence,order_filt,cf_filt,time_w,time_shift,prior_silence_train,prior_voice_train,threshold_silence_train,loops_EM_algorithm);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select the maximum length of the silence segments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Max_Allowable_Silence_Segment_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Allowable_Silence_Segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Allowable_Silence_Segment as text
%        str2double(get(hObject,'String')) returns contents of Max_Allowable_Silence_Segment as a double


% --- Executes during object creation, after setting all properties.
function Max_Allowable_Silence_Segment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Allowable_Silence_Segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Number of loops for the EM algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Loops_EM_Callback(hObject, eventdata, handles)
% hObject    handle to Loops_EM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Loops_EM as text
%        str2double(get(hObject,'String')) returns contents of Loops_EM as a double


% --- Executes during object creation, after setting all properties.
function Loops_EM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Loops_EM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to remove silence segments in
%speech works
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Silence_Removal_Speech_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Silence_Removal_Speech_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Silence_Removal_Speech();
