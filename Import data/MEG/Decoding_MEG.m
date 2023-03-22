function varargout = Decoding_MEG(varargin)
% DECODING_MEG M-file for Decoding_MEG.fig
%      DECODING_MEG, by itself, creates a new DECODING_MEG or raises the existing
%      singleton*.
%
%      H = DECODING_MEG returns the handle to a new DECODING_MEG or the handle to
%      the existing singleton*.
%
%      DECODING_MEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECODING_MEG.M with the given input arguments.
%
%      DECODING_MEG('Property','Value',...) creates a new DECODING_MEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Decoding_MEG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Decoding_MEG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Decoding_MEG

% Last Modified by GUIDE v2.5 03-Feb-2022 11:24:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Decoding_MEG_OpeningFcn, ...
                   'gui_OutputFcn',  @Decoding_MEG_OutputFcn, ...
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


% --- Executes just before Decoding_MEG is made visible.
function Decoding_MEG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Decoding_MEG (see VARARGIN)

% Choose default command line output for Decoding_MEG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Decoding_MEG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Decoding_MEG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decoding the MEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Decoding_MEG.
function Decoding_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Decoding_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_MEG_file_selected;
global Files_MEG_file_directory;
global wav_file_selected;
global wav_file_directory;
global wav_file_selected_noise;
global wav_file_directory_noise;
global wav_file_background;
global wav_file_background_directory;
global wav_file_noise_background;
global wav_file_noise_background_directory;
global meg_file_add;
global meg_file_add_directory;

Forder = str2double(get(handles.order_filt_raw_MEG,'String'));
freqL = str2double(get(handles.low_cut_raw_MEG,'String'));
freqH = str2double(get(handles.high_cut_raw_MEG,'String'));

order_DSS1 = get(handles.order_filt_SDSS,'Value');
Freq_Low_DSS1 = str2double(get(handles.low_cut_SDSS,'String'));
Freq_High_DSS1 = str2double(get(handles.high_cut_SDSS,'String'));

SF_MEG_Data = str2double(get(handles.Sampling_Freq_Data,'String'));
n_components = str2num(get(handles.Components_DSS,'String'));

time_shift_DSS = str2num(get(handles.TW_DSS,'String'))/1000;
Subjcet_Number_analysis = str2double(get(handles.Subjcet_Number_TRF,'String'));

decimation_fact = str2double(get(handles.Dec_Factor_TRF,'String'));
%% Checking which model (forward or backward) should be computed
model_selected = get(handles.Model_TRF_Choice,'Value');

%Zero-phase choice
zero_phase_menu = get(handles.Zero_Phase_Filt_Decoding,'Value');

%Filtering choice
filter_rm = get(handles.Filter_Rotation_Matrix,'Value');
Filter_DSS = get(handles.Filter_DSS,'Value');
Filter_Auditory_Stim = get(handles.Filter_Auditory_Stimuli,'Value');

switch model_selected
    
    case 1 %Backward model of the average
        
    %Analyzing the foreground        
DoDssIIR2Alex(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_directory,wav_file_selected,Files_MEG_file_directory,n_components,...
    wav_file_selected_noise,wav_file_directory_noise,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

if ~isempty(wav_file_background_directory) & ~isempty(wav_file_noise_background) 
    
%Analyzing the background
DoDssIIR2Alex(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_background_directory,wav_file_background,Files_MEG_file_directory,n_components,...
    wav_file_noise_background,wav_file_noise_background_directory,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

else
    
      
    msgbox('No audio file was uploaded for the background noise', 'Upload the audio file for the background','error');
    
end
    

   case 2 %Backward model of the single trials
       
           %Analyzing the foreground
        DoDssIIR2Alex_Single_Trial(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_directory,wav_file_selected,Files_MEG_file_directory,n_components,...
    wav_file_selected_noise,wav_file_directory_noise,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

if ~isempty(wav_file_background_directory) & ~isempty(wav_file_noise_background) 

%Analyzing the background
DoDssIIR2Alex_Single_Trial(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_background_directory,wav_file_background,Files_MEG_file_directory,n_components,...
    wav_file_noise_background,wav_file_noise_background_directory,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

else
    
      
    msgbox('No audio file was uploaded for the background noise', 'Upload the audio file for the background','error');
    
end
    

case 3 %Forward model of the average
    
    %Analyzing the foreground
DoDssIIR2Alex_Forward_Model(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_directory,wav_file_selected,Files_MEG_file_directory,n_components,...
    wav_file_selected_noise,wav_file_directory_noise,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

if ~isempty(wav_file_background_directory) & ~isempty(wav_file_noise_background) 

%Analyzing the background
DoDssIIR2Alex_Forward_Model(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_background_directory,wav_file_background,Files_MEG_file_directory,n_components,...
    wav_file_noise_background,wav_file_noise_background_directory,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

else
    
      
    msgbox('No audio file was uploaded for the background noise', 'Upload the audio file for the background','error');
    
end

case 4 %Forward model of the single trials
       
           %Analyzing the foreground
        DoDssIIR2Alex_Single_Trial_Forward(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_directory,wav_file_selected,Files_MEG_file_directory,n_components,...
    wav_file_selected_noise,wav_file_directory_noise,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)


if ~isempty(wav_file_background_directory) & ~isempty(wav_file_noise_background) 
%Analyzing the background
DoDssIIR2Alex_Single_Trial_Forward(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_background_directory,wav_file_background,Files_MEG_file_directory,n_components,...
    wav_file_noise_background,wav_file_noise_background_directory,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

else
    
      
    msgbox('No audio file was uploaded for the background noise', 'Upload the audio file for the background','error');
    
end

case 5 %Backward model for the Quiet condition 
    
    %Analyzing the foreground        
DoDssIIR2Alex_Quiet(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_directory,wav_file_selected,Files_MEG_file_directory,n_components,...
    wav_file_selected_noise,wav_file_directory_noise,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

    case 6  %Backward model for the Quiet condition for the single trails option
        
      %Analyzing the foreground
        DoDssIIR2Alex_Single_Trial_Quiet(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_directory,wav_file_selected,Files_MEG_file_directory,n_components,...
    wav_file_selected_noise,wav_file_directory_noise,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)
    

case 7 %Forward model for the Quiet condition 
    
    %Analyzing the foreground        
DoDssIIR2Alex_Forward_Model_Quiet(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_directory,wav_file_selected,Files_MEG_file_directory,n_components,...
    wav_file_selected_noise,wav_file_directory_noise,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

case 8  %Forward model for the Quiet condition for the single trails option
        
       %Analyzing the foreground
        DoDssIIR2Alex_Single_Trial_Forward_Quiet(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1, ...
    wav_file_directory,wav_file_selected,Files_MEG_file_directory,n_components,...
    wav_file_selected_noise,wav_file_directory_noise,SF_MEG_Data,time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

case 9 %Calculate the rotation matrix and rotating the data into the DSS space 

    DoDssIIR2Alex_Auditory_DSS(Forder,freqL,freqH,Files_MEG_file_directory,n_components,SF_MEG_Data,filter_rm)

case 10 %Calculate the rotation matrix and rotating the data into the DSS space with concatenated files

    DoDssIIR2Alex_Auditory_DSS_Concatenate(Forder,freqL,freqH,Files_MEG_file_directory,n_components,SF_MEG_Data,filter_rm)

case 11 %DSS extracted with weights calculated from a different condition
  
    DSS_extracted_different_weights(meg_file_add_directory,meg_file_add,Files_MEG_file_directory)
    
    
end

msgbox('Operation successfully completed','Success');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload MEG directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Directory_MEG.
function Upload_Directory_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Directory_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_MEG_file_selected;
global Files_MEG_file_directory;

[Files_MEG_file_selected,Files_MEG_file_directory] = uigetfile('*.mat','Select the mat file');

if (Files_MEG_file_selected == 0)
    
    set(handles.Sampling_Freq_Data,'String','N/A');
set(handles.Directory_Uploaded_MEG,'String','No File selected');
    
else
    
cd(Files_MEG_file_directory)
temp_data = load(Files_MEG_file_selected);
% 
% if ~isfield(temp_data.data_exported,'dss')
%    
%     msgbox('Wrong file. No DSS field has been found', 'Upload the correct file','error');
%     
% end

set(handles.Sampling_Freq_Data,'String',temp_data.data_exported.sampling_frequency);
set(handles.Directory_Uploaded_MEG,'String',Files_MEG_file_directory);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory selected for the MEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Directory_Uploaded_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Directory_Uploaded_MEG as text
%        str2double(get(hObject,'String')) returns contents of Directory_Uploaded_MEG as a double


% --- Executes during object creation, after setting all properties.
function Directory_Uploaded_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Directory_Uploaded_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the wav stimulus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Stim_MEG.
function Upload_Stim_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Stim_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_selected;
global wav_file_directory;

[wav_file_selected,wav_file_directory] = uigetfile('*.wav','Select the wav file');

if (wav_file_selected == 0)
   
    set(handles.Stim_Uploaded_MEG,'String','No File selected');
    
else
    
set(handles.Stim_Uploaded_MEG,'String',wav_file_selected);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Wav stimulus uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Stim_Uploaded_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Stim_Uploaded_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stim_Uploaded_MEG as text
%        str2double(get(hObject,'String')) returns contents of Stim_Uploaded_MEG as a double
global wav_file_selected;
global wav_file_directory;

[wav_file_selected,wav_file_directory] = uigetfile('*.wav','Select the sound file');

if (wav_file_selected == 0)
    
    set(handles.Stim_Uploaded_MEG,'String','No File selected');
    
else
    
set(handles.Stim_Uploaded_MEG,'String',wav_file_selected);

end

% --- Executes during object creation, after setting all properties.
function Stim_Uploaded_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stim_Uploaded_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Low pass for the MEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function low_cut_raw_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to low_cut_raw_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of low_cut_raw_MEG as text
%        str2double(get(hObject,'String')) returns contents of low_cut_raw_MEG as a double


% --- Executes during object creation, after setting all properties.
function low_cut_raw_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to low_cut_raw_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%High pass for the MEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function high_cut_raw_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to high_cut_raw_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of high_cut_raw_MEG as text
%        str2double(get(hObject,'String')) returns contents of high_cut_raw_MEG as a double


% --- Executes during object creation, after setting all properties.
function high_cut_raw_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to high_cut_raw_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Low cut-off for the DSS data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function low_cut_SDSS_Callback(hObject, eventdata, handles)
% hObject    handle to low_cut_SDSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of low_cut_SDSS as text
%        str2double(get(hObject,'String')) returns contents of low_cut_SDSS as a double


% --- Executes during object creation, after setting all properties.
function low_cut_SDSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to low_cut_SDSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%High cut-off for the DSS data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function high_cut_SDSS_Callback(hObject, eventdata, handles)
% hObject    handle to high_cut_SDSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of high_cut_SDSS as text
%        str2double(get(hObject,'String')) returns contents of high_cut_SDSS as a double


% --- Executes during object creation, after setting all properties.
function high_cut_SDSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to high_cut_SDSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2*Order of the filter for the SDSS data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in order_filt_SDSS.
function order_filt_SDSS_Callback(hObject, eventdata, handles)
% hObject    handle to order_filt_SDSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns order_filt_SDSS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from order_filt_SDSS


% --- Executes during object creation, after setting all properties.
function order_filt_SDSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to order_filt_SDSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Components for the SDSS data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Components_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to Components_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Components_DSS as text
%        str2double(get(hObject,'String')) returns contents of Components_DSS as a double


% --- Executes during object creation, after setting all properties.
function Components_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Components_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the stimulus for the background noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Stim_Noise_Decoding.
function Stim_Noise_Decoding_Callback(hObject, eventdata, handles)
% hObject    handle to Stim_Noise_Decoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_selected_noise;
global wav_file_directory_noise;

[wav_file_selected_noise,wav_file_directory_noise] = uigetfile('*.wav','Select the sound file for the noise');

if (wav_file_selected_noise == 0)
    
    set(handles.Stim_Noise_Dec_Uploaded,'String','No File selected');
    
else
    
set(handles.Stim_Noise_Dec_Uploaded,'String',wav_file_selected_noise);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Stimulus for the background noise uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Stim_Noise_Dec_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Stim_Noise_Dec_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stim_Noise_Dec_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Stim_Noise_Dec_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Stim_Noise_Dec_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stim_Noise_Dec_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sampling Frequency of the MEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Sampling_Freq_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Sampling_Freq_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sampling_Freq_Data as text
%        str2double(get(hObject,'String')) returns contents of Sampling_Freq_Data as a double


% --- Executes during object creation, after setting all properties.
function Sampling_Freq_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sampling_Freq_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Order of the FIR filter for the MEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function order_filt_raw_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to order_filt_raw_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of order_filt_raw_MEG as text
%        str2double(get(hObject,'String')) returns contents of order_filt_raw_MEG as a double


% --- Executes during object creation, after setting all properties.
function order_filt_raw_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to order_filt_raw_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time-shift to compensate for the response delay of the MEG to the stimuli
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function TW_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to TW_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TW_DSS as text
%        str2double(get(hObject,'String')) returns contents of TW_DSS as a double


% --- Executes during object creation, after setting all properties.
function TW_DSS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TW_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Number of subjects to be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Subjcet_Number_TRF_Callback(hObject, eventdata, handles)
% hObject    handle to Subjcet_Number_TRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Subjcet_Number_TRF as text
%        str2double(get(hObject,'String')) returns contents of Subjcet_Number_TRF as a double


% --- Executes during object creation, after setting all properties.
function Subjcet_Number_TRF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Subjcet_Number_TRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the background stimulus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Background.
function Upload_Background_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_background;
global wav_file_background_directory;

[wav_file_background,wav_file_background_directory] = uigetfile('*.wav','Select the background sound file');

if (wav_file_background == 0)
    
    set(handles.Background_Uploaded,'String','No File selected');
    
else
    
set(handles.Background_Uploaded,'String',wav_file_background);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Background stimulus uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Background_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Background_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Background_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Background_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Background_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Background_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the background noise stimulus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Background_Noise.
function Upload_Background_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Background_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_noise_background;
global wav_file_noise_background_directory;

[wav_file_noise_background,wav_file_noise_background_directory] = uigetfile('*.wav','Select the noise background sound file');

if (wav_file_noise_background == 0)
   
    set(handles.Background_Noise_Uploaded,'String','No File selected');
    
else
    
set(handles.Background_Noise_Uploaded,'String',wav_file_noise_background);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Background noise stimulus uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Background_Noise_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Background_Noise_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Background_Noise_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Background_Noise_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Background_Noise_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Background_Noise_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select the model to be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Model_TRF_Choice.
function Model_TRF_Choice_Callback(hObject, eventdata, handles)
% hObject    handle to Model_TRF_Choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Model_TRF_Choice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Model_TRF_Choice

if(get(handles.Model_TRF_Choice,'Value') > 4 &&  get(handles.Model_TRF_Choice,'Value') < 9)
   
    set(handles.Upload_Stim_MEG,'Enable','on');
    set(handles.Stim_Uploaded_MEG,'Enable','on');
    set(handles.Stim_Noise_Decoding,'Enable','on');
    set(handles.Stim_Noise_Dec_Uploaded,'Enable','on');
    set(handles.Upload_Background,'Enable','off');
    set(handles.Background_Uploaded,'Enable','off');
    set(handles.Upload_Background_Noise,'Enable','off');
    set(handles.Background_Noise_Uploaded,'Enable','off');
    
else
    
    set(handles.Upload_Stim_MEG,'Enable','on');
    set(handles.Stim_Uploaded_MEG,'Enable','on');
    set(handles.Stim_Noise_Decoding,'Enable','on');
    set(handles.Stim_Noise_Dec_Uploaded,'Enable','on');
    set(handles.Upload_Background,'Enable','on');
    set(handles.Background_Uploaded,'Enable','on');
    set(handles.Upload_Background_Noise,'Enable','on');
    set(handles.Background_Noise_Uploaded,'Enable','on');
    
end

if(get(handles.Model_TRF_Choice,'Value') > 9)
   
    set(handles.Upload_Stim_MEG,'Enable','off');
    set(handles.Stim_Uploaded_MEG,'Enable','off');
    set(handles.Stim_Noise_Decoding,'Enable','off');
    set(handles.Stim_Noise_Dec_Uploaded,'Enable','off');
    set(handles.Upload_Background,'Enable','off');
    set(handles.Background_Uploaded,'Enable','off');
    set(handles.Upload_Background_Noise,'Enable','off');
    set(handles.Background_Noise_Uploaded,'Enable','off');
        
end

if get(handles.Model_TRF_Choice,'Value') == 9 || get(handles.Model_TRF_Choice,'Value') == 10 
   
    set(handles.Components_DSS,'Enable','on')
    
    set(handles.Add_MEG_Uploaded,'Enable','off')
    
    set(handles.low_cut_raw_MEG,'Enable','on')
     set(handles.high_cut_raw_MEG,'Enable','on')
    set(handles.order_filt_raw_MEG,'Enable','on')
         set(handles.Filter_Rotation_Matrix,'Enable','on')
         
          set(handles.low_cut_SDSS,'Enable','off')
     set(handles.high_cut_SDSS,'Enable','off')
    set(handles.order_filt_SDSS,'Enable','off')
         set(handles.Filter_DSS,'Enable','off')
         set(handles.Zero_Phase_Filt_Decoding,'Enable','off')
         set(handles.TW_DSS,'Enable','off')
         set(handles.Dec_Factor_TRF,'Enable','off')
         
         set(handles.Subjcet_Number_TRF,'Enable','off')
         
         
         
elseif get(handles.Model_TRF_Choice,'Value') == 11
    
    set(handles.Components_DSS,'Enable','off')
        
    set(handles.Add_MEG_Uploaded,'Enable','on')
    
    set(handles.low_cut_raw_MEG,'Enable','off')
     set(handles.high_cut_raw_MEG,'Enable','off')
    set(handles.order_filt_raw_MEG,'Enable','off')
         set(handles.Filter_Rotation_Matrix,'Enable','off')
         
          set(handles.low_cut_SDSS,'Enable','off')
     set(handles.high_cut_SDSS,'Enable','off')
    set(handles.order_filt_SDSS,'Enable','off')
         set(handles.Filter_DSS,'Enable','off')
         set(handles.Zero_Phase_Filt_Decoding,'Enable','off')
    set(handles.TW_DSS,'Enable','off')
         set(handles.Dec_Factor_TRF,'Enable','off')         
         
         set(handles.Subjcet_Number_TRF,'Enable','off')
         
elseif get(handles.Model_TRF_Choice,'Value') < 9
    
    set(handles.Components_DSS,'Enable','on')
        
    set(handles.Add_MEG_Uploaded,'Enable','off')
    
     set(handles.low_cut_raw_MEG,'Enable','off')
     set(handles.high_cut_raw_MEG,'Enable','off')
    set(handles.order_filt_raw_MEG,'Enable','off')
         set(handles.Filter_Rotation_Matrix,'Enable','off')
         
          set(handles.low_cut_SDSS,'Enable','on')
     set(handles.high_cut_SDSS,'Enable','on')
    set(handles.order_filt_SDSS,'Enable','on')
         set(handles.Filter_DSS,'Enable','on')
         set(handles.Zero_Phase_Filt_Decoding,'Enable','on')
    set(handles.TW_DSS,'Enable','on')
         set(handles.Dec_Factor_TRF,'Enable','on')         
         
         set(handles.Subjcet_Number_TRF,'Enable','on')
         
end


% --- Executes during object creation, after setting all properties.
function Model_TRF_Choice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Model_TRF_Choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Additional trials to upload
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir_Add_MEG.
function Upload_Dir_Add_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir_Add_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global meg_file_add;
global meg_file_add_directory;

[meg_file_add,meg_file_add_directory] = uigetfile('*.mat','Select the additional MEG files');

if (meg_file_add == 0)

    set(handles.Add_MEG_Uploaded,'String','No File selected');
    
else
    
set(handles.Add_MEG_Uploaded,'String',meg_file_add_directory);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory uploaded for additional trials 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Add_MEG_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to Add_MEG_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Add_MEG_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of Add_MEG_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function Add_MEG_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Add_MEG_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu for the correlation of the trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Correlation_Trials_MEG_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Correlation_Trials_MEG_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Corr_Trials_MEG_GUI();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decimation factor for the TRF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dec_Factor_TRF_Callback(hObject, eventdata, handles)
% hObject    handle to Dec_Factor_TRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dec_Factor_TRF as text
%        str2double(get(hObject,'String')) returns contents of Dec_Factor_TRF as a double


% --- Executes during object creation, after setting all properties.
function Dec_Factor_TRF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dec_Factor_TRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choice between Zero-phase or non-zero phase filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Zero_Phase_Filt_Decoding.
function Zero_Phase_Filt_Decoding_Callback(hObject, eventdata, handles)
% hObject    handle to Zero_Phase_Filt_Decoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Zero_Phase_Filt_Decoding contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Zero_Phase_Filt_Decoding


% --- Executes during object creation, after setting all properties.
function Zero_Phase_Filt_Decoding_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Zero_Phase_Filt_Decoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Filter the DSS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Filter_DSS.
function Filter_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Filter_DSS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Filter the rotation matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Filter_Rotation_Matrix.
function Filter_Rotation_Matrix_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_Rotation_Matrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Filter_Rotation_Matrix

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Filter the auditory stimuli
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Filter_Auditory_Stimuli.
function Filter_Auditory_Stimuli_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_Auditory_Stimuli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Filter_Auditory_Stimuli

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to decode naural data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Decoding_Help_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Decoding_Help_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Decoding_MEG_Help();
