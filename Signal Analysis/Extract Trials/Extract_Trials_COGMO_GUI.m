function varargout = Extract_Trials_COGMO_GUI(varargin)
% EXTRACT_TRIALS_COGMO_GUI MATLAB code for Extract_Trials_COGMO_GUI.fig
%      EXTRACT_TRIALS_COGMO_GUI, by itself, creates a new EXTRACT_TRIALS_COGMO_GUI or raises the existing
%      singleton*.
%
%      H = EXTRACT_TRIALS_COGMO_GUI returns the handle to a new EXTRACT_TRIALS_COGMO_GUI or the handle to
%      the existing singleton*.
%
%      EXTRACT_TRIALS_COGMO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACT_TRIALS_COGMO_GUI.M with the given input arguments.
%
%      EXTRACT_TRIALS_COGMO_GUI('Property','Value',...) creates a new EXTRACT_TRIALS_COGMO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Extract_Trials_COGMO_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Extract_Trials_COGMO_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Extract_Trials_COGMO_GUI

% Last Modified by GUIDE v2.5 18-Jan-2022 14:07:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Extract_Trials_COGMO_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Extract_Trials_COGMO_GUI_OutputFcn, ...
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


% --- Executes just before Extract_Trials_COGMO_GUI is made visible.
function Extract_Trials_COGMO_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Extract_Trials_COGMO_GUI (see VARARGIN)

% Choose default command line output for Extract_Trials_COGMO_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Extract_Trials_COGMO_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Extract_Trials_COGMO_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract the trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extract_Trials_Button_COGMO.
function Extract_Trials_Button_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Trials_Button_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

Seconds_Before_trigger = str2double(get(handles.Seconds_Before_COGMO,'String'));
Seconds_After_trigger = str2double(get(handles.Seconds_After_COGMO,'String'));
channels_recorded = get(handles.Channel_to_Extract_COGMO,'String');
channel_selected = get(handles.Channel_to_Extract_COGMO,'Value');

trigger_position = get(handles.Trigger_Code_COGMO,'Value');
trigger_names = get(handles.Trigger_Code_COGMO,'String');

try

    trigger_selected = str2num(trigger_names(trigger_position,:)); 
    
catch

trigger_selected = trigger_names(trigger_position);   

end


%% Artifact single electrode
artifact_neg_electrode = str2double(get(handles.Art_Neg_Single_Electrode,'String'));
artifact_pos_electrode = str2double(get(handles.Art_Pos_Single_Electrode,'String'));

standardized_data = get(handles.STD_Data_COGMO,'Value');

 name_file_saved = get(handles.Name_File_ERP,'String');
 
 if (strcmp(name_file_saved,'N/A'))
    
     message = 'Please, enter a valid name for your file in the "Name File" box';
msgbox(message,'Operation aborted','warn','replace');
     
     return;
     
 end
 
 adj_trigger_value = str2double(get(handles.Adj_Time_Cortical,'String'));
 
 max_N_sweeps = str2double(get(handles.Max_Number_Sweeps_Cortical,'String'));
 
 eeg_meg_scalp_map = get(handles.EEG_MEG_Choice_Scalp_Map,'Value');
 
 %Extracting the values for the peak analysis
 P1_start_window = str2double(get(handles.P1_Start,'String'));
 P1_end_window = str2double(get(handles.P1_End,'String'));
 
 N1_start_window = str2double(get(handles.N1_Start,'String'));
 N1_end_window = str2double(get(handles.N1_End,'String'));
    
 P2_start_window = str2double(get(handles.P2_Start,'String'));
 P2_end_window = str2double(get(handles.P2_End,'String'));
 
 %Extracting the values for the peak analysis
 Start_RMS = str2double(get(handles.Start_RMS,'String'));
 End_RMS = str2double(get(handles.End_RMS,'String'));
 
 plot_save_av_chan = get(handles.Plot_Save_Av,'Value');
 plot_save_scalp_map_data = get(handles.Plot_Save_Scalp_Map,'Value');
 
 abs_val_peaks = get(handles.Abs_Val_Peaks,'Value');
 
 if get(handles.Alternated_Polarity_Extract_Trials,'Value') == 1
  
     try

     trigger_selected_next = str2num(trigger_names(trigger_position + 1,:)); 
     
     catch

        message = 'Analysis aborted';
msgbox(message,'No second trigger has been identified for the alternated analysis','warn','replace'); 

return;

     end

 Extract_Trials_function_all_electrodes_alternated_polarity(Files_Mat_file_selected,Files_Mat_file_directory,Seconds_Before_trigger,...
         Seconds_After_trigger,channels_recorded,channel_selected,trigger_selected,trigger_selected_next, standardized_data,name_file_saved,...
         artifact_neg_electrode,artifact_pos_electrode,adj_trigger_value,max_N_sweeps,eeg_meg_scalp_map,...
        P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS,plot_save_av_chan,plot_save_scalp_map_data,abs_val_peaks);
     
 else
   
  
     Extract_Trials_function_all_electrodes_Fast(Files_Mat_file_selected,Files_Mat_file_directory,Seconds_Before_trigger,...
         Seconds_After_trigger,channels_recorded,channel_selected,trigger_selected,standardized_data,name_file_saved,...
         artifact_neg_electrode,artifact_pos_electrode,adj_trigger_value,max_N_sweeps,eeg_meg_scalp_map,...
         P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS,plot_save_av_chan,plot_save_scalp_map_data,abs_val_peaks);
       
 end
 
 message = 'End of the analysis';
msgbox(message,'Operation successfully completed','warn','replace');

 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the EEG file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_EEG_Trials_COGMO.
function Upload_EEG_Trials_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_EEG_Trials_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Files_Mat_file_selected;
global Files_Mat_file_directory;

[Files_Mat_file_selected,Files_Mat_file_directory] = uigetfile('*.mat','Select the mat file');

if(Files_Mat_file_directory == 0)
   
    set(handles.EEG_Uploaded_Trials_COGMO,'String',"No valid file has been selected");
    
     message = 'No file has been selected';
msgbox(message,'Failed to upload a valid file','warn','replace');

    return;
    
end
    
cd(Files_Mat_file_directory)

data_eeg = load(Files_Mat_file_selected);
number_of_triggers = length(data_eeg.data_exported.events_type);


set(handles.EEG_Uploaded_Trials_COGMO,'String',Files_Mat_file_selected);
set(handles.Channel_to_Extract_COGMO,'String',data_eeg.data_exported.labels)

track_trigger_number = 1;

save_position = [];


%% Eliminating recurrent trigger labels
for kkk = 1:length(data_eeg.data_exported.events_type)
   
    temp_trigger = data_eeg.data_exported.events_type(kkk);
    track_trigger_name = 0;
  
    try

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%% Triggers are in double format   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
       
   for ttt = 1:length(data_eeg.data_exported.events_type)
      
        if (track_trigger_name == 0)
    
       if (data_eeg.data_exported.events_type(ttt) == temp_trigger)
            
            
            track_trigger_name = track_trigger_name + 1;
            track_trigger_name_position(1,track_trigger_name) = ttt;
        
           
             save_position(track_trigger_number) = ttt;
        
        track_trigger_number = track_trigger_number + 1;
        
                   track_trigger_name = 1;
                   
        remove_one_cell_track = save_position(end);
        
                   for kk = 1:length(save_position) - 1
                       
                       if (find(save_position(kk) == remove_one_cell_track))
                           
                           save_position(end) = [];
                           
                           track_trigger_number = track_trigger_number - 1;
                           
                           
                       end
                       
                   end
                   
               end
        
    end
                
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%% Triggers are in string format    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    catch
     
              for ttt = 1:length(data_eeg.data_exported.events_type)
      
        if (track_trigger_name == 0)
    
           
            if (strcmp (data_eeg.data_exported.events_type(ttt),temp_trigger))
            
            track_trigger_name = track_trigger_name + 1;
            track_trigger_name_position(1,track_trigger_name) = ttt;
        
           
             save_position(track_trigger_number) = ttt;
        
        track_trigger_number = track_trigger_number + 1;
        
                   track_trigger_name = 1;
                   
        remove_one_cell_track = save_position(end);
        
                   for kk = 1:length(save_position) - 1
                       
                       if (find(save_position(kk) == remove_one_cell_track))
                           
                           save_position(end) = [];
                           
                           track_trigger_number = track_trigger_number - 1;
                           
                           
                       end
                       
                   end
                   
               end
        
    end
                
    end
    
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

end

set(handles.Trigger_Code_COGMO,'Value',1);

      if ~isempty(save_position) 
          
temp_event_type = data_eeg.data_exported.events_type(save_position);

set(handles.Trigger_Code_COGMO,'String',temp_event_type)
set(handles.Trigger_Number_COGMO,'String',length(temp_event_type))

      else
         
          set(handles.Trigger_Code_COGMO,'String','None')
set(handles.Trigger_Number_COGMO,'String',0)
          
      end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EEG file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function EEG_Uploaded_Trials_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to EEG_Uploaded_Trials_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EEG_Uploaded_Trials_COGMO as text
%        str2double(get(hObject,'String')) returns contents of EEG_Uploaded_Trials_COGMO as a double


% --- Executes during object creation, after setting all properties.
function EEG_Uploaded_Trials_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EEG_Uploaded_Trials_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Number of usable triggers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Trigger_Number_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Trigger_Number_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Trigger_Number_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Trigger_Number_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Trigger_Number_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trigger_Number_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Channel to extract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Channel_to_Extract_COGMO.
function Channel_to_Extract_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Channel_to_Extract_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Channel_to_Extract_COGMO contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Channel_to_Extract_COGMO


% --- Executes during object creation, after setting all properties.
function Channel_to_Extract_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Channel_to_Extract_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Seconds before trigger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Seconds_Before_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Seconds_Before_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Seconds_Before_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Seconds_Before_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Seconds_Before_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Seconds_Before_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Seconds after trigger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Seconds_After_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Seconds_After_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Seconds_After_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Seconds_After_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Seconds_After_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Seconds_After_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Trigger code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Trigger_Code_COGMO.
function Trigger_Code_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Trigger_Code_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Trigger_Code_COGMO contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Trigger_Code_COGMO


% --- Executes during object creation, after setting all properties.
function Trigger_Code_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trigger_Code_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the grand average will be standardized with respect 
%to mean and standard deviation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in STD_Data_COGMO.
function STD_Data_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to STD_Data_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of STD_Data_COGMO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the file to be saved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Name_File_ERP_Callback(hObject, eventdata, handles)
% hObject    handle to Name_File_ERP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Name_File_ERP as text
%        str2double(get(hObject,'String')) returns contents of Name_File_ERP as a double


% --- Executes during object creation, after setting all properties.
function Name_File_ERP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Name_File_ERP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upper bound artifact rejection single electrode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Art_Pos_Single_Electrode_Callback(hObject, eventdata, handles)
% hObject    handle to Art_Pos_Single_Electrode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Art_Pos_Single_Electrode as text
%        str2double(get(hObject,'String')) returns contents of Art_Pos_Single_Electrode as a double


% --- Executes during object creation, after setting all properties.
function Art_Pos_Single_Electrode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Art_Pos_Single_Electrode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Lower bound artifact rejection single electrode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Art_Neg_Single_Electrode_Callback(hObject, eventdata, handles)
% hObject    handle to Art_Neg_Single_Electrode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Art_Neg_Single_Electrode as text
%        str2double(get(hObject,'String')) returns contents of Art_Neg_Single_Electrode as a double


% --- Executes during object creation, after setting all properties.
function Art_Neg_Single_Electrode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Art_Neg_Single_Electrode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Adjustment time for the Biosemi trigger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Adj_Time_Cortical_Callback(hObject, eventdata, handles)
% hObject    handle to Adj_Time_Cortical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Adj_Time_Cortical as text
%        str2double(get(hObject,'String')) returns contents of Adj_Time_Cortical as a double


% --- Executes during object creation, after setting all properties.
function Adj_Time_Cortical_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Adj_Time_Cortical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Max number sweeps to average
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Max_Number_Sweeps_Cortical_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Number_Sweeps_Cortical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Number_Sweeps_Cortical as text
%        str2double(get(hObject,'String')) returns contents of Max_Number_Sweeps_Cortical as a double


% --- Executes during object creation, after setting all properties.
function Max_Number_Sweeps_Cortical_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Number_Sweeps_Cortical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose if the scalp map function for EEG or MEG should be used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in EEG_MEG_Choice_Scalp_Map.
function EEG_MEG_Choice_Scalp_Map_Callback(hObject, eventdata, handles)
% hObject    handle to EEG_MEG_Choice_Scalp_Map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns EEG_MEG_Choice_Scalp_Map contents as cell array
%        contents{get(hObject,'Value')} returns selected item from EEG_MEG_Choice_Scalp_Map


% --- Executes during object creation, after setting all properties.
function EEG_MEG_Choice_Scalp_Map_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EEG_MEG_Choice_Scalp_Map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If selected the average will be computed on two consecutive 
%triggers (e.g. FFR analysis)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Alternated_Polarity_Extract_Trials.
function Alternated_Polarity_Extract_Trials_Callback(hObject, eventdata, handles)
% hObject    handle to Alternated_Polarity_Extract_Trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Alternated_Polarity_Extract_Trials

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start window for P2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function P2_Start_Callback(hObject, eventdata, handles)
% hObject    handle to P2_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P2_Start as text
%        str2double(get(hObject,'String')) returns contents of P2_Start as a double


% --- Executes during object creation, after setting all properties.
function P2_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End window for P2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function P2_End_Callback(hObject, eventdata, handles)
% hObject    handle to P2_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P2_End as text
%        str2double(get(hObject,'String')) returns contents of P2_End as a double


% --- Executes during object creation, after setting all properties.
function P2_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start window for P1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function P1_Start_Callback(hObject, eventdata, handles)
% hObject    handle to P1_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P1_Start as text
%        str2double(get(hObject,'String')) returns contents of P1_Start as a double


% --- Executes during object creation, after setting all properties.
function P1_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End window for P2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function P1_End_Callback(hObject, eventdata, handles)
% hObject    handle to P1_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P1_End as text
%        str2double(get(hObject,'String')) returns contents of P1_End as a double


% --- Executes during object creation, after setting all properties.
function P1_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start window for N1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function N1_Start_Callback(hObject, eventdata, handles)
% hObject    handle to N1_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N1_Start as text
%        str2double(get(hObject,'String')) returns contents of N1_Start as a double


% --- Executes during object creation, after setting all properties.
function N1_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N1_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start window for N2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function N1_End_Callback(hObject, eventdata, handles)
% hObject    handle to N1_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N1_End as text
%        str2double(get(hObject,'String')) returns contents of N1_End as a double


% --- Executes during object creation, after setting all properties.
function N1_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N1_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start window for the RMS analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to Start_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_RMS as text
%        str2double(get(hObject,'String')) returns contents of Start_RMS as a double


% --- Executes during object creation, after setting all properties.
function Start_RMS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End window for the RMS analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_RMS_Callback(hObject, eventdata, handles)
% hObject    handle to End_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_RMS as text
%        str2double(get(hObject,'String')) returns contents of End_RMS as a double


% --- Executes during object creation, after setting all properties.
function End_RMS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_RMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the average of each single channel will be plotted 
%and saved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Plot_Save_Av.
function Plot_Save_Av_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Save_Av (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Plot_Save_Av

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the scalp map will be plotted 
%and saved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Plot_Save_Scalp_Map.
function Plot_Save_Scalp_Map_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Save_Scalp_Map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Plot_Save_Scalp_Map

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the value of the absolute value of the peaks will
%be used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Abs_Val_Peaks.
function Abs_Val_Peaks_Callback(hObject, eventdata, handles)
% hObject    handle to Abs_Val_Peaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Abs_Val_Peaks

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to extract the trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Extract_Trials_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Trials_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Extract_Trials_COGMO_GUI_Help();
