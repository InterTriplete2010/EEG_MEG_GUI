function varargout = Envelope_Extraction_GUI(varargin)
% ENVELOPE_EXTRACTION_GUI MATLAB code for Envelope_Extraction_GUI.fig
%      ENVELOPE_EXTRACTION_GUI, by itself, creates a new ENVELOPE_EXTRACTION_GUI or raises the existing
%      singleton*.
%
%      H = ENVELOPE_EXTRACTION_GUI returns the handle to a new ENVELOPE_EXTRACTION_GUI or the handle to
%      the existing singleton*.
%
%      ENVELOPE_EXTRACTION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENVELOPE_EXTRACTION_GUI.M with the given input arguments.
%
%      ENVELOPE_EXTRACTION_GUI('Property','Value',...) creates a new ENVELOPE_EXTRACTION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Envelope_Extraction_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Envelope_Extraction_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Envelope_Extraction_GUI

% Last Modified by GUIDE v2.5 12-Jan-2022 10:01:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Envelope_Extraction_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Envelope_Extraction_GUI_OutputFcn, ...
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


% --- Executes just before Envelope_Extraction_GUI is made visible.
function Envelope_Extraction_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Envelope_Extraction_GUI (see VARARGIN)

% Choose default command line output for Envelope_Extraction_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Envelope_Extraction_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Envelope_Extraction_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Cut-off frequency of the low pass filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Cut_off_Freq_Env_Callback(hObject, eventdata, handles)
% hObject    handle to Cut_off_Freq_Env (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cut_off_Freq_Env as text
%        str2double(get(hObject,'String')) returns contents of Cut_off_Freq_Env as a double


% --- Executes during object creation, after setting all properties.
function Cut_off_Freq_Env_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cut_off_Freq_Env (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Order of the low pass filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Order_Filter_Envelope.
function Order_Filter_Envelope_Callback(hObject, eventdata, handles)
% hObject    handle to Order_Filter_Envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Order_Filter_Envelope contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Order_Filter_Envelope


% --- Executes during object creation, after setting all properties.
function Order_Filter_Envelope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Order_Filter_Envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Signal_Envelope.
function Upload_Signal_Envelope_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Signal_Envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global File_selected;
global File_directory;

[File_selected,File_directory] = uigetfile('*.mat','Select the mat file');

set(handles.Signal_Uploaded_Envelope,'String',File_selected);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Data uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Signal_Uploaded_Envelope_Callback(hObject, eventdata, handles)
% hObject    handle to Signal_Uploaded_Envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Signal_Uploaded_Envelope as text
%        str2double(get(hObject,'String')) returns contents of Signal_Uploaded_Envelope as a double


% --- Executes during object creation, after setting all properties.
function Signal_Uploaded_Envelope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Signal_Uploaded_Envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract the envelope by using the Hilbert Transform
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Envelope_Extraction.
function Envelope_Extraction_Callback(hObject, eventdata, handles)
% hObject    handle to Envelope_Extraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global File_selected;
global File_directory;

cd(File_directory)

temp_file = load(File_selected);

try
    
if(get(handles.Data_Chosen_Extract_Envelope,'Value') == 1)

    data_file = temp_file.data_exported.eeg_data;

else

    data_file = temp_file.data_exported.average_trials;
    
end

catch
   
    message = ('Wrong choice of data');

        msgbox(message,'Extract envelope','warn');
   
        return
end

if (isempty(data_file))
   
     message = ('Wrong choice of data');

        msgbox(message,'Extract envelope','warn');
   
        return
    
end

sf = temp_file.data_exported.sampling_frequency;

[b a] = butter(get(handles.Order_Filter_Envelope,'Value'),str2double(get(handles.Cut_off_Freq_Env,'String'))/(sf/2),'low');

%Extract the envelope by using the analytic signal
hilbert_data = abs(hilbert(data_file'));

%Low pass the envelope
hilbert_low_pass = (filtfilt(b,a,hilbert_data))';

figure
tt = [0:length(data_file)-1]/sf;

subplot(2,1,1)
plot(tt,data_file(1,:))
hold on
plot(tt,hilbert_data(:,1),'r')

xlabel('\bfTime (s)')
ylabel('\bfAmplitude(muV)')
title('Hilbert Transform of channel 1')
legend('Original signal','Envelope')

subplot(2,1,2)
plot(tt,data_file(1,:))
hold on
plot(tt,hilbert_low_pass(1,:),'r')

xlabel('\bfTime (s)')
ylabel('\bfAmplitude(muV)')
title('Low-passed Hilbert Transform')
legend('Original signal','Envelope')

try
data_exported.eeg_data = hilbert_low_pass; 
data_exported.sampling_frequency = sf;
data_exported.labels = temp_file.data_exported.data_exported.labels;
data_exported.channels = temp_file.data_exported.data_exported.channels;
data_exported.chanlocs = file_to_be_decimated.data_exported.chanlocs;

catch
    
end

try
data_exported.events_trigger = (temp_file.data_exported.data_exported.events_trigger);
data_exported.events_type = temp_file.data_exported.data_exported.events_type;

catch
    
end

try
        data_exported.sensors_removed = temp_file.data_exported.data_exported.sensors_removed;

catch
    
end

mat_file_envelope = File_selected;
mat_file_envelope(end-3:end) = []; %Removes the ".mat" extension
save_eeg = [mat_file_envelope '_Envelope' '.mat'];
save (save_eeg,'data_exported')

message = ('The envelope has been extracted and saved');

        msgbox(message,'Extract envelope','warn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to extract the envelope
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Extract_Envelope_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Extract_Envelope_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Envelope_Extraction_Help();


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Type of data to be extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Data_Chosen_Extract_Envelope.
function Data_Chosen_Extract_Envelope_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Chosen_Extract_Envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Data_Chosen_Extract_Envelope contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Data_Chosen_Extract_Envelope


% --- Executes during object creation, after setting all properties.
function Data_Chosen_Extract_Envelope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_Chosen_Extract_Envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
