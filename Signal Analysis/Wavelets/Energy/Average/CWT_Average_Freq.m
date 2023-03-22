function varargout = CWT_Average_Freq(varargin)
% CWT_AVERAGE_FREQ MATLAB code for CWT_Average_Freq.fig
%      CWT_AVERAGE_FREQ, by itself, creates a new CWT_AVERAGE_FREQ or raises the existing
%      singleton*.
%
%      H = CWT_AVERAGE_FREQ returns the handle to a new CWT_AVERAGE_FREQ or the handle to
%      the existing singleton*.
%
%      CWT_AVERAGE_FREQ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CWT_AVERAGE_FREQ.M with the given input arguments.
%
%      CWT_AVERAGE_FREQ('Property','Value',...) creates a new CWT_AVERAGE_FREQ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CWT_Average_Freq_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CWT_Average_Freq_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CWT_Average_Freq

% Last Modified by GUIDE v2.5 15-Feb-2022 11:12:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CWT_Average_Freq_OpeningFcn, ...
                   'gui_OutputFcn',  @CWT_Average_Freq_OutputFcn, ...
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


% --- Executes just before CWT_Average_Freq is made visible.
function CWT_Average_Freq_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CWT_Average_Freq (see VARARGIN)

% Choose default command line output for CWT_Average_Freq
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CWT_Average_Freq wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CWT_Average_Freq_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select if the Energy or the amplitude will be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Select_Analysis_Av_Wavelet.
function Select_Analysis_Av_Wavelet_Callback(hObject, eventdata, handles)
% hObject    handle to Select_Analysis_Av_Wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Select_Analysis_Av_Wavelet contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Select_Analysis_Av_Wavelet


% --- Executes during object creation, after setting all properties.
function Select_Analysis_Av_Wavelet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Select_Analysis_Av_Wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected for the figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Selected_Av_Wavelets_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Selected_Av_Wavelets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Selected_Av_Wavelets as text
%        str2double(get(hObject,'String')) returns contents of Dir_Selected_Av_Wavelets as a double


% --- Executes during object creation, after setting all properties.
function Dir_Selected_Av_Wavelets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Selected_Av_Wavelets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory for the wavelets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_Av_Wavelets.
function Upload_Dir_Av_Wavelets_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_Av_Wavelets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Cwt_file_selected;
global Cwt_file_directory;

[Cwt_file_selected,Cwt_file_directory] = uigetfile('*.mat','Select the mat file');

set(handles.Dir_Selected_Av_Wavelets,'String',Cwt_file_directory)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Frequency bin for the wavelets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Frequency_Bin_Av_Wav_Callback(hObject, eventdata, handles)
% hObject    handle to Frequency_Bin_Av_Wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Frequency_Bin_Av_Wav as text
%        str2double(get(hObject,'String')) returns contents of Frequency_Bin_Av_Wav as a double


% --- Executes during object creation, after setting all properties.
function Frequency_Bin_Av_Wav_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Frequency_Bin_Av_Wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Frequencies to be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Frequency_Analysis_Av_Wav_Callback(hObject, eventdata, handles)
% hObject    handle to Frequency_Analysis_Av_Wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Frequency_Analysis_Av_Wav as text
%        str2double(get(hObject,'String')) returns contents of Frequency_Analysis_Av_Wav as a double


% --- Executes during object creation, after setting all properties.
function Frequency_Analysis_Av_Wav_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Frequency_Analysis_Av_Wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Starting point for the analysis of the frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_T_av_Wav_Callback(hObject, eventdata, handles)
% hObject    handle to Start_T_av_Wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_T_av_Wav as text
%        str2double(get(hObject,'String')) returns contents of Start_T_av_Wav as a double


% --- Executes during object creation, after setting all properties.
function Start_T_av_Wav_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_T_av_Wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ending point for the analysis of the frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Stop_T_Av_Wav_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_T_Av_Wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stop_T_Av_Wav as text
%        str2double(get(hObject,'String')) returns contents of Stop_T_Av_Wav as a double


% --- Executes during object creation, after setting all properties.
function Stop_T_Av_Wav_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stop_T_Av_Wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Analyze the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Analyze_Av_Wav.
function Analyze_Av_Wav_Callback(hObject, eventdata, handles)
% hObject    handle to Analyze_Av_Wav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Cwt_file_selected;
global Cwt_file_directory;

analysis_mode = get(handles.Select_Analysis_Av_Wavelet,'Value');
freq_bin = str2double(get(handles.Frequency_Bin_Av_Wav,'String'));
freq_range = str2num(get(handles. Frequency_Analysis_Av_Wav,'String'));
start_a = str2double(get(handles.Start_T_av_Wav,'String'));
end_a = str2double(get(handles.Stop_T_Av_Wav,'String'));
start_n = str2double(get(handles.LB_Noise,'String'));
end_n = str2double(get(handles.UB_Noise,'String'));

warning off

cd(Cwt_file_directory);
average_wavelets_energy(Cwt_file_directory,analysis_mode,freq_bin,freq_range,start_a,end_a,start_n,end_n);

warning on

message = 'Calculations completed';
msgbox(message,'End of the calculations','warn','replace');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Lower Bound of the noise data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function LB_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to LB_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LB_Noise as text
%        str2double(get(hObject,'String')) returns contents of LB_Noise as a double


% --- Executes during object creation, after setting all properties.
function LB_Noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LB_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upper Bound of the noise data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function UB_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to UB_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UB_Noise as text
%        str2double(get(hObject,'String')) returns contents of UB_Noise as a double


% --- Executes during object creation, after setting all properties.
function UB_Noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UB_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to calculate the average of the CWT
%files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_CWT_Average_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_CWT_Average_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CWT_Average_Freq_Help();
