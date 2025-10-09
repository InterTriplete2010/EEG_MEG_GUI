function varargout = CWT_EEG_GUI_COGMO(varargin)
% CWT_EEG_GUI_COGMO M-file for CWT_EEG_GUI_COGMO.fig
%      CWT_EEG_GUI_COGMO, by itself, creates a new CWT_EEG_GUI_COGMO or raises the existing
%      singleton*.
%
%      H = CWT_EEG_GUI_COGMO returns the handle to a new CWT_EEG_GUI_COGMO or the handle to
%      the existing singleton*.
%
%      CWT_EEG_GUI_COGMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CWT_EEG_GUI_COGMO.M with the given input arguments.
%
%      CWT_EEG_GUI_COGMO('Property','Value',...) creates a new CWT_EEG_GUI_COGMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CWT_EEG_GUI_COGMO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CWT_EEG_GUI_COGMO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CWT_EEG_GUI_COGMO

% Last Modified by GUIDE v2.5 15-Feb-2022 09:21:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CWT_EEG_GUI_COGMO_OpeningFcn, ...
                   'gui_OutputFcn',  @CWT_EEG_GUI_COGMO_OutputFcn, ...
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


% --- Executes just before CWT_EEG_GUI_COGMO is made visible.
function CWT_EEG_GUI_COGMO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CWT_EEG_GUI_COGMO (see VARARGIN)

% Choose default command line output for CWT_EEG_GUI_COGMO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CWT_EEG_GUI_COGMO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CWT_EEG_GUI_COGMO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the file for the CWT analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_CWT_COGMO.
function Upload_CWT_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_CWT_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_cwt_file_selected;
global EEG_cwt_file_directory;

[EEG_cwt_file_selected,EEG_cwt_file_directory] = uigetfile('*.mat','Select the mat file');

cd(EEG_cwt_file_directory)
load_signal = load(EEG_cwt_file_selected);

set(handles.File_Uploaded_CWT_COGMO,'String',EEG_cwt_file_directory);
set(handles.Electrode_CWT_EEG_COGMO,'Value',1);

try
   
    set(handles.Electrode_CWT_EEG_COGMO,'String',load_signal.data_exported.labels)

catch
   
    set(handles.Electrode_CWT_EEG_COGMO,'String','Cz')
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Returns the file for the CWT analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Uploaded_CWT_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_CWT_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Uploaded_CWT_COGMO as text
%        str2double(get(hObject,'String')) returns contents of File_Uploaded_CWT_COGMO as a double


% --- Executes during object creation, after setting all properties.
function File_Uploaded_CWT_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_CWT_COGMO (see GCBO)
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
% --- Executes on selection change in Electrode_CWT_EEG_COGMO.
function Electrode_CWT_EEG_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Electrode_CWT_EEG_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Electrode_CWT_EEG_COGMO contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Electrode_CWT_EEG_COGMO


% --- Executes during object creation, after setting all properties.
function Electrode_CWT_EEG_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Electrode_CWT_EEG_COGMO (see GCBO)
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
function Low_Fre_CWT_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Low_Fre_CWT_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Low_Fre_CWT_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Low_Fre_CWT_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Low_Fre_CWT_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Low_Fre_CWT_COGMO (see GCBO)
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
function High_Freq_CWT_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to High_Freq_CWT_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of High_Freq_CWT_COGMO as text
%        str2double(get(hObject,'String')) returns contents of High_Freq_CWT_COGMO as a double


% --- Executes during object creation, after setting all properties.
function High_Freq_CWT_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to High_Freq_CWT_COGMO (see GCBO)
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
function StartT_CWT_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to StartT_CWT_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartT_CWT_COGMO as text
%        str2double(get(hObject,'String')) returns contents of StartT_CWT_COGMO as a double


% --- Executes during object creation, after setting all properties.
function StartT_CWT_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartT_CWT_COGMO (see GCBO)
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
function EndT_CWT_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to EndT_CWT_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndT_CWT_COGMO as text
%        str2double(get(hObject,'String')) returns contents of EndT_CWT_COGMO as a double


% --- Executes during object creation, after setting all properties.
function EndT_CWT_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndT_CWT_COGMO (see GCBO)
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
% --- Executes on button press in Compute_CWT_EEG.
function Compute_CWT_EEG_Callback(hObject, eventdata, handles)
% hObject    handle to Compute_CWT_EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EEG_cwt_file_selected;
global EEG_cwt_file_directory;

electrode_selected_cwt = get(handles.Electrode_CWT_EEG_COGMO,'Value');
electrode_names = get(handles.Electrode_CWT_EEG_COGMO,'String');
electrode_name_selected = electrode_names(electrode_selected_cwt,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculating the PLF for all the files included in the selected directory
current_dir = dir;
make_dir_data = 0;
current_path_info = what;
current_path_name = current_path_info.path;

check_all_electrodes = get(handles.All_Electrodes_Wavelets,'Value');

for tt = 3:size(current_dir,1)
    
    startT = [];
    endT = [];
    
    cwtfileloaded = [];
    
    if (strcmp(current_dir(tt).name(end-3:end), '.mat') == 1)
        
        make_dir_data = make_dir_data + 1;
        
        display(['Current file: ' current_dir(tt).name]);
        cwtfileloaded = load(current_dir(tt).name);
        
        sampling_frequency = cwtfileloaded.data_exported.sampling_frequency;
        
        try
            
            time_domain_temp = cwtfileloaded.data_exported.time_average;
            
        catch
            
            time_domain_temp = cwtfileloaded.data_exported.time;
            
        end
        
        %Extract the time range for the analysis
        if(get(handles.Whole_Time_Range,'Value') == 1)
            
            if(isempty(startT))
                
            startT = 1;
             set(handles.StartT_CWT_COGMO,'String',time_domain_temp(1))
             
            end
            
            if(isempty(endT))
                
            endT = length(time_domain_temp);
            set(handles.EndT_CWT_COGMO,'String',time_domain_temp(end))
           
            
            end
             
        else
            
        if(isempty(startT))
            
            startT = find(str2double(get(handles.StartT_CWT_COGMO,'String')) <= time_domain_temp,1,'First');
        
        end
        
        if isempty(startT)
            
            startT = 1;
            set(handles.StartT_CWT_COGMO,'String',startT./sampling_frequency)
            
        end
        
        if(isempty(endT))
            
            endT = find(str2double(get(handles.EndT_CWT_COGMO,'String')) <= time_domain_temp,1,'First');
        
        end
        
        if isempty(endT)
            
            endT = length(time_domain_temp);
            set(handles.EndT_CWT_COGMO,'String',endT./sampling_frequency)
            
        end
        
        end
        
        time_domain_temp = time_domain_temp(:,startT:endT);
        
        %% Checking which type of data needs to be analyzed
        try
            switch get(handles.Signal_Type_CWT,'Value')
                
                case 1
                    
                    if check_all_electrodes == 1
                        
                        cwtfiledata = cwtfileloaded.data_exported.eeg_data(:,startT:endT);
                        
                    else
                        
                        cwtfiledata = cwtfileloaded.data_exported.eeg_data(electrode_selected_cwt,startT:endT);
                        
                    end
                    
                case 2
                    
                    if check_all_electrodes == 1
                        
                        cwtfiledata = cwtfileloaded.data_exported.average_trials(:,startT:endT);
                        
                    else
                        
                        cwtfiledata = cwtfileloaded.data_exported.average_trials(electrode_selected_cwt,startT:endT);
                        
                    end
                    
                case 3
                    
                    
                    cwtfiledata = cwtfileloaded.data_exported.average_add(:,startT:endT);
                    
                case 4
                    
                    cwtfiledata = cwtfileloaded.data_exported.average_sub(:,startT:endT);
                    
            end
            
%             set(handles.StartT_CWT_COGMO,'String',startT./sampling_frequency)
%             set(handles.EndT_CWT_COGMO,'String',endT./sampling_frequency)
            
        catch
            
            message = 'Invalid choice. Please, make sure your set of data support your choice. Check also the duration of the signal';
            
            msgbox(message,'Error','warn');
            
            return;
            
        end
        
        
        low_freq = str2double(get(handles.Low_Fre_CWT_COGMO,'String'));
        high_freq = str2double(get(handles.High_Freq_CWT_COGMO,'String'));
        
        
       %         try
%             
%             %"cwtfileloaded.data_exported.events_trigger - 1" means that it
%             %reads the first trigger and subtracts one sample to compensate for the
%             %fact that the first sample plotted is "zero" seconds;
%             events_trigger = ((cwtfileloaded.data_exported.events_trigger - 1)/sampling_frequency);
%             
%             find_trig = find(events_trigger >= (startT./sampling_frequency) & events_trigger <= (endT./sampling_frequency));
%             
%             events_trigger = events_trigger(find_trig);
%             
%         catch
%             
%             events_trigger = [];
%             
%         end
        
 events_trigger = [];
        
        step_wavelets = str2double(get(handles.Step_Wavelets,'String'));
        
        plot_save_fig = get(handles.Plot_Save_Wavelet,'Value');
        dec_f = str2double(get(handles.Dec_Fact_Wav_E_A,'String'));
        
        if ~isempty(cwtfiledata)
            
            CWT_EEG_Function_COGMO(current_dir(tt).name,sampling_frequency,startT,endT,cwtfiledata,...
                low_freq,high_freq,events_trigger,electrode_name_selected,step_wavelets,electrode_names,plot_save_fig,make_dir_data,...
                current_path_name,dec_f,time_domain_temp)
            
        end
    end
    
end

message = 'Calculations completed';
msgbox(message,'End of the calculations','warn','replace');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Selection between fine structure and envelope
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Signal_Type_CWT.
function Signal_Type_CWT_Callback(hObject, eventdata, handles)
% hObject    handle to Signal_Type_CWT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Signal_Type_CWT contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Signal_Type_CWT


% --- Executes during object creation, after setting all properties.
function Signal_Type_CWT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Signal_Type_CWT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step wavelets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Step_Wavelets_Callback(hObject, eventdata, handles)
% hObject    handle to Step_Wavelets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step_Wavelets as text
%        str2double(get(hObject,'String')) returns contents of Step_Wavelets as a double


% --- Executes during object creation, after setting all properties.
function Step_Wavelets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step_Wavelets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, all the electrodes will be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in All_Electrodes_Wavelets.
function All_Electrodes_Wavelets_Callback(hObject, eventdata, handles)
% hObject    handle to All_Electrodes_Wavelets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of All_Electrodes_Wavelets
if(get(handles.All_Electrodes_Wavelets,'Value') == 1)
   
    set(handles.Electrode_CWT_EEG_COGMO,'Enable','Off');
    
else
    
    set(handles.Electrode_CWT_EEG_COGMO,'Enable','On');
       
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Option to plot and save figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Plot_Save_Wavelet.
function Plot_Save_Wavelet_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Save_Wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Plot_Save_Wavelet contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Plot_Save_Wavelet


% --- Executes during object creation, after setting all properties.
function Plot_Save_Wavelet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Plot_Save_Wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decimation factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dec_Fact_Wav_E_A_Callback(hObject, eventdata, handles)
% hObject    handle to Dec_Fact_Wav_E_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dec_Fact_Wav_E_A as text
%        str2double(get(hObject,'String')) returns contents of Dec_Fact_Wav_E_A as a double


% --- Executes during object creation, after setting all properties.
function Dec_Fact_Wav_E_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dec_Fact_Wav_E_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the whole signal will be analyzed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Whole_Time_Range.
function Whole_Time_Range_Callback(hObject, eventdata, handles)
% hObject    handle to Whole_Time_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Whole_Time_Range
if(get(handles.Whole_Time_Range,'Value') == 1)
   
    set(handles.StartT_CWT_COGMO,'Enable','Off');
    set(handles.EndT_CWT_COGMO,'Enable','Off');
    
else
    
    set(handles.StartT_CWT_COGMO,'Enable','On');
    set(handles.EndT_CWT_COGMO,'Enable','On');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to run continuous wavelet analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_CWT_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_CWT_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CWT_EEG_Help();
