function varargout = Create_Stimuli(varargin)
% CREATE_STIMULI MATLAB code for Create_Stimuli.fig
%      CREATE_STIMULI, by itself, creates a new CREATE_STIMULI or raises the existing
%      singleton*.
%
%      H = CREATE_STIMULI returns the handle to a new CREATE_STIMULI or the handle to
%      the existing singleton*.
%
%      CREATE_STIMULI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREATE_STIMULI.M with the given input arguments.
%
%      CREATE_STIMULI('Property','Value',...) creates a new CREATE_STIMULI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Create_Stimuli_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Create_Stimuli_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Create_Stimuli

% Last Modified by GUIDE v2.5 13-Jan-2022 10:09:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Create_Stimuli_OpeningFcn, ...
                   'gui_OutputFcn',  @Create_Stimuli_OutputFcn, ...
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


% --- Executes just before Create_Stimuli is made visible.
function Create_Stimuli_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Create_Stimuli (see VARARGIN)

% Choose default command line output for Create_Stimuli
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Create_Stimuli wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Create_Stimuli_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Samples for the Tone Bursts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Duration_Tone_Burst_Callback(hObject, eventdata, handles)
% hObject    handle to Duration_Tone_Burst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Duration_Tone_Burst as text
%        str2double(get(hObject,'String')) returns contents of Duration_Tone_Burst as a double


% --- Executes during object creation, after setting all properties.
function Duration_Tone_Burst_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Duration_Tone_Burst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sampling Frequency for the Tone Bursts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SF_Tones_Burst_Callback(hObject, eventdata, handles)
% hObject    handle to SF_Tones_Burst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SF_Tones_Burst as text
%        str2double(get(hObject,'String')) returns contents of SF_Tones_Burst as a double


% --- Executes during object creation, after setting all properties.
function SF_Tones_Burst_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SF_Tones_Burst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gain for the Tone Bursts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Gain_Tones_Callback(hObject, eventdata, handles)
% hObject    handle to Gain_Tones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Gain_Tones as text
%        str2double(get(hObject,'String')) returns contents of Gain_Tones as a double


% --- Executes during object creation, after setting all properties.
function Gain_Tones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gain_Tones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ramping for the Tone Bursts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Ramping_Tones.
function Ramping_Tones_Callback(hObject, eventdata, handles)
% hObject    handle to Ramping_Tones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Ramping_Tones contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Ramping_Tones
if (get(handles.Ramping_Tones,'Value') > 1)
   
    set(handles.Rise_Fall_Ramping,'Enable','ON')
    
else
    
    set(handles.Rise_Fall_Ramping,'Enable','Off')
        
end

% --- Executes during object creation, after setting all properties.
function Ramping_Tones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ramping_Tones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Create tones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Create_Tones_Button.
function Create_Tones_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Create_Tones_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Creating and saving the tones
A = str2double(get(handles.Gain_Tones,'String'));
sf = str2double(get(handles.SF_Tones_Burst,'String'));
f = str2double(get(handles.Frequency_Tone_Burst,'String'));
samples_tone = round(str2double(get(handles.Duration_Tone_Burst,'String'))*sf);

t = [0:1/sf:samples_tone/sf];
y = A*sin(2*pi*f*t);

%Plotting the time series and the FFT
figure
subplot(2,1,1)
plot(t,y)
ylabel('\bfAmplitude')
xlabel('\bfTime(s)')
title('\bfTone Burst')

subplot(2,1,2)
pwelch(y,length(y),length(y)/2,length(y),sf)

set(gca,'fontweight','bold')

%Saving the tone

y_save = [y;y]'; 

    audiowrite(['Tone_burst_Pos_' num2str(f) '.wav'],y_save,sf)
audiowrite(['Tone_burst_Neg_' num2str(f) '.wav'],-y_save,sf)

%Ramping and saving the ramped-tone
ramping_type = get(handles.Ramping_Tones,'Value');
ramping_choices = get(handles.Ramping_Tones,'String');
rftime = (str2double(get(handles.Rise_Fall_Ramping,'String')))/1000;

if (ramping_type > 1)

ramped_tone = AddTemporalRamps(y,rftime,sf,ramping_type - 2);

%Plotting the time series and the FFT
figure
subplot(2,1,1)
plot(t,ramped_tone)
ylabel('\bfAmplitude')
xlabel('\bfTime(s)')
title('\bfRamped Tone Burst')

subplot(2,1,2)
pwelch(ramped_tone,length(ramped_tone),length(ramped_tone)/2,length(ramped_tone),sf)

set(gca,'fontweight','bold')

%Building a 2-channels tone
ramped_tone = [ramped_tone;ramped_tone]';

audiowrite(['Ramped_Tone_burst_Pos_' num2str(f) '.wav'],ramped_tone,sf)
audiowrite(['Ramped_Tone_burst_Neg_' num2str(f) '.wav'],-ramped_tone,sf)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Checking if the signal should be amplitude modulated
if (get(handles.Ampl_Mod_Tone,'Value') == 1)

    for yy = 1:size(ramped_tone,2)
    
     mod_tone(:,yy) = (1+(str2double(get(handles.Mod_Depth_Tone,'String'))/100)*sin(2*pi*t*str2double(get(handles.Mod_Freq_Tone,'String')))).*ramped_tone(:,yy)';
    
     %Plotting the time series and the FFT for each channel
figure
subplot(2,1,1)
plot(t,mod_tone)
ylabel('\bfAmplitude')
xlabel('\bfTime(s)')
title('\bfRamped Amplitude Modulated Tone Burst')

subplot(2,1,2)
pwelch(mod_tone,length(mod_tone),length(mod_tone)/2,length(mod_tone),sf)

set(gca,'fontweight','bold')
     
    end
end

try
audiowrite(['Mod_Ramped_Tone_burst_Pos_' num2str(f) '.wav'],mod_tone,sf)
audiowrite(['Mod_Ramped_Tone_burst_Neg_' num2str(f) '.wav'],-mod_tone,sf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
catch
    
end

message = ('The tone has been created and saved');

        msgbox(message,'Operations completed','warn');

else

if (get(handles.Ampl_Mod_Tone,'Value') == 1)

    for yy = 1:size(y_save,2)
    
     mod_tone(:,yy) = (1+(str2double(get(handles.Mod_Depth_Tone,'String'))/100)*sin(2*pi*t*str2double(get(handles.Mod_Freq_Tone,'String')))).*y_save(:,yy)';
    
     %Plotting the time series and the FFT for each channel
figure
subplot(2,1,1)
plot(t,mod_tone)
ylabel('\bfAmplitude')
xlabel('\bfTime(s)')
title('\bfAmplitude Modulated Tone Burst')

subplot(2,1,2)
pwelch(mod_tone,length(mod_tone),length(mod_tone)/2,length(mod_tone),sf)

set(gca,'fontweight','bold')
     
    end
end

try
audiowrite(['Mod_Tone_burst_Pos_' num2str(f) '.wav'],mod_tone,sf)
audiowrite(['Mod_Tone_burst_Neg_' num2str(f) '.wav'],-mod_tone,sf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
catch
    
end

message = ('The tone has been created and saved');

        msgbox(message,'Operations completed','warn');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Carry frequency for the Tone Bursts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Frequency_Tone_Burst_Callback(hObject, eventdata, handles)
% hObject    handle to Frequency_Tone_Burst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Frequency_Tone_Burst as text
%        str2double(get(hObject,'String')) returns contents of Frequency_Tone_Burst as a double


% --- Executes during object creation, after setting all properties.
function Frequency_Tone_Burst_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Frequency_Tone_Burst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Rise/Fall for ramping in ms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Rise_Fall_Ramping_Callback(hObject, eventdata, handles)
% hObject    handle to Rise_Fall_Ramping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rise_Fall_Ramping as text
%        str2double(get(hObject,'String')) returns contents of Rise_Fall_Ramping as a double


% --- Executes during object creation, after setting all properties.
function Rise_Fall_Ramping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rise_Fall_Ramping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Band-width of the noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function BW_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to BW_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BW_Noise as text
%        str2double(get(hObject,'String')) returns contents of BW_Noise as a double


% --- Executes during object creation, after setting all properties.
function BW_Noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BW_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sampling Frequency of the noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SF_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to SF_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SF_Noise as text
%        str2double(get(hObject,'String')) returns contents of SF_Noise as a double


% --- Executes during object creation, after setting all properties.
function SF_Noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SF_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Center frequency of the noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CF_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to CF_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CF_Noise as text
%        str2double(get(hObject,'String')) returns contents of CF_Noise as a double


% --- Executes during object creation, after setting all properties.
function CF_Noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CF_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Create the noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Create_Noise_Button.
function Create_Noise_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Create_Noise_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Creating and saving the selected noise
cf_noise = str2double(get(handles.CF_Noise,'String'));
sf_noise = str2double(get(handles.SF_Noise,'String'));
duration_noise = str2double(get(handles.Duration_Noise,'String'));

%% Generate 1000 repetitions of the white noise

if (get(handles.Noise_Selection,'Value') == 2)

    message = 'The narrow-band noise option is currently unavailable';

        msgbox(message,'End of the RMS analysis','warn','replace');

  return;  
  
    bw_noise = str2double(get(handles.BW_Noise,'String'));

%Creating the variable to ramp the noise
ramping_type_noise = get(handles.Ramping_Noise,'Value');
ramping_choices_noise = get(handles.Ramping_Noise,'String');
rftime_noise = (str2double(get(handles.Rise_Fall_Noise,'String')))/1000;

create_narrow_band_noise (cf_noise,sf_noise,duration_noise,bw_noise,ramping_type_noise,ramping_choices_noise,rftime_noise)

%%This is for BMLD (S0Npi)
create_narrow_band_noise_so_npi (cf_noise,sf_noise,duration_noise,bw_noise,ramping_type_noise,ramping_choices_noise,rftime_noise)

else
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Create the Broad-Band noise
%% Generate the white noise

white_noise = wgn(1,duration_noise*sf_noise,0);
white_noise = 0.3*white_noise;

[b,a] = butter(str2double(get(handles.Order_IIR_Create_Stimuli,'String')),(str2double(get(handles.HP_IIR_Noise,'String')))/(sf_noise/2),'Low');

fvtool(b,a)
check_stability(b,a)
 
wnoisef = filter(b,a,white_noise);

t = [0:length(wnoisef)-1]/sf_noise;

%Plotting the time series and the FFT
figure
subplot(2,1,1)
title('\bfBroad-Band Noise')
plot(t,wnoisef)
ylabel('\bfAmplitude')
xlabel('\bfTime(s)')

subplot(2,1,2)
pwelch(wnoisef,length(wnoisef),length(wnoisef)/2,length(wnoisef),sf_noise)

set(gca,'fontweight','bold')

%Creating a 2-channels noise with the same polarity
nz_same_pol = [wnoisef;wnoisef]';

%Saving the noise
audiowrite(['BB_Noise_Same_Pol_' num2str(cf_noise) '.wav'],nz_same_pol,sf_noise)

%Creating a 2-channels noise with different polarities
nz = [wnoisef;-wnoisef]';

%Saving the noise
audiowrite(['BB_Noise_Pos_Neg_' num2str(cf_noise) '.wav'],nz,sf_noise)


end

message = ('The Noise has been create and saved');

        msgbox(message,'Operations completed','warn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Duration of the noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Duration_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to Duration_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Duration_Noise as text
%        str2double(get(hObject,'String')) returns contents of Duration_Noise as a double


% --- Executes during object creation, after setting all properties.
function Duration_Noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Duration_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Order of the low-pass filter for the broadban noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Order_IIR_Create_Stimuli_Callback(hObject, eventdata, handles)
% hObject    handle to Order_IIR_Create_Stimuli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Order_IIR_Create_Stimuli as text
%        str2double(get(hObject,'String')) returns contents of Order_IIR_Create_Stimuli as a double


% --- Executes during object creation, after setting all properties.
function Order_IIR_Create_Stimuli_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Order_IIR_Create_Stimuli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Corner frequency for the low-pass filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function HP_IIR_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to HP_IIR_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HP_IIR_Noise as text
%        str2double(get(hObject,'String')) returns contents of HP_IIR_Noise as a double


% --- Executes during object creation, after setting all properties.
function HP_IIR_Noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HP_IIR_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ramping type for the noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Ramping_Noise.
function Ramping_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to Ramping_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Ramping_Noise contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Ramping_Noise
contents = cellstr(get(hObject,'String'))

% --- Executes during object creation, after setting all properties.
function Ramping_Noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ramping_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ramping time for the noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Rise_Fall_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to Rise_Fall_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rise_Fall_Noise as text
%        str2double(get(hObject,'String')) returns contents of Rise_Fall_Noise as a double


% --- Executes during object creation, after setting all properties.
function Rise_Fall_Noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rise_Fall_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select which type of noise you want to create
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Noise_Selection.
function Noise_Selection_Callback(hObject, eventdata, handles)
% hObject    handle to Noise_Selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Noise_Selection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Noise_Selection


% --- Executes during object creation, after setting all properties.
function Noise_Selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Noise_Selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Frequency modulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Mod_Freq_Tone_Callback(hObject, eventdata, handles)
% hObject    handle to Mod_Freq_Tone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mod_Freq_Tone as text
%        str2double(get(hObject,'String')) returns contents of Mod_Freq_Tone as a double


% --- Executes during object creation, after setting all properties.
function Mod_Freq_Tone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mod_Freq_Tone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modulation depth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Mod_Depth_Tone_Callback(hObject, eventdata, handles)
% hObject    handle to Mod_Depth_Tone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mod_Depth_Tone as text
%        str2double(get(hObject,'String')) returns contents of Mod_Depth_Tone as a double


% --- Executes during object creation, after setting all properties.
function Mod_Depth_Tone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mod_Depth_Tone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the tone will be amplitude modulated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Ampl_Mod_Tone.
function Ampl_Mod_Tone_Callback(hObject, eventdata, handles)
% hObject    handle to Ampl_Mod_Tone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Ampl_Mod_Tone
if(get(handles.Ampl_Mod_Tone,'Value') == 1)
   
    set(handles.AM_Tag,'Visible','On');
    
else
    
    set(handles.AM_Tag,'Visible','Off');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to create the stimuli
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Create_Stimuli_Help_Callback(hObject, eventdata, handles)
% hObject    handle to Create_Stimuli_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Create_Stimuli_Help();


% --- Executes during object deletion, before destroying properties.
function Ramping_Tones_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to Ramping_Tones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
