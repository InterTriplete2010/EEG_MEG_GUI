function varargout = Convert_to_DSS(varargin)
% CONVERT_TO_DSS MATLAB code for Convert_to_DSS.fig
%      CONVERT_TO_DSS, by itself, creates a new CONVERT_TO_DSS or raises the existing
%      singleton*.
%
%      H = CONVERT_TO_DSS returns the handle to a new CONVERT_TO_DSS or the handle to
%      the existing singleton*.
%
%      CONVERT_TO_DSS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVERT_TO_DSS.M with the given input arguments.
%
%      CONVERT_TO_DSS('Property','Value',...) creates a new CONVERT_TO_DSS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Convert_to_DSS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Convert_to_DSS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Convert_to_DSS

% Last Modified by GUIDE v2.5 22-Nov-2021 15:04:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Convert_to_DSS_OpeningFcn, ...
                   'gui_OutputFcn',  @Convert_to_DSS_OutputFcn, ...
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


% --- Executes just before Convert_to_DSS is made visible.
function Convert_to_DSS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Convert_to_DSS (see VARARGIN)

% Choose default command line output for Convert_to_DSS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Convert_to_DSS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Convert_to_DSS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the directory with the files to be converted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_Dir.
function Upload_Dir_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_Dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_selected;
global mat_file_directory;

[mat_file_selected, mat_file_directory] = uigetfile('*.mat','Select the directory');

cd(mat_file_directory)

set(handles.Dir_Chosen,'String',mat_file_directory);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory chosen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Chosen_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Chosen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Chosen as text
%        str2double(get(hObject,'String')) returns contents of Dir_Chosen as a double


% --- Executes during object creation, after setting all properties.
function Dir_Chosen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Chosen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Convert the data to DSS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Convert_DSS.
function Convert_DSS_Callback(hObject, eventdata, handles)
% hObject    handle to Convert_DSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_selected;
global mat_file_directory;

dir_files = dir;

files_number = size(dir_files,1);

mkdir('Decoding_Format');

data_chosen = get(handles.Data_Type,'Value');

track_data = 0;

%Loop through all the files in the folder
for kk = 3:files_number
   
    matrix_file = dir_files(kk).name;      
  
    display(['Current file: ' matrix_file])
    
  if (strcmp(matrix_file(1,end-2:end),'mat') == 1) 
     
      [data_exported flag_file] = Convert_to_Neural_Decoding_Format_Function(matrix_file,data_chosen);
      
      if (flag_file == 1)
          
          track_data = track_data + 1;
          
      cd('Decoding_Format')
      
      save ([matrix_file(1,1:end-4) '_Neural_Decoding.mat'],'data_exported','-v7.3')
  
      cd ..
      
      end
      
  end
    
end

message = [num2str(track_data) ' file(s) have been converted into the proper DSS format'];
msgbox(message,'End of the conversion','warn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Type of data to be converted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Data_Type.
function Data_Type_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Data_Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Data_Type


% --- Executes during object creation, after setting all properties.
function Data_Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to convert files into a suitable
%format for DSS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Convert_to_DSS_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Convert_to_DSS_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Convert_to_DSS_Help();
