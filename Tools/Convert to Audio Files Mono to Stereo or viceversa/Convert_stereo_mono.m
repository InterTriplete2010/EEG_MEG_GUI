function varargout = Convert_stereo_mono(varargin)
% CONVERT_STEREO_MONO MATLAB code for Convert_stereo_mono.fig
%      CONVERT_STEREO_MONO, by itself, creates a new CONVERT_STEREO_MONO or raises the existing
%      singleton*.
%
%      H = CONVERT_STEREO_MONO returns the handle to a new CONVERT_STEREO_MONO or the handle to
%      the existing singleton*.
%
%      CONVERT_STEREO_MONO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVERT_STEREO_MONO.M with the given input arguments.
%
%      CONVERT_STEREO_MONO('Property','Value',...) creates a new CONVERT_STEREO_MONO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Convert_stereo_mono_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Convert_stereo_mono_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Convert_stereo_mono

% Last Modified by GUIDE v2.5 22-Nov-2021 09:06:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Convert_stereo_mono_OpeningFcn, ...
                   'gui_OutputFcn',  @Convert_stereo_mono_OutputFcn, ...
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


% --- Executes just before Convert_stereo_mono is made visible.
function Convert_stereo_mono_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Convert_stereo_mono (see VARARGIN)

% Choose default command line output for Convert_stereo_mono
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Convert_stereo_mono wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Convert_stereo_mono_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory with the audio files to be converted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Convert_Audio_Files.
function Convert_Audio_Files_Callback(hObject, eventdata, handles)
% hObject    handle to Convert_Audio_Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_selected;
global wav_file_directory;

dir_files = dir;

files_number = size(dir_files,1);

mkdir('Audio_Files_Converted');

track_data = 0;

%Loop through all the files in the folder
for kk = 3:files_number
   
    matrix_file = dir_files(kk).name;      
  
    display(['Current file: ' matrix_file])
    
  if (strcmp(matrix_file(1,end-2:end),'wav') == 1) 
     
      [audio_file,Fs,flag_file] = Convert_to_Mono_Stereo_Function(matrix_file);
      
      track_data = track_data + 1;
      
      cd('Audio_Files_Converted')
      
      if (flag_file == 1)
      
        audiowrite([matrix_file(1,1:end-4) '_Mono.wav'], audio_file,Fs)
  
      else
         
          audiowrite([matrix_file(1,1:end-4) '_Stereo.wav'], audio_file,Fs)
          
      end
   
      cd ..
      
  end
    
end

message = [num2str(track_data) ' files have been converted into Mono o Stereo format'];
msgbox(message,'End of the conversion','warn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Convert the audio files to mono o stereo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Directory_Chosen_Audio_Callback(hObject, eventdata, handles)
% hObject    handle to Directory_Chosen_Audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Directory_Chosen_Audio as text
%        str2double(get(hObject,'String')) returns contents of Directory_Chosen_Audio as a double


% --- Executes during object creation, after setting all properties.
function Directory_Chosen_Audio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Directory_Chosen_Audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory with the audio files to be converted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Directory_Audio.
function Upload_Directory_Audio_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Directory_Audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wav_file_selected;
global wav_file_directory;

[wav_file_selected, wav_file_directory] = uigetfile('*.wav','Select the directory');

cd(wav_file_directory)

set(handles.Directory_Chosen_Audio,'String',wav_file_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to convert audio files into 
%mono o stereo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Convert_stereo_mono_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Convert_stereo_mono_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Convert_stereo_mono
