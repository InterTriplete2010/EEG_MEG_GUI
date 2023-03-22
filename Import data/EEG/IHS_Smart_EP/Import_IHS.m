function varargout = Import_IHS(varargin)
% IMPORT_IHS MATLAB code for Import_IHS.fig
%      IMPORT_IHS, by itself, creates a new IMPORT_IHS or raises the existing
%      singleton*.
%
%      H = IMPORT_IHS returns the handle to a new IMPORT_IHS or the handle to
%      the existing singleton*.
%
%      IMPORT_IHS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORT_IHS.M with the given input arguments.
%
%      IMPORT_IHS('Property','Value',...) creates a new IMPORT_IHS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Import_IHS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Import_IHS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Import_IHS

% Last Modified by GUIDE v2.5 13-Jan-2022 12:46:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Import_IHS_OpeningFcn, ...
                   'gui_OutputFcn',  @Import_IHS_OutputFcn, ...
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


% --- Executes just before Import_IHS is made visible.
function Import_IHS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Import_IHS (see VARARGIN)

% Choose default command line output for Import_IHS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Import_IHS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Import_IHS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory where to save the "mat" file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Save_File_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Save_File_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Save_File_IHS as text
%        str2double(get(hObject,'String')) returns contents of Dir_Save_File_IHS as a double


% --- Executes during object creation, after setting all properties.
function Dir_Save_File_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Save_File_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Folder where to save the "mat" file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Folder_Save_File_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Folder_Save_File_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Folder_Save_File_IHS as text
%        str2double(get(hObject,'String')) returns contents of Folder_Save_File_IHS as a double


% --- Executes during object creation, after setting all properties.
function Folder_Save_File_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Folder_Save_File_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Name of the "mat" file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Name_Save_File_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Name_Save_File_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Name_Save_File_IHS as text
%        str2double(get(hObject,'String')) returns contents of Name_Save_File_IHS as a double


% --- Executes during object creation, after setting all properties.
function Name_Save_File_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Name_Save_File_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IHS file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function IHS_File_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to IHS_File_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IHS_File_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of IHS_File_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function IHS_File_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IHS_File_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the IHS file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_IHS_File.
function Upload_IHS_File_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_IHS_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data_exported;

data_exported = [];

[IHS_file_selected,IHS_file_directory] = uigetfile('*','Select the "IHS" file');

%End the program, if no file has been selected
if (IHS_file_directory == 0)

    set(handles.IHS_File_Uploaded,'String','No_file_selected');
    
    message = 'No file has been selected';

        msgbox(message,'End of operation','warn');
    
        return;
    
end

set(handles.IHS_File_Uploaded,'String',IHS_file_directory);

%Read Brain Vision data
cd(IHS_file_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

track_save_sweeps = 1;
track_snr = 1;

for ii = 3:files_number
    
    
  matrix_file = mat_files(ii).name;     
  

filepath = [IHS_file_directory matrix_file];

%% Loading the IHS file selected
try

    [Buffer1, Buffer2, timearrayout, confarray, comments, s_per, DataPointsNum] = IhsReadwithTime(filepath);

% catch
%    
%    message = 'This is not an IHS file. Please, select the correct IHS file';
% 
%         msgbox(message,'Wrong file!!!','warn'); 
%     
%         return
% end
    
save_sweeps(track_save_sweeps,:) = Buffer1;
save_sweeps(track_save_sweeps + 1,:) = Buffer2;

track_save_sweeps = track_save_sweeps + 2;

%% Calculating the SNR by dividing signal by noise
sign_buffer = (Buffer1 + Buffer2)/2;
noise = (Buffer1 - Buffer2)/2;
%sqrt(mean(((sign(confarray(133):confarray(134))/(noise(confarray(133):confarray(134)))).^2)))

%SNR in dB
try

    num = sqrt(mean((sign_buffer(confarray(133):confarray(134)).^2)));
den = sqrt(mean((noise(confarray(133):confarray(134)).^2)));
snr = 10*log10((num/den).^2);

catch
   
    snr = {'NA'};
    
end


if confarray(5)== 1
       ear_stimulated = 'Left';
    elseif confarray(5)== 2
       ear_stimulated = 'Right';
else
       ear_stimulated = 'Both'; 
    end 

save_name(track_snr,:) = {matrix_file};
save_samples(track_snr,:) = (length(Buffer1) + length(Buffer2))/2;
save_sf(track_snr,:) = 1/(confarray(7)*10^-6);
save_sweeps_recorded(track_snr,:) = confarray(6);
save_sweeps_rejected(track_snr,:) = confarray(9);
save_intensity(track_snr,:) = confarray(4);
save_click_rate(track_snr,:) = confarray(8);
save_ear(track_snr,:) = {ear_stimulated};
save_gain(track_snr,:) = confarray(10)*1000;
save_snr(track_snr,:) = confarray(132)/100;
%save_snr(track_snr + 1,:) = snr;
save_high_pass(track_snr,:) = confarray(11);
save_low_pass(track_snr,:) = confarray(12);

track_snr = track_snr + 1;

catch
   
%    message = 'This is not an IHS file. Please, select the correct IHS file';
% 
%         msgbox(message,'Wrong file!!!','warn'); 
%     
%         return
end

end

if isempty(save_name)
   
    message = 'No IHS file was identified. Please, select a folder with IHS files';
 
         msgbox(message,'Wrong file(s)!!!','warn'); 
    
         return
end

%% Saving the odd and even sweeps in a 3D matrix and calculating the SNR of the average
%sign_odd = (save_sweeps(1,:) + save_sweeps(3,:))/2;
%sign_even =  (save_sweeps(2,:) + save_sweeps(4,:))/2;
sign_odd_matrix = [];
sign_even_matrix = [];
track_odd_even_sweeps = 1;

save_odd_even_sweeps = zeros(2,size(save_sweeps,1)/2,size(save_sweeps,2));

for kk = 1:size(save_sweeps,1)/2
    
    sign_odd_matrix = [sign_odd_matrix;save_sweeps(track_odd_even_sweeps,:)];
    sign_even_matrix = [sign_even_matrix;save_sweeps(track_odd_even_sweeps + 1,:)];
    
    save_odd_even_sweeps(1,kk,:) = save_sweeps(track_odd_even_sweeps,:);
    save_odd_even_sweeps(2,kk,:) = save_sweeps(track_odd_even_sweeps + 1,:);
        
    track_odd_even_sweeps = track_odd_even_sweeps + 2;
    
end


if (size(sign_odd_matrix,1) > 1)

    sign_odd = mean(sign_odd_matrix);
        sign_even = mean(sign_even_matrix);

else
    
    sign_odd = sign_odd_matrix;
        sign_even = sign_even_matrix;
        
end

sign_buffer = (sign_odd + sign_even)/2;
noise = (sign_odd - sign_even)/2;

try
    
num = sqrt(mean((sign_buffer(confarray(133):confarray(134)).^2)));
den = sqrt(mean((noise(confarray(133):confarray(134)).^2)));
snr = 10*log10((num/den).^2);
save_snr(1,:) = snr;

catch
   
    snr = {'NA'};
    
end

%% Saving the data
save_data_folder = get(handles.Folder_Save_File_IHS,'String');
save_data_directory = get(handles.Dir_Save_File_IHS,'String');
name_mat_file = get(handles.Name_Save_File_IHS,'String');

cd([save_data_directory])
mkdir(save_data_folder)
cd([save_data_directory '\' save_data_folder]);

%{
%% Checking if the grand average between the two ears has been calculated
length_char_ear = length(cell2mat(save_ear(1)));

for kk = 2:size(save_ear,1)
   
   length_char_ear_temp = length(cell2mat(save_ear(kk,1)));
   
   if (length_char_ear_temp ~= length_char_ear)
       
       save_ear(:) = {'Both'};
       
   end
    
end
%}
try 
    
data_exported.name = save_name;     
data_exported.grand_av = mean(save_sweeps);    
data_exported.odd_even_sweeps = save_odd_even_sweeps;
%data_exported.odd_sweeps_1 = save_sweeps(1,:); 
%data_exported.even_sweeps_1 = save_sweeps(2,:);
%data_exported.av_1 = mean(save_sweeps(1:2,:));
%data_exported.odd_sweeps_2 = save_sweeps(3,:); 
%data_exported.even_sweeps_2 = save_sweeps(4,:);
%data_exported.av_2 = mean(save_sweeps(3:4,:));
data_exported.samples = length(Buffer1);
data_exported.time = timearrayout - str2double(get(handles.Trigger_Time,'String'));

%Code to check if the onset is identified correctly;
        if (str2double(get(handles.Trigger_Time,'String')) == 0);
            
            data_exported.time_zero_position = confarray(112);

        else
    
            data_exported.time_zero_position = find(data_exported.time < 0,1,'Last');
                
        end
        
data_exported.sampling_frequency = 1/(confarray(7)*10^-6);
data_exported.sweeps = confarray(6);
data_exported.sweeps_rejected = confarray(9);
data_exported.intensity = confarray(4);
data_exported.click_rate = confarray(8);
data_exported.ear = save_ear;
data_exported.gain = confarray(10)*1000;
data_exported.SNR = save_snr(1);
%data_exported.SNR_1 = save_snr(1);
%data_exported.SNR_2 = save_snr(2);
data_exported.HPF = confarray(11);
data_exported.LPF = confarray(12);

catch
    
end

 
save_eeg = [name_mat_file '.' 'mat'];
save (save_eeg,'data_exported')

 set(handles.File_IHS,'String',save_name);
 set(handles.Samples_IHS,'String',save_samples);
 set (handles.SF_IHS,'String',save_sf);
set(handles.Sweeps_IHS,'String',save_sweeps_recorded);
set(handles.Sweeps_Rej_IHS,'String',save_sweeps_rejected);
set(handles.Intensity_IHS,'String',save_intensity);
set(handles.Click_Rate_IHS,'String',save_click_rate);
set(handles.Ear_IHS,'String',save_ear);
set(handles.Gain_IHS,'String',save_gain);
set(handles.SNR_IHS,'String',save_snr);
set(handles.HPF_IHS,'String',save_high_pass);
set(handles.LPF_IHS,'String',save_low_pass);

message = 'EEGs have been saved';

        msgbox(message,'EEG saved','warn');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu for the analysis of IHS data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Menu_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Peak latency
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Peaks_Latency_Callback(hObject, eventdata, handles)
% hObject    handle to Peaks_Latency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Peak_latency_IHS_GUI();


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%cABR analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function FFR_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to FFR_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cABR_GUI();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File name IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in File_IHS.
function File_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to File_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns File_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from File_IHS


% --- Executes during object creation, after setting all properties.
function File_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Samples per sweep collected IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Samples_IHS.
function Samples_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Samples_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Samples_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Samples_IHS


% --- Executes during object creation, after setting all properties.
function Samples_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Samples_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sampling frequency IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in SF_IHS.
function SF_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to SF_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SF_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SF_IHS


% --- Executes during object creation, after setting all properties.
function SF_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SF_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sweeps collected IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Sweeps_IHS.
function Sweeps_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Sweeps_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Sweeps_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Sweeps_IHS


% --- Executes during object creation, after setting all properties.
function Sweeps_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweeps_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sweeps rejected IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Sweeps_Rej_IHS.
function Sweeps_Rej_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Sweeps_Rej_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Sweeps_Rej_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Sweeps_Rej_IHS


% --- Executes during object creation, after setting all properties.
function Sweeps_Rej_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sweeps_Rej_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Intensity IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Intensity_IHS.
function Intensity_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Intensity_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Intensity_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Intensity_IHS


% --- Executes during object creation, after setting all properties.
function Intensity_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Intensity_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Click rate IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Click_Rate_IHS.
function Click_Rate_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Click_Rate_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Click_Rate_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Click_Rate_IHS


% --- Executes during object creation, after setting all properties.
function Click_Rate_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Click_Rate_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Ear stimulated IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Ear_IHS.
function Ear_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Ear_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Ear_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Ear_IHS


% --- Executes during object creation, after setting all properties.
function Ear_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ear_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gain IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Gain_IHS.
function Gain_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Gain_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Gain_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Gain_IHS


% --- Executes during object creation, after setting all properties.
function Gain_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gain_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SNR IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in SNR_IHS.
function SNR_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to SNR_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SNR_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SNR_IHS


% --- Executes during object creation, after setting all properties.
function SNR_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%High Pass Filter IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in HPF_IHS.
function HPF_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to HPF_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns HPF_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from HPF_IHS


% --- Executes during object creation, after setting all properties.
function HPF_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HPF_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Low Pass Filter IHS file extracted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in LPF_IHS.
function LPF_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to LPF_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LPF_IHS contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LPF_IHS


% --- Executes during object creation, after setting all properties.
function LPF_IHS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LPF_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract and Normalize cABR latencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Extract_Normalize_cABR_latencies_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_Normalize_cABR_latencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Extract_Normalize_cABR_latencies_GUI();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Trigger time for SEPCAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Trigger_Time_Callback(hObject, eventdata, handles)
% hObject    handle to Trigger_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Trigger_Time as text
%        str2double(get(hObject,'String')) returns contents of Trigger_Time as a double


% --- Executes during object creation, after setting all properties.
function Trigger_Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trigger_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Correlation IHS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Correlation_IHS_Callback(hObject, eventdata, handles)
% hObject    handle to Correlation_IHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Corr_IHS_Averages();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu for the click analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Extract_clicks_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_clicks_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract peaks and latencies for the differences of the right and left 
%ears
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Peaks_Latency_Diff_Ears_Callback(hObject, eventdata, handles)
% hObject    handle to Peaks_Latency_Diff_Ears (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Peak_latency_Right_Left_IHS_GUI();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to import SMART_EP data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Import_SMART_EP_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Import_SMART_EP_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Import_SMART_EP();
