function varargout = Corr_IHS_Averages(varargin)
% CORR_IHS_AVERAGES MATLAB code for Corr_IHS_Averages.fig
%      CORR_IHS_AVERAGES, by itself, creates a new CORR_IHS_AVERAGES or raises the existing
%      singleton*.
%
%      H = CORR_IHS_AVERAGES returns the handle to a new CORR_IHS_AVERAGES or the handle to
%      the existing singleton*.
%
%      CORR_IHS_AVERAGES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CORR_IHS_AVERAGES.M with the given input arguments.
%
%      CORR_IHS_AVERAGES('Property','Value',...) creates a new CORR_IHS_AVERAGES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Corr_IHS_Averages_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Corr_IHS_Averages_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Corr_IHS_Averages

% Last Modified by GUIDE v2.5 13-Jan-2022 12:43:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Corr_IHS_Averages_OpeningFcn, ...
                   'gui_OutputFcn',  @Corr_IHS_Averages_OutputFcn, ...
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


% --- Executes just before Corr_IHS_Averages is made visible.
function Corr_IHS_Averages_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Corr_IHS_Averages (see VARARGIN)

% Choose default command line output for Corr_IHS_Averages
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Corr_IHS_Averages wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Corr_IHS_Averages_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File "A" uploaded for the correlation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_A_Uploaded_Corr_Callback(hObject, eventdata, handles)
% hObject    handle to File_A_Uploaded_Corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_A_Uploaded_Corr as text
%        str2double(get(hObject,'String')) returns contents of File_A_Uploaded_Corr as a double


% --- Executes during object creation, after setting all properties.
function File_A_Uploaded_Corr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_A_Uploaded_Corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload File "A"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_File_A_Corr.
function Upload_File_A_Corr_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_File_A_Corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IHS_file_A;
global IHS_file_A_directory;

[IHS_file_A,IHS_file_A_directory] = uigetfile('*.mat','Select file "A"');

set(handles.File_A_Uploaded_Corr,'String',IHS_file_A);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File "B" uploaded for the correlation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_B_Uploaded_Corr_Callback(hObject, eventdata, handles)
% hObject    handle to File_B_Uploaded_Corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_B_Uploaded_Corr as text
%        str2double(get(hObject,'String')) returns contents of File_B_Uploaded_Corr as a double


% --- Executes during object creation, after setting all properties.
function File_B_Uploaded_Corr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_B_Uploaded_Corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload File "B"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_File_B_Corr.
function Upload_File_B_Corr_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_File_B_Corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IHS_file_B;
global IHS_file_B_directory;

[IHS_file_B,IHS_file_B_directory] = uigetfile('*.mat','Select the file "B"');

set(handles.File_B_Uploaded_Corr,'String',IHS_file_B);

% --- Executes on button press in Corr_IHS_Calculate.
function Corr_IHS_Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Corr_IHS_Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IHS_file_A;
global IHS_file_A_directory;
global IHS_file_B;
global IHS_file_B_directory;

cd(IHS_file_A_directory)
file_A = load(IHS_file_A);

cd(IHS_file_B_directory)
file_B = load(IHS_file_B);

file_A_av = file_A.data_exported.grand_av;
file_B_av = file_B.data_exported.grand_av;

%{
find_time_start = find(file_A.data_exported.time >= 5,1,'First');
find_time_end = find(file_A.data_exported.time <= 120,1,'Last');

[b,a] = butter(3,[70 600]/(file_A.data_exported.sampling_frequency/2)); 

file_A_av_time_window = filtfilt(b,a,file_A_av(1,find_time_start:find_time_end));
file_B_av_time_window = filtfilt(b,a,file_B_av(1,find_time_start:find_time_end));

corr_value = corr2(file_A_av_time_window,file_B_av_time_window);


time_d = file_A.data_exported.time(find_time_start:find_time_end);

figure
plot(time_d,file_A_av_time_window)
hold on
plot(time_d,file_B_av_time_window,'r')

axis tight

xlabel('\bfTime(ms)')
ylabel('\bfAmplitude(uV)')
title(['\bfThe correlation value is: ' num2str(corr_value)])

set(gca,'fontweight','bold')

legend(IHS_file_A(1:end-4),IHS_file_B(1:end-4))
%}

corr_value = corr2(file_A_av,file_B_av);


time_d = file_A.data_exported.time;

figure
plot(time_d,file_A_av)
hold on
plot(time_d,file_B_av,'r')

axis tight

xlabel('\bfTime(ms)')
ylabel('\bfAmplitude(uV)')
title(['\bfThe correlation value is: ' num2str(corr_value)])

set(gca,'fontweight','bold')

legend(IHS_file_A(1:end-4),IHS_file_B(1:end-4))
saveas(gcf,['Corr_Time_Series' IHS_file_A(1:end-4) '_'  IHS_file_B(1:end-4) '.fig'])

%{
%% Calculating the latencies
[pks_A,locs_A] = findpeaks(file_A_av_time_window,'minpeakheight',0.1,'minpeakdistance',9);
[pks_B,locs_B] = findpeaks(file_B_av_time_window,'minpeakheight',0.1,'minpeakdistance',9);

norm_factor = [33 43 53 63 73 83 93 103 113];

%% Eliminating the fake peaks
for kk = 1:length(norm_factor)

    find_current_peak_A = find(time_d(locs_A) <= norm_factor(kk));
    find_current_peak_B = find(time_d(locs_B) <= norm_factor(kk));

temp_peaks_A(kk) = pks_A(find_current_peak_A(end));
temp_loc_A(kk) = locs_A(find_current_peak_A(end));

temp_peaks_B(kk) = pks_B(find_current_peak_B(end));
temp_loc_B(kk) = locs_B(find_current_peak_B(end));

end

diff_latency = (temp_loc_A - temp_loc_B)/file_A.data_exported.sampling_frequency;

pks_A = temp_peaks_A;
locs_A = temp_loc_A;

pks_B = temp_peaks_B;
locs_B = temp_loc_B;

figure
subplot(2,1,1)
 stem(time_d(locs_A),pks_A)
 hold on
  stem(time_d(locs_B),pks_B,'r')
 
  xlabel('\bfTime(ms)')
ylabel('\bfAmplitude(uV)')

title('\bfLatency')

set(gca,'fontweight','bold')

legend(IHS_file_A(1:end-4),IHS_file_B(1:end-4))

subplot(2,1,2)
stem(time_d(locs_B),abs(diff_latency),'k')

xlabel('\bfTime(ms)')
ylabel('\bfTime Difference(ms)')

title('\bfTike difference of the latencies')

set(gca,'fontweight','bold')

saveas(gcf,['Latency_Diff' IHS_file_A(1:end-4) '_'  IHS_file_B(1:end-4) '.fig'])
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to calculate the correlation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Corr_Average_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Corr_Average_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Corr_IHS_Averages_Help();
