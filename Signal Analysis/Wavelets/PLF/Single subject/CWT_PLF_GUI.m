function varargout = CWT_PLF_GUI(varargin)
% CWT_PLF_GUI M-file for CWT_PLF_GUI.fig
%      CWT_PLF_GUI, by itself, creates a new CWT_PLF_GUI or raises the existing
%      singleton*.
%
%      H = CWT_PLF_GUI returns the handle to a new CWT_PLF_GUI or the handle to
%      the existing singleton*.
%
%      CWT_PLF_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CWT_PLF_GUI.M with the given input arguments.
%
%      CWT_PLF_GUI('Property','Value',...) creates a new CWT_PLF_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CWT_PLF_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CWT_PLF_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CWT_PLF_GUI

% Last Modified by GUIDE v2.5 15-Feb-2022 11:09:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CWT_PLF_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CWT_PLF_GUI_OutputFcn, ...
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


% --- Executes just before CWT_PLF_GUI is made visible.
function CWT_PLF_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CWT_PLF_GUI (see VARARGIN)

% Choose default command line output for CWT_PLF_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CWT_PLF_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CWT_PLF_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the file for the CWT analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_CWT_PLF.
function Upload_CWT_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_cwt_file_selected;
global EEG_cwt_file_directory;
global load_signal;

[EEG_cwt_file_selected,EEG_cwt_file_directory] = uigetfile('*.mat','Select the mat file');

if(EEG_cwt_file_directory == 0)
   
    set(handles.File_Uploaded_CWT_PLF,'String','No File Selected');
    
    return;
    
end

cd(EEG_cwt_file_directory)
load_signal = load(EEG_cwt_file_selected);

set(handles.File_Uploaded_CWT_PLF,'String',EEG_cwt_file_directory);
set(handles.Electrode_CWT_PLF,'Value',1);


try 
    
set(handles.Electrode_CWT_PLF,'String',load_signal.data_exported.labels) 
    
catch
    
    set(handles.Electrode_CWT_PLF,'String','Cz') 
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Returns the file for the CWT analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Uploaded_CWT_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Uploaded_CWT_PLF as text
%        str2double(get(hObject,'String')) returns contents of File_Uploaded_CWT_PLF as a double


% --- Executes during object creation, after setting all properties.
function File_Uploaded_CWT_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose which electrode to analyze
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Electrode_CWT_PLF.
function Electrode_CWT_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Electrode_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Electrode_CWT_PLF contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Electrode_CWT_PLF


% --- Executes during object creation, after setting all properties.
function Electrode_CWT_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Electrode_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Low frequency for the CWT analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Low_Fre_CWT_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Low_Fre_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Low_Fre_CWT_PLF as text
%        str2double(get(hObject,'String')) returns contents of Low_Fre_CWT_PLF as a double


% --- Executes during object creation, after setting all properties.
function Low_Fre_CWT_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Low_Fre_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%High frequency for the CWT analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function High_Freq_CWT_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to High_Freq_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of High_Freq_CWT_PLF as text
%        str2double(get(hObject,'String')) returns contents of High_Freq_CWT_PLF as a double


% --- Executes during object creation, after setting all properties.
function High_Freq_CWT_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to High_Freq_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start time(seconds) for the CWT analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function StartT_CWT_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to StartT_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartT_CWT_PLF as text
%        str2double(get(hObject,'String')) returns contents of StartT_CWT_PLF as a double


% --- Executes during object creation, after setting all properties.
function StartT_CWT_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartT_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End time(seconds) for the CWT analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function EndT_CWT_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to EndT_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndT_CWT_PLF as text
%        str2double(get(hObject,'String')) returns contents of EndT_CWT_PLF as a double


% --- Executes during object creation, after setting all properties.
function EndT_CWT_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndT_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compute the CWT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Compute_CWT_PLF.
function Compute_CWT_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Compute_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_cwt_file_selected;
global EEG_cwt_file_directory;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Setting the parameters for the analysis
electrode_selected_plf = get(handles.Electrode_CWT_PLF,'Value');
electrode_names = get(handles.Electrode_CWT_PLF,'String');
electrode_name_selected = electrode_names(electrode_selected_plf,:);


cwtfile = [EEG_cwt_file_directory '\' EEG_cwt_file_selected];
cwtfileloaded = load(cwtfile);

sampling_frequency = cwtfileloaded.data_exported.sampling_frequency;

check_all_electrodes_PLF = get(handles.ALL_E_PLF,'Value');

% startT = abs(round(str2double(get(handles.StartT_CWT_PLF,'String'))*sampling_frequency));
% 
% if (startT == 0)
%     
%     startT = 1;
%     
% end
% 
% endT = round(str2double(get(handles.EndT_CWT_PLF,'String'))*sampling_frequency);

low_freq = str2double(get(handles.Low_Fre_CWT_PLF,'String'));
high_freq = str2double(get(handles.High_Freq_CWT_PLF,'String'));

dec_fact = str2double(get(handles.Dec_Factor_PLF,'String'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculating the PLF for all the files included in the selected directory
current_dir = dir;

for tt = 3:size(current_dir,1)

    if (strcmp(current_dir(tt).name(end-3:end), '.mat') == 1)
    
    cwtfileloaded = load(current_dir(tt).name);
    
    EEG_cwt_file_selected = current_dir(tt).name
    
condition_chosen_names = get(handles.Pitch_TFS_PLF,'String');
condition_chosen_folder = cell2mat(condition_chosen_names(get(handles.Pitch_TFS_PLF,'Value')));

%% Choosing which analysis to perform
try
if(get(handles.Pitch_TFS_PLF,'Value') == 1)

    cwtfiledata_rar = cwtfileloaded.data_exported.rar_sweeps;
cwtfiledata_compr = cwtfileloaded.data_exported.compr_sweeps;
    cwtfiledata = [cwtfiledata_rar;cwtfiledata_compr];

elseif (get(handles.Pitch_TFS_PLF,'Value') == 2)
    
    cwtfiledata_rar = cwtfileloaded.data_exported.rar_sweeps;
cwtfiledata_compr = cwtfileloaded.data_exported.compr_sweeps;
    cwtfiledata = [cwtfiledata_rar;-cwtfiledata_compr];
    
elseif (get(handles.Pitch_TFS_PLF,'Value') == 3)
    
  if check_all_electrodes_PLF == 1
      
    cwtfiledata = cwtfileloaded.data_exported.single_trials(:,:,:);
 
  else
      
       cwtfiledata = squeeze(cwtfileloaded.data_exported.single_trials(electrode_selected_plf,:,:));
       
  end
    
    elseif (get(handles.Pitch_TFS_PLF,'Value') == 4)

    if check_all_electrodes_PLF == 1
     
        
        cwtfiledata = zeros(size(cwtfileloaded.data_exported.dss,2),size(cwtfileloaded.data_exported.dss,3),size(cwtfileloaded.data_exported.dss,1));
   
        for ll = 1:size(cwtfiledata,1)
        
            cwtfiledata(ll,:,:) = squeeze(cwtfileloaded.data_exported.dss(:,ll,:))';
        end
        
    else
        
         cwtfiledata = squeeze(cwtfileloaded.data_exported.dss(:,electrode_selected_plf,:))';
  
        
    end
end

catch
   
    message = 'Invalid selection of the "data type". Please, change your selection';
msgbox(message,'Invalid selection','warn','replace');
    
    return;
    
end

%% Reading the time domain used for the average

try
    
time_domain_temp = cwtfileloaded.data_exported.time_average;

catch
    %{
    curr_dir = what;
    curr_dir_path = curr_dir.path;
cd('Z:\Projects\Processed\EEG-MEG\Different SNR and Meaningful - Meaningless Noise\EEG\Official')
time_domain_temp_load = load('time_domain');
time_domain_temp = time_domain_temp_load.time_d;
   
    cd(curr_dir_path)
%} 
time_domain_temp = cwtfileloaded.data_exported.time;

end

set(handles.EndT_CWT_PLF,'String',time_domain_temp(end))
set(handles.StartT_CWT_PLF,'String',time_domain_temp(1));

step_wav_plf = str2double(get(handles.Step_Wav_PLF,'String'));

plot_save_figures_plf = get(handles.Plot_Save_Fig_PLF,'Value');

%% Running the analysis based on the choice between cortex and midbrain
% if (get(handles.Pitch_TFS_PLF,'Value') == 3) || (get(handles.Pitch_TFS_PLF,'Value') == 4)
startT = abs(round(str2double(get(handles.StartT_CWT_PLF,'String'))*sampling_frequency));
endT = round(str2double(get(handles.EndT_CWT_PLF,'String'))*sampling_frequency);


    CWT_PLF_Function(EEG_cwt_file_selected,sampling_frequency,startT,endT,cwtfiledata,...
    low_freq,high_freq,cwtfileloaded.data_exported.labels,dec_fact,condition_chosen_folder,time_domain_temp,step_wav_plf,...
    plot_save_figures_plf,electrode_selected_plf)
    
% else
%     
%     CWT_PLF_Function(EEG_cwt_file_selected,sampling_frequency,startT,endT,cwtfiledata,...
%     low_freq,high_freq,electrode_name_selected,dec_fact,condition_chosen_folder,time_domain_temp,step_wav_plf,...
%     plot_save_figures_plf)
% 
% end

 end
end
    
message = 'Calculations completed. The PLF for the selected files has been calculated, plotted and saved';
msgbox(message,'End of the calculations','warn','replace');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Onset of the stimulus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Stim_Onset_CWT_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Stim_Onset_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Stim_Onset_CWT_PLF as text
%        str2double(get(hObject,'String')) returns contents of Stim_Onset_CWT_PLF as a double


% --- Executes during object creation, after setting all properties.
function Stim_Onset_CWT_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stim_Onset_CWT_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decimation factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dec_Factor_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Dec_Factor_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dec_Factor_PLF as text
%        str2double(get(hObject,'String')) returns contents of Dec_Factor_PLF as a double


% --- Executes during object creation, after setting all properties.
function Dec_Factor_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dec_Factor_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pitch or TFS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Pitch_TFS_PLF.
function Pitch_TFS_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Pitch_TFS_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Pitch_TFS_PLF contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pitch_TFS_PLF

global load_signal;

if (~isempty(load_signal))

if (get(handles.Pitch_TFS_PLF,'Value') == 3) || (get(handles.Pitch_TFS_PLF,'Value') == 4)
    
    set(handles.Electrode_CWT_PLF,'String',load_signal.data_exported.labels); 
    set(handles.ALL_E_PLF,'Enable','on');
    
else
    
    set(handles.Electrode_CWT_PLF,'String','Cz');  
    set(handles.ALL_E_PLF,'Enable','off');

end

else
    
    set(handles.Electrode_CWT_PLF,'String','NA');

end


% --- Executes during object creation, after setting all properties.
function Pitch_TFS_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pitch_TFS_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Frequency step of the wavelets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Step_Wav_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Step_Wav_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step_Wav_PLF as text
%        str2double(get(hObject,'String')) returns contents of Step_Wav_PLF as a double


% --- Executes during object creation, after setting all properties.
function Step_Wav_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step_Wav_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose if to plot and save the figures of the PLF 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Plot_Save_Fig_PLF.
function Plot_Save_Fig_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Save_Fig_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Plot_Save_Fig_PLF contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Plot_Save_Fig_PLF


% --- Executes during object creation, after setting all properties.
function Plot_Save_Fig_PLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Plot_Save_Fig_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Idf checked, all the electrodes will be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in ALL_E_PLF.
function ALL_E_PLF_Callback(hObject, eventdata, handles)
% hObject    handle to ALL_E_PLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ALL_E_PLF
if(get(handles.ALL_E_PLF,'Value'))
   
    set(handles.Electrode_CWT_PLF,'Enable','Off');
    
else
    
    set(handles.Electrode_CWT_PLF,'Enable','On');
    
end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to calculate the PLF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_PLF_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_PLF_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CWT_PLF_GUI_Help();
