function varargout = Cross_Correlation_cABR_GUI(varargin)
% CROSS_CORRELATION_CABR_GUI M-file for Cross_Correlation_cABR_GUI.fig
%      CROSS_CORRELATION_CABR_GUI, by itself, creates a new CROSS_CORRELATION_CABR_GUI or raises the existing
%      singleton*.
%
%      H = CROSS_CORRELATION_CABR_GUI returns the handle to a new CROSS_CORRELATION_CABR_GUI or the handle to
%      the existing singleton*.
%
%      CROSS_CORRELATION_CABR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROSS_CORRELATION_CABR_GUI.M with the given input arguments.
%
%      CROSS_CORRELATION_CABR_GUI('Property','Value',...) creates a new CROSS_CORRELATION_CABR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Cross_Correlation_cABR_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Cross_Correlation_cABR_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Cross_Correlation_cABR_GUI

% Last Modified by GUIDE v2.5 10-Feb-2022 11:20:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Cross_Correlation_cABR_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Cross_Correlation_cABR_GUI_OutputFcn, ...
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


% --- Executes just before Cross_Correlation_cABR_GUI is made visible.
function Cross_Correlation_cABR_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Cross_Correlation_cABR_GUI (see VARARGIN)

% Choose default command line output for Cross_Correlation_cABR_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Cross_Correlation_cABR_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Cross_Correlation_cABR_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot the cross-correlation between stimulus and response
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Plot_Correlation_cABR.
function Plot_Correlation_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Correlation_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_corr_plot;
global wav_file_directory_corr_plot;
global mat_file_directory_corr_plot;

cd(wav_file_directory_corr_plot)

    [stimulus_wave freq_stim_wave] =  audioread(wav_file_corr_plot);
   

%Filter parameters
order_buttw_filt = str2double(get(handles.Order_Stimulus_cABR,'String'));
lf_buttw_filt = str2double(get(handles.LPF_Stimulus_cABR,'String'));
hf_buttw_filt = str2double(get(handles.HPF_Stimulus_cABR,'String'));
phase_filter_analysis = get(handles.phase_filter,'Value');
filter_check = get(handles.Filter_Stimulus_cABR_Check,'Value');

extract_env_resp = get(handles.Extract_Envelope_Response,'Value');

cd(mat_file_directory_corr_plot)
%response_ssr_load = load(mat_file_corr_plot);

%% Calculating the response to stimulus corr for each file
mat_files = dir;

[files_number] = size(mat_files,1);

track_files = 1;

select_window_user = get(handles.Select_Time_Window_Stim_Resp,'Value');
start_t = str2double(get(handles.Start_Time_Stim_Resp,'String'));
end_t = str2double(get(handles.End_Time_Stim_Resp,'String'));

if (isnan(start_t) || isnan(end_t)) && (select_window_user == 1)
   
   message = 'Please, insert numerical values for the time window';
msgbox(message,'Operation aborted','warn','replace');

    return;
    
end

dist_peaks = str2double(get(handles.Distance_Peaks,'String'));
height_peaks = str2double(get(handles.Height_Peaks,'String'));

calculate_corr_cABR(stimulus_wave(:,1)',mat_file_directory_corr_plot, ...
                      freq_stim_wave,order_buttw_filt,lf_buttw_filt,hf_buttw_filt,phase_filter_analysis,filter_check,...
                      extract_env_resp,select_window_user,start_t,end_t,handles,...
                      dist_peaks,height_peaks);

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the stimulus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Stimulus_cABR.
function Stimulus_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to Stimulus_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_corr_plot;
global wav_file_directory_corr_plot;

[wav_file_corr_plot,wav_file_directory_corr_plot] = uigetfile('*.wav','Select the stimulus file');

set(handles.Stimulus_Uploaded_cABR,'String',wav_file_corr_plot);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Stimulus file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Stimulus_Uploaded_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to Stimulus_Uploaded_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stimulus_Uploaded_cABR as text
%        str2double(get(hObject,'String')) returns contents of Stimulus_Uploaded_cABR as a double


% --- Executes during object creation, after setting all properties.
function Stimulus_Uploaded_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stimulus_Uploaded_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the response file 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Response_cABR.
function Upload_Response_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Response_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global mat_file_corr_plot;
global mat_file_directory_corr_plot;

[mat_file_corr_plot,mat_file_directory_corr_plot] = uigetfile('*.fig','Select the response file');

set(handles.SSR_Uploaded_cABR,'String',mat_file_directory_corr_plot);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Response file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SSR_Uploaded_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to SSR_Uploaded_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SSR_Uploaded_cABR as text
%        str2double(get(hObject,'String')) returns contents of SSR_Uploaded_cABR as a double


% --- Executes during object creation, after setting all properties.
function SSR_Uploaded_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SSR_Uploaded_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Low pass for the filter for the Stimulus 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function LPF_Stimulus_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to LPF_Stimulus_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LPF_Stimulus_cABR as text
%        str2double(get(hObject,'String')) returns contents of LPF_Stimulus_cABR as a double


% --- Executes during object creation, after setting all properties.
function LPF_Stimulus_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LPF_Stimulus_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%High pass for the filter for the Stimulus 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function HPF_Stimulus_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to HPF_Stimulus_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HPF_Stimulus_cABR as text
%        str2double(get(hObject,'String')) returns contents of HPF_Stimulus_cABR as a double


% --- Executes during object creation, after setting all properties.
function HPF_Stimulus_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HPF_Stimulus_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Order for the filter for the Stimulus 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Order_Stimulus_cABR_Callback(hObject, eventdata, handles)
% hObject    handle to Order_Stimulus_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Order_Stimulus_cABR as text
%        str2double(get(hObject,'String')) returns contents of Order_Stimulus_cABR as a double


% --- Executes during object creation, after setting all properties.
function Order_Stimulus_cABR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Order_Stimulus_cABR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the stimulus will be filtered
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Filter_Stimulus_cABR_Check.
function Filter_Stimulus_cABR_Check_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_Stimulus_cABR_Check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Filter_Stimulus_cABR_Check

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the envelope of the response will be used for the analysis 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extract_Envelope_Response.
function Extract_Envelope_Response_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Envelope_Response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Extract_Envelope_Response

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start time of the analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_Time_Stim_Resp_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Time_Stim_Resp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_Time_Stim_Resp as text
%        str2double(get(hObject,'String')) returns contents of Start_Time_Stim_Resp as a double


% --- Executes during object creation, after setting all properties.
function Start_Time_Stim_Resp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_Time_Stim_Resp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End time of the analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_Time_Stim_Resp_Callback(hObject, eventdata, handles)
% hObject    handle to End_Time_Stim_Resp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_Time_Stim_Resp as text
%        str2double(get(hObject,'String')) returns contents of End_Time_Stim_Resp as a double


% --- Executes during object creation, after setting all properties.
function End_Time_Stim_Resp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Time_Stim_Resp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the time window will be selected by the user
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Select_Time_Window_Stim_Resp.
function Select_Time_Window_Stim_Resp_Callback(hObject, eventdata, handles)
% hObject    handle to Select_Time_Window_Stim_Resp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Select_Time_Window_Stim_Resp

if get(handles.Select_Time_Window_Stim_Resp,'Value') == 1
   
    set(handles.Start_Time_Stim_Resp,'Enable','on');
    set(handles.End_Time_Stim_Resp,'Enable','on');
    
else
    
    set(handles.Start_Time_Stim_Resp,'Enable','off');
    set(handles.End_Time_Stim_Resp,'Enable','off');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sampling Frequency of the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SF_FFR_Callback(hObject, eventdata, handles)
% hObject    handle to SF_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SF_FFR as text
%        str2double(get(hObject,'String')) returns contents of SF_FFR as a double


% --- Executes during object creation, after setting all properties.
function SF_FFR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SF_FFR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Minimum distance of the peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Distance_Peaks_Callback(hObject, eventdata, handles)
% hObject    handle to Distance_Peaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Distance_Peaks as text
%        str2double(get(hObject,'String')) returns contents of Distance_Peaks as a double


% --- Executes during object creation, after setting all properties.
function Distance_Peaks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Distance_Peaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Minimum height of the peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Height_Peaks_Callback(hObject, eventdata, handles)
% hObject    handle to Height_Peaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Height_Peaks as text
%        str2double(get(hObject,'String')) returns contents of Height_Peaks as a double


% --- Executes during object creation, after setting all properties.
function Height_Peaks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Height_Peaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Phase of the filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in phase_filter.
function phase_filter_Callback(hObject, eventdata, handles)
% hObject    handle to phase_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns phase_filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from phase_filter


% --- Executes during object creation, after setting all properties.
function phase_filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phase_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to calculate the stimulu-to-response
%correlation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Stim_Resp_Corr_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Stim_Resp_Corr_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Cross_Correlation_Help();