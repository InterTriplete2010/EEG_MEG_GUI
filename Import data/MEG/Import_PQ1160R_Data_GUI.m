function varargout = Import_PQ1160R_Data_GUI(varargin)
%IMPORT_PQ1160R_DATA_GUI M-file for Import_PQ1160R_Data_GUI.fig
%      IMPORT_PQ1160R_DATA_GUI, by itself, creates a new IMPORT_PQ1160R_DATA_GUI or raises the existing
%      singleton*.
%
%      H = IMPORT_PQ1160R_DATA_GUI returns the handle to a new IMPORT_PQ1160R_DATA_GUI or the handle to
%      the existing singleton*.
%
%      IMPORT_PQ1160R_DATA_GUI('Property','Value',...) creates a new IMPORT_PQ1160R_DATA_GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Import_PQ1160R_Data_GUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      IMPORT_PQ1160R_DATA_GUI('CALLBACK') and IMPORT_PQ1160R_DATA_GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in IMPORT_PQ1160R_DATA_GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Import_PQ1160R_Data_GUI

% Last Modified by GUIDE v2.5 16-Feb-2022 14:15:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Import_PQ1160R_Data_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Import_PQ1160R_Data_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Import_PQ1160R_Data_GUI is made visible.
function Import_PQ1160R_Data_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Import_PQ1160R_Data_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Import_PQ1160R_Data_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Import_PQ1160R_Data_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dir where to save the data for PQ1160R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_PQ1160R_Save_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_PQ1160R_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_PQ1160R_Save_Data as text
%        str2double(get(hObject,'String')) returns contents of Dir_PQ1160R_Save_Data as a double


% --- Executes during object creation, after setting all properties.
function Dir_PQ1160R_Save_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_PQ1160R_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the folder where to save the data for PQ1160R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Folder_PQ1160R_Save_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Folder_PQ1160R_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Folder_PQ1160R_Save_Data as text
%        str2double(get(hObject,'String')) returns contents of Folder_PQ1160R_Save_Data as a double


% --- Executes during object creation, after setting all properties.
function Folder_PQ1160R_Save_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Folder_PQ1160R_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the mat file where to save the data for PQ1160R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_PQ1160R_Save_Data_Callback(hObject, eventdata, handles)
% hObject    handle to File_PQ1160R_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_PQ1160R_Save_Data as text
%        str2double(get(hObject,'String')) returns contents of File_PQ1160R_Save_Data as a double


% --- Executes during object creation, after setting all properties.
function File_PQ1160R_Save_Data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_PQ1160R_Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the PQ1160R MEG data 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_PQ1160R_Data.
function Upload_PQ1160R_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_PQ1160R_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global panel_info_tag;
global name_file_tag;
global channels_tag;
global samples_tag;
global sampling_frequency_tag;
global trial_duration_minutes_tag;
global trial_duration_seconds_tag;
global electrodes_recorded_tag;
global triggers_number_tag;
global triggers_type_tag;
global data_exported;

data_exported = [];
if (get(handles.Denoise_MEG,'Value') == 1)
    
channels_to_be_removed_denoise = str2num(get(handles.Channels_Removed_Denoise_MEG,'String'));   
set_sat_channels_zero = get(handles.Saturating_channels_zero_MEG,'Value');
channel_sat = str2double(get(handles.Channel_Saturating_MEG,'String'));   
vibr_channels = get(handles.Vibrat_Chan_MEG,'Value');

output_info = sqdDenoise(channels_to_be_removed_denoise,set_sat_channels_zero,channel_sat,vibr_channels);

SQD_file_selected = output_info.destinationFile(find(output_info.destinationFile == '\',1,'last') + 1:end);
SQD_file_directory = output_info.directory;

else
    
    channels_to_be_removed_denoise = str2num(get(handles.Channels_Removed_Denoise_MEG,'String'));

[SQD_file_selected,SQD_file_directory] = uigetfile('*.sqd','Select the "sqd" file');

end

set(handles.PQ1160R_Data_Uploaded,'String',SQD_file_selected);

%Read PQ1160R data
cd(SQD_file_directory)

Channels_to_be_extracted = str2num(get(handles.Channels_Extracted_MEG,'String'));
Time_Window_to_be_extracted = str2num(get(handles.Time_Window_MEG,'String'));

%% Loading the MEG-SQD file selected
if (get(handles.Check_Channels_MEG,'Value') ~= 1 && get(handles.Check_Window_MEG,'Value') ~= 1)

    [MEG_data, Info_MEG] = sqdread(SQD_file_selected,'Format','double');
    
    MEG.data = MEG_data';
    
    Channels_to_be_extracted = [1:size(MEG.data)];
    
elseif ((get(handles.Check_Channels_MEG,'Value') ~= 1 && get(handles.Check_Window_MEG,'Value') == 1))
    
    [MEG_data, Info_MEG] = sqdread(SQD_file_selected,'Samples',[Time_Window_to_be_extracted(1) Time_Window_to_be_extracted(end)],'Format','double');
    
    MEG.data = MEG_data';
    
    Channels_to_be_extracted = [1:size(MEG.data)];
    
    elseif ((get(handles.Check_Channels_MEG,'Value') == 1 && get(handles.Check_Window_MEG,'Value') ~= 1))
    
    [MEG_data, Info_MEG] = sqdread(SQD_file_selected,'Channels',Channels_to_be_extracted,'Format','double');
    
    MEG.data = MEG_data';
    
    elseif ((get(handles.Check_Channels_MEG,'Value') == 1 && get(handles.Check_Window_MEG,'Value') == 1))
    
    [MEG_data, Info_MEG] = sqdread(SQD_file_selected,'Channels',Channels_to_be_extracted,'Samples',[Time_Window_to_be_extracted(1) Time_Window_to_be_extracted(end)],'Format','double');
    
    MEG.data = MEG_data';
    
end

s_rate = Info_MEG.SampleRate;

delay_sound_val = s_rate*str2double(get(handles.Delay_Sound_MEG,'String'))/1000;
min_distance_triggers = s_rate*5/1000;

latency_event = [];
type_event = [];

save_data_folder = get(handles.Folder_PQ1160R_Save_Data,'String');
save_data_directory = get(handles.Dir_PQ1160R_Save_Data,'String');
name_mat_file = get(handles.File_PQ1160R_Save_Data,'String');

cd([save_data_directory])
mkdir(save_data_folder)
cd([save_data_directory '\' save_data_folder]);

%% Saving the names and locations of the electrodes;
for kk = 1:size(MEG.data,1)
    
labels_electrodes(kk,1) = {num2str(Channels_to_be_extracted(kk))};

end

xlswrite ('Electrodes_Recorded',labels_electrodes);

trigger_threshold_value = str2double(get(handles.Threshold_Trigger,'String'));
trig_chan_selected = str2double(get(handles.Tigger_Channels_MEG,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extracting the triggers if the Evoked Potentials need to be averaged
if (get(handles.Analysis_MEG_data,'Value') == 2) 
if ~isempty(str2double(get(handles.Tigger_Channels_MEG,'String'))) && ~isnan(str2double(get(handles.Tigger_Channels_MEG,'String')))
    
     latency_event = [];
     type_event = [];
     
     message = 'Extracting the data.....';

        msgbox(message,'Extraction in progress.....','warn','replace');

        trigger_names = str2double(get(handles.Tigger_Channels_MEG,'String'));
 triggers_channels = MEG.data(str2double(get(handles.Tigger_Channels_MEG,'String')),:);

  for oo = 1:size(triggers_channels,1)
 
      try
      
 latency_event = [latency_event find(diff(triggers_channels(oo,:)) < trigger_threshold_value)] + delay_sound_val;   %10 ms were added to compensate for the delay of the transmission of the sound
 
 %checking if "fake" triggers have been detected based on 5 ms distance
 %between 2 consecutive triggers
 temp_fake_trigg = find(diff(latency_event) < min_distance_triggers);
 size_type_event = length(temp_fake_trigg);
 
 if (~isempty(temp_fake_trigg))
         
    latency_event(:,temp_fake_trigg) = [];
     
 end
 
 for yy = 1:length(find(diff(triggers_channels(oo,:)) < trigger_threshold_value)) - size_type_event
      
     type_event = [type_event trigger_names(oo)];
 
 end
 
      catch
          
      end
      
  end
  
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
try
data_exported.eeg_data = MEG.data; 
data_exported.channels = size(MEG.data,1);
data_exported.bad_channels = channels_to_be_removed_denoise;%output_info.excludedChannels;
data_exported.samples = size(MEG.data,2);
data_exported.sampling_frequency = s_rate;
data_exported.time = (0:size(MEG.data,2) - 1)/s_rate;
data_exported.trial_duration = (size(MEG.data,2) - 1)/s_rate;
data_exported.labels = labels_electrodes;%_electrodes;
data_exported.chanlocs = [];
data_exported.events_trigger = latency_event;
data_exported.events_type = type_event;

catch
    
end
        
 
 set(panel_info_tag,'Title',['File Opened: ' SQD_file_selected]);
 set(name_file_tag,'String',name_mat_file);
 set(channels_tag,'String',data_exported.channels);
 set (samples_tag,'String',data_exported.samples);
set(sampling_frequency_tag,'String',data_exported.sampling_frequency);
set(trial_duration_minutes_tag,'String',data_exported.trial_duration/60);
set(trial_duration_seconds_tag,'String',data_exported.trial_duration);
set(electrodes_recorded_tag,'String',data_exported.labels);
set(triggers_number_tag,'String',length(data_exported.events_trigger));

if (length(data_exported.events_trigger) > 0)

    set(triggers_type_tag,'String',data_exported.events_type);

else
    
    set(triggers_type_tag,'String','No triggers');
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Aligning the data for the cocktail party experiment
if (get(handles.Analysis_MEG_data,'Value') == 1) 
if ~isempty(str2double(get(handles.Tigger_Channels_MEG,'String')))
    
     message = 'Extracting the data.....';

        msgbox(message,'Extraction in progress.....','warn','replace');

        try
            
 triggers_channels = MEG.data(str2num(get(handles.Tigger_Channels_MEG,'String')),:);
 
        catch
           
            message = 'The number of channels selected does not include the trigger channels inserted. The operation has been aborted';

        msgbox(message,'Operation aborted','warn','replace');

            
            return;
            
        end
 
 triggers_channels = mapstd(triggers_channels); %This standardization allows for the trigger to be captured more accurately
 trig_data =[];
 trig_data = str2num(get(handles.Tigger_Channels_MEG,'String'));
 
 %% Matrix where to save the trigger onset
 %triggers_point = {};
 temp_ass  = zeros(1000,10000);  %Let's consider the situation where there are at most 1000 different triggers and 10000 different events per trigger 
 track_empty = [];
 triggers_code_save_data = [];
 for numb_trig = 1:length(str2num(get(handles.Tigger_Channels_MEG,'String'))) 
   
     temp_trigg = find(diff(triggers_channels(numb_trig,:)) < trigger_threshold_value);
 
     if (~isempty(temp_trigg))
         
     %temp_ass = [temp_ass;find(diff(triggers_channels(numb_trig,:)) < trigger_threshold_value)];
  temp_ass(numb_trig,1:length(temp_trigg)) = find(diff(triggers_channels(numb_trig,:)) < trigger_threshold_value);
  triggers_code_save_data = [triggers_code_save_data;trig_data(numb_trig)];
     else
        
         track_empty = [track_empty;numb_trig];
         %temp_ass = [temp_ass;zeros(1,size(triggers_channels,2))];
     end
     
     end
 
 for hh = numb_trig + 1:size(temp_ass,1)
 
     track_empty = [track_empty;hh];
     
 end
 
 temp_exist = exist('track_empty');
 if (temp_exist == 1)
     
 temp_ass(track_empty,:) = [];
 
 for kk = 1:size(temp_ass,1) 
     
 find_zero(kk) = length(find(temp_ass(kk,:) == 0));
 
 %checking if "fake" triggers have been detected based on 5 ms distance
 %between 2 consecutive triggers
     
 temp_fake_trigg = find(diff(temp_ass(kk,:)) < min_distance_triggers);
 
 if (~isempty(temp_fake_trigg))
         
    temp_ass(kk,temp_fake_trigg + 1) = 0;
     
 end
 
 end
 
 end
 
 if (isempty(temp_ass))
    
    message = 'No trigger has been detected. Consider changing the trigger code. The operation has been aborted. ';

        msgbox(message,'Operation aborted','warn','replace');
    
    
    return;
    
    else
    
    temp_ass(:,end-min(find_zero) + 1:end) = [];
 %temp_ass = temp_ass';
    
 end
 
 clear triggers_point;
 triggers_point = {};
for numb_trig = 1:size(temp_ass,1)%length(str2num(get(handles.Tigger_Channels_MEG,'String')))
    
    %Removing zeros
    temp_trig = temp_ass(numb_trig,:);
    find_zeros = find(temp_trig == 0);
    temp_trig(:,find_zeros) = [];
    
 triggers_point(numb_trig,1) = {temp_trig + 1};
 
 end
 
end

%Remove "zero" values, that corresponds to non-triggers

time_trigg = [0:size(triggers_channels,2)-1]/data_exported.sampling_frequency;
 
 figure
 for numb_trig = 1:length(triggers_point)
    
     subplot(length(triggers_point),1,numb_trig)
 %stem(triggers_point(:,numb_trig)'/data_exported.sampling_frequency)
 %stem(time_trigg(cell2mat(triggers_point(numb_trig,:)))/60,ones(length(time_trigg(cell2mat(triggers_point(numb_trig,:))))))
 stem(time_trigg(cell2mat(triggers_point(numb_trig,:))),ones(length(time_trigg(cell2mat(triggers_point(numb_trig,:))))))
 
 title(['Latencies (in seconds) of trigger: ' num2str(triggers_code_save_data(numb_trig))])
 
 end
 
 xlabel('\bfTime (minutes)')
 subplot(length(triggers_point),1,1)
 %title('\bfLatency triggers')
  
 seconds_before_trig = str2num(get(handles.Before_Trig_Cocktail_Party_MEG,'String'))*data_exported.sampling_frequency; %Seconds before trigger;
 legnth_stimulus = str2num(get(handles.Length_MEG_Cocktail,'String'))*data_exported.sampling_frequency;    %Each sweep will be 60seconds long
  
 try
     
     for kk = 1:size(triggers_point,1)
  %3D matrix to save the aligned data
  MEG_data_aligned = zeros(legnth_stimulus + seconds_before_trig*2,size(MEG.data,1),size(cell2mat(triggers_point(kk)),2));
 track_trials = 1;
 
  temp_trig_point_save = cell2mat(triggers_point(kk));
 
  for cc = 1:length(temp_trig_point_save)
    
  MEG_data_aligned(:,:,track_trials) = MEG.data(:,temp_trig_point_save(cc) - seconds_before_trig - delay_sound_val:temp_trig_point_save(cc) + legnth_stimulus - delay_sound_val - 1)';
  
  track_trials = track_trials + 1;
  
  end
  
   data_exported.eeg_data = [];
data_exported.eeg_data_aligned = MEG_data_aligned(:,:,:); 

save_meg = [name_mat_file '_' num2str(triggers_code_save_data(kk)) '.mat'];
save (save_meg,'data_exported','-v7.3') %-v7.3 is used to save data > 2Gbytes

     end
  
 catch
    
      message = 'No enough samples after the trigger. Consider changing the post-trigger time. ';

        msgbox(message,'Operation aborted','warn','replace');
     
     return;
     
 end
  
 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
if (get(handles.Analysis_MEG_data,'Value') == 2)
    
save_meg = [name_mat_file '.mat'];
save (save_meg,'data_exported','-v7.3') %-v7.3 is used to save data > 2Gbytes

end

message = 'Data have been aligned and saved';

        msgbox(message,'MEG data Saved','warn','replace');

        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PQ1160R MEG data uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PQ1160R_Data_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to PQ1160R_Data_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PQ1160R_Data_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of PQ1160R_Data_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function PQ1160R_Data_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PQ1160R_Data_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Channels to be extracted. If "ALL", all the channels will be extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Channels_Extracted_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Channels_Extracted_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Channels_Extracted_MEG as text
%        str2double(get(hObject,'String')) returns contents of Channels_Extracted_MEG as a double


% --- Executes during object creation, after setting all properties.
function Channels_Extracted_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Channels_Extracted_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time window to be extracted. If "ALL", the whole signal will be extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Time_Window_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Time_Window_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_Window_MEG as text
%        str2double(get(hObject,'String')) returns contents of Time_Window_MEG as a double


% --- Executes during object creation, after setting all properties.
function Time_Window_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_Window_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the selected channels will be extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Check_Channels_MEG.
function Check_Channels_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Check_Channels_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Check_Channels_MEG

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the whole signal will be extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Check_Window_MEG.
function Check_Window_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Check_Window_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Check_Window_MEG

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, bad channels will be identified
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Check_Bad_Channels_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Check_Bad_Channels_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkForDeadChannels;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, MEG data will go through a denoising algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Denoise_MEG.
function Denoise_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Denoise_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Denoise_MEG
if(get(handles.Denoise_MEG,'Value') == 1)
   
    set(handles.Channels_Removed_Denoise_MEG,'Enable','on');
    set(handles.Saturating_channels_zero_MEG,'Enable','on');
    set(handles.Channel_Saturating_MEG,'Enable','on');
    set(handles.Vibrat_Chan_MEG,'Enable','on');
    
else
    
    set(handles.Channels_Removed_Denoise_MEG,'Enable','off');
    set(handles.Saturating_channels_zero_MEG,'Enable','off');
    set(handles.Channel_Saturating_MEG,'Enable','off');
    set(handles.Vibrat_Chan_MEG,'Enable','off');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Triggers used to collect data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Tigger_Channels_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Tigger_Channels_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tigger_Channels_MEG as text
%        str2double(get(hObject,'String')) returns contents of Tigger_Channels_MEG as a double


% --- Executes during object creation, after setting all properties.
function Tigger_Channels_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tigger_Channels_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GUI for decoding MEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Decode_MEG_Data_GUI_Callback(hObject, eventdata, handles)
% hObject    handle to Decode_MEG_Data_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Decoding_MEG();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Type of analysis for the MEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Analysis_MEG_data.
function Analysis_MEG_data_Callback(hObject, eventdata, handles)
% hObject    handle to Analysis_MEG_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Analysis_MEG_data contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Analysis_MEG_data
if (get(handles.Analysis_MEG_data,'Value') == 1)
   
    set(handles.Before_Trig_Cocktail_Party_MEG,'Enable','on');
    set(handles.Length_MEG_Cocktail,'Enable','on');
    
else
    
    set(handles.Before_Trig_Cocktail_Party_MEG,'Enable','off');
    set(handles.Length_MEG_Cocktail,'Enable','off');
    
end

% --- Executes during object creation, after setting all properties.
function Analysis_MEG_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Analysis_MEG_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Length of the data for the cocktail party analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Length_MEG_Cocktail_Callback(hObject, eventdata, handles)
% hObject    handle to Length_MEG_Cocktail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Length_MEG_Cocktail as text
%        str2double(get(hObject,'String')) returns contents of Length_MEG_Cocktail as a double


% --- Executes during object creation, after setting all properties.
function Length_MEG_Cocktail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Length_MEG_Cocktail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Threshold for the trigger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Threshold_Trigger_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_Trigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold_Trigger as text
%        str2double(get(hObject,'String')) returns contents of Threshold_Trigger as a double


% --- Executes during object creation, after setting all properties.
function Threshold_Trigger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold_Trigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract DSS for ERP analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Extract_DSS_ERP_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_DSS_ERP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Extract_DSS_ERP_MEG();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Seconds before trigger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Before_Trig_Cocktail_Party_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Before_Trig_Cocktail_Party_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Before_Trig_Cocktail_Party_MEG as text
%        str2double(get(hObject,'String')) returns contents of Before_Trig_Cocktail_Party_MEG as a double


% --- Executes during object creation, after setting all properties.
function Before_Trig_Cocktail_Party_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Before_Trig_Cocktail_Party_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Channels to be removed from the denoise analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Channels_Removed_Denoise_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Channels_Removed_Denoise_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Channels_Removed_Denoise_MEG as text
%        str2double(get(hObject,'String')) returns contents of Channels_Removed_Denoise_MEG as a double


% --- Executes during object creation, after setting all properties.
function Channels_Removed_Denoise_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Channels_Removed_Denoise_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Deciding whether or not to set the saturating channels to zero
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Saturating_channels_zero_MEG.
function Saturating_channels_zero_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Saturating_channels_zero_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Saturating_channels_zero_MEG contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Saturating_channels_zero_MEG


% --- Executes during object creation, after setting all properties.
function Saturating_channels_zero_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Saturating_channels_zero_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Channel where to save the saturating channels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Channel_Saturating_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Channel_Saturating_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Channel_Saturating_MEG as text
%        str2double(get(hObject,'String')) returns contents of Channel_Saturating_MEG as a double


% --- Executes during object creation, after setting all properties.
function Channel_Saturating_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Channel_Saturating_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Deciding whether or not to use vibrational channels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Vibrat_Chan_MEG.
function Vibrat_Chan_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Vibrat_Chan_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Vibrat_Chan_MEG contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Vibrat_Chan_MEG


% --- Executes during object creation, after setting all properties.
function Vibrat_Chan_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vibrat_Chan_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Delay of the sound with respect to the trigger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Delay_Sound_MEG_Callback(hObject, eventdata, handles)
% hObject    handle to Delay_Sound_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Delay_Sound_MEG as text
%        str2double(get(hObject,'String')) returns contents of Delay_Sound_MEG as a double


% --- Executes during object creation, after setting all properties.
function Delay_Sound_MEG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Delay_Sound_MEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to import MEG data and to check
%the quality of the sensors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Import_MEG_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Import_MEG_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Import_PQ1160R_Data_GUI_Help()
