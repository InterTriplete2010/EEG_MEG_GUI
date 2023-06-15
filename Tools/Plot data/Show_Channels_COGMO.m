function varargout = Show_Channels_COGMO(varargin)
% SHOW_CHANNELS_COGMO M-file for Show_Channels_COGMO.fig
%      SHOW_CHANNELS_COGMO, by itself, creates a new SHOW_CHANNELS_COGMO or raises the existing
%      singleton*.
%
%      H = SHOW_CHANNELS_COGMO returns the handle to a new SHOW_CHANNELS_COGMO or the handle to
%      the existing singleton*.
%
%      SHOW_CHANNELS_COGMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOW_CHANNELS_COGMO.M with the given input arguments.
%
%      SHOW_CHANNELS_COGMO('Property','Value',...) creates a new SHOW_CHANNELS_COGMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Show_Channels_COGMO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Show_Channels_COGMO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Show_Channels_COGMO

% Last Modified by GUIDE v2.5 15-Jun-2023 09:45:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Show_Channels_COGMO_OpeningFcn, ...
                   'gui_OutputFcn',  @Show_Channels_COGMO_OutputFcn, ...
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


% --- Executes just before Show_Channels_COGMO is made visible.
function Show_Channels_COGMO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Show_Channels_COGMO (see VARARGIN)

% Choose default command line output for Show_Channels_COGMO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Show_Channels_COGMO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Show_Channels_COGMO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot the channel(s) selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Plot_Channels_COGMO.
function Plot_Channels_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Channels_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_eeg_plot;
global mat_file_directory_eeg_plot;
global channels_to_be_plotted;
global struct_data;
global triggers_number;

triggers_number = [];

channel_names = get(handles.Channel_to_Plot_COGMO,'String');

plot_all_channel_check = get(handles.Plot_All_Channels_COGMO,'Value');
plot_triggers_check = get(handles.plot_triggers_COGMO,'Value');

plot_av = get(handles.Plot_Av_Data,'Value');
data_plot = get(handles.EEG_MEG_Plot,'Value');

time_s = str2double(get(handles.Start_TW_Plot,'String'));
time_e = str2double(get(handles.End_TW_Plot,'String'));
time_w = get(handles.Plot_WS,'Value');

invert_polarity_data = get(handles.Invert_Polarity,'Value');

[triggers_number time_duration] = plot_data_COGMO(mat_file_directory_eeg_plot,mat_file_eeg_plot,channels_to_be_plotted,channel_names,...
    plot_all_channel_check,plot_triggers_check,struct_data,plot_av,data_plot,time_s,time_e,time_w,handles,invert_polarity_data);

    set(handles.Length_File_COGMO,'String',time_duration);
   
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Window to be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Length_File_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Length_File_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Length_File_COGMO as text
%        str2double(get(hObject,'String')) returns contents of Length_File_COGMO as a double


% --- Executes during object creation, after setting all properties.
function Length_File_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Length_File_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Channel to be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Channel_to_Plot_COGMO.
function Channel_to_Plot_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Channel_to_Plot_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Channel_to_Plot_COGMO contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Channel_to_Plot_COGMO


% --- Executes during object creation, after setting all properties.
function Channel_to_Plot_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Channel_to_Plot_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, all channels will be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Plot_All_Channels_COGMO.
function Plot_All_Channels_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_All_Channels_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Plot_All_Channels_COGMO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the BV file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_EEG_COGMO.
function Upload_EEG_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_EEG_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_eeg_plot;
global mat_file_directory_eeg_plot;
global table_tag_plot_channels;
global labels_electrodes_plotted;
global struct_data;

struct_data = [];
table_tag_plot_channels = handles.Table_Plot_Channels;

try

if (get(handles.EEG_MEG_Plot,'Value') == 1)
    
[mat_file_eeg_plot,mat_file_directory_eeg_plot] = uigetfile('*.mat','Select the mat file');

cd(mat_file_directory_eeg_plot);
struct_data = load(mat_file_eeg_plot);

labels_electrodes_plotted = struct_data.data_exported.labels';

else
    
    [mat_file_eeg_plot,mat_file_directory_eeg_plot] = uigetfile('*.sqd','Select the mat file');
    
    [MEG_data, Info_MEG] = sqdread(mat_file_eeg_plot,'Format','double');
   
    struct_data.data_exported.eeg_data = MEG_data';
   
    for kk = 1:size(MEG_data,2)
       
    labels_electrodes_plotted(kk) = {kk};

   end
   
    struct_data.data_exported.labels = labels_electrodes_plotted';
struct_data.data_exported.sampling_frequency = Info_MEG.SampleRate;

end

set(handles.EEG_Uploaded_COGMO,'String',mat_file_eeg_plot);

%Filling the table with the electrodes
warning off
set(handles.Table_Plot_Channels,'Data',struct_data.data_exported.labels);
set(handles.Table_Plot_Channels,'columnname',{'Electrodes recorded'});

pause(0.05)
set(handles.Channel_to_Plot_COGMO,'Value',1);
set(handles.Channel_to_Plot_COGMO,'String','N/A');
warning on

catch
    
    message = ('Make sure you uploaded an appriopriate file for your selection EEG or MEG (sqd)');
        msgbox(message,'Operation terminated','warn');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BV file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function EEG_Uploaded_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to EEG_Uploaded_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EEG_Uploaded_COGMO as text
%        str2double(get(hObject,'String')) returns contents of EEG_Uploaded_COGMO as a double


% --- Executes during object creation, after setting all properties.
function EEG_Uploaded_COGMO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EEG_Uploaded_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the triggers will be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in plot_triggers_COGMO.
function plot_triggers_COGMO_Callback(hObject, eventdata, handles)
% hObject    handle to plot_triggers_COGMO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plot_triggers_COGMO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select the channels to be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes when selected cell(s) is changed in Table_Plot_Channels.
function Table_Plot_Channels_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Table_Plot_Channels (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global table_tag_plot_channels;
global channels_to_be_plotted;
global labels_electrodes_plotted;

event_data_indices = eventdata.Indices;

properties_table = get(table_tag_plot_channels);

channels_to_be_plotted = zeros(1,size(event_data_indices,1));

for kk = 1:size(event_data_indices,1)
   
    channels_to_be_plotted(1,kk) = event_data_indices(kk,1);
    
end

set(handles.Channel_to_Plot_COGMO,'String', labels_electrodes_plotted(channels_to_be_plotted)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the average will be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Plot_Av_Data.
function Plot_Av_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Av_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Plot_Av_Data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose between EEG and MEG dat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in EEG_MEG_Plot.
function EEG_MEG_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to EEG_MEG_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns EEG_MEG_Plot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from EEG_MEG_Plot


% --- Executes during object creation, after setting all properties.
function EEG_MEG_Plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EEG_MEG_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu to use the GUI to plot data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Plot_Data_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Data_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Plot_Data_Help()


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Starting time to plot the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Start_TW_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Start_TW_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Start_TW_Plot as text
%        str2double(get(hObject,'String')) returns contents of Start_TW_Plot as a double


% --- Executes during object creation, after setting all properties.
function Start_TW_Plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Start_TW_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End time to plot the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function End_TW_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to End_TW_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of End_TW_Plot as text
%        str2double(get(hObject,'String')) returns contents of End_TW_Plot as a double


% --- Executes during object creation, after setting all properties.
function End_TW_Plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_TW_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the whole signal will be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Plot_WS.
function Plot_WS_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_WS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Plot_WS
if(get(handles.Plot_WS,'Value') == 1)
   
    set(handles.Start_TW_Plot,'Enable','Off');
    set(handles.End_TW_Plot,'Enable','Off');
    
else
    
    set(handles.Start_TW_Plot,'Enable','On');
    set(handles.End_TW_Plot,'Enable','On');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, the polarity of the signal(s) will be changed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Invert_Polarity.
function Invert_Polarity_Callback(hObject, eventdata, handles)
% hObject    handle to Invert_Polarity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Invert_Polarity
