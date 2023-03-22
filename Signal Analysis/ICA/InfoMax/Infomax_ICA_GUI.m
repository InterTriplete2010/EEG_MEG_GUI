function varargout = Infomax_ICA_GUI(varargin)
% INFOMAX_ICA_GUI MATLAB code for Infomax_ICA_GUI.fig
%      INFOMAX_ICA_GUI, by itself, creates a new INFOMAX_ICA_GUI or raises the existing
%      singleton*.
%
%      H = INFOMAX_ICA_GUI returns the handle to a new INFOMAX_ICA_GUI or the handle to
%      the existing singleton*.
%
%      INFOMAX_ICA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INFOMAX_ICA_GUI.M with the given input arguments.
%
%      INFOMAX_ICA_GUI('Property','Value',...) creates a new INFOMAX_ICA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Infomax_ICA_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Infomax_ICA_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Infomax_ICA_GUI

% Last Modified by GUIDE v2.5 22-Mar-2023 10:48:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Infomax_ICA_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Infomax_ICA_GUI_OutputFcn, ...
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


% --- Executes just before Infomax_ICA_GUI is made visible.
function Infomax_ICA_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Infomax_ICA_GUI (see VARARGIN)

% Choose default command line output for Infomax_ICA_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Infomax_ICA_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Infomax_ICA_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%Cal
% --- Executes on button press in Calculate_ICA_InfoMax.
function Calculate_ICA_InfoMax_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate_ICA_InfoMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dir_ica_infomax;

cd(dir_ica_infomax)

mat_files = dir;

[files_number] = size(mat_files,1);

track_files = 0;

for ii = 3:files_number
    
    if (strcmp(mat_files(ii).name(end-2:end), 'mat') == 1)

        track_files = track_files + 1;
        
  matrix_file = mat_files(ii).name;
  display(['File: ' matrix_file(1:end-4)])
  
  temp_eeg_file = load(matrix_file);
  
  %Choose the type of data to analyze  
  try
      
switch get(handles.Data_Type_InfoMax,'Value') 
 
    case 1
           
           
            ica_data = temp_eeg_file.data_exported.eeg_data;
                    
    case 2
        
          
            ica_data = temp_eeg_file.data_exported.average_trials;
    
           
    case 3
                
        
ica_data = temp_eeg_file.data_exported.average_add;

    case 4

                       
        ica_data = temp_eeg_file.data_exported.average_sub;

end

  catch
   
      if track_files < 1
      
       message = 'Invalid choice. Please, make sure your set of data support your choice. Check also the duration of the signal';

        msgbox(message,'Error','warn');
    
        return;
      
      end
  end

  if size(ica_data,1) < 2 && track_files < 1

    message = 'You need a minimum of 2 dimensions (e.g. electrodes) to perform ICA';

        msgbox(message,'Operation aborted','warn');
    
   return;
    
end
  
  try
      
      time_d = temp_eeg_file.data_exported.time_average;
      
  catch
     
      time_d = temp_eeg_file.data_exported.time;
      
  end
  
  
  %%Calculate ICA for each file uploaded and save the weights;
  %[weights,sphere,meanvar,bias,signs,lrates,data,y] = runica(ica_data);
  %[weights, sphere] = runica(ica_data);
  %data_exported.eeg_data = ica_data'*weights';    %Project the data into the ICA space
  
  if(get(handles.Extended_Option,'Value') == 1)

    [weights sphere] = runica(ica_data,'extended',1); 
  
  else

    [weights sphere] = runica(ica_data); 

  end

  %[weights sphere] = runica(ica_data); 
  
  %weights = [component, channel];

%% Saving the ICA components and the converting matrix
%data_exported.eeg_data = ica_data'*weights;    %Project the data into the ICA space
data_exported.eeg_data = weights*ica_data;    %Project the data into the ICA space
data_exported.sampling_frequency = temp_eeg_file.data_exported.sampling_frequency;
data_exported.time = time_d;
data_exported.W = weights;
data_exported.A = inv(weights);   %Inverse matrix to preject out the ICA data;

for gg = 1:size(data_exported.eeg_data,1)
   
   labels(gg) = {gg}; 
    
end

data_exported.labels = labels;

save([matrix_file '_ica.mat'],'data_exported')

end
    
end

message = 'ICA for each file has been extracted and saved';

        msgbox(message,'Analysis completed','warn');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the mat file for the ICA analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in InfoMax_Dir.
function InfoMax_Dir_Callback(hObject, eventdata, handles)
% hObject    handle to InfoMax_Dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_ica_infomax;
global dir_ica_infomax;

[mat_file_ica_infomax,dir_ica_infomax] = uigetfile('*.mat','Select the mat file');

set(handles.Dir_Selected_InfoMax,'String',dir_ica_infomax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mat file uploaded for the ICA analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Selected_InfoMax_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Selected_InfoMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Selected_InfoMax as text
%        str2double(get(hObject,'String')) returns contents of Dir_Selected_InfoMax as a double


% --- Executes during object creation, after setting all properties.
function Dir_Selected_InfoMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Selected_InfoMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose which type of data to analyze
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Data_Type_InfoMax.
function Data_Type_InfoMax_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Type_InfoMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Data_Type_InfoMax contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Data_Type_InfoMax


% --- Executes during object creation, after setting all properties.
function Data_Type_InfoMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_Type_InfoMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, ICA will be run with the argument "extended,1", which is used
%for strong line noise and/or slow activity in the data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Extended_Option.
function Extended_Option_Callback(hObject, eventdata, handles)
% hObject    handle to Extended_Option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Extended_Option

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Help Function for ICA (InfoMax)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Infomax_ICA_GUI_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Infomax_ICA_GUI_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Help_Infomax_ICA_GUI();
