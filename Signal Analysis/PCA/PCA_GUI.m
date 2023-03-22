function varargout = PCA_GUI(varargin)
% PCA_GUI MATLAB code for PCA_GUI.fig
%      PCA_GUI, by itself, creates a new PCA_GUI or raises the existing
%      singleton*.
%
%      H = PCA_GUI returns the handle to a new PCA_GUI or the handle to
%      the existing singleton*.
%
%      PCA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCA_GUI.M with the given input arguments.
%
%      PCA_GUI('Property','Value',...) creates a new PCA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PCA_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PCA_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PCA_GUI

% Last Modified by GUIDE v2.5 15-Feb-2022 10:14:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PCA_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PCA_GUI_OutputFcn, ...
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


% --- Executes just before PCA_GUI is made visible.
function PCA_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PCA_GUI (see VARARGIN)

% Choose default command line output for PCA_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PCA_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PCA_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the mat file for the ICA analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Dir_PCA.
function Dir_PCA_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_PCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_ica_infomax;
global dir_ica_infomax;

[mat_file_ica_infomax,dir_ica_infomax] = uigetfile('*.mat','Select the mat file');

set(handles.Dir_Selected_ICA_Infomax,'String',dir_ica_infomax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mat file uploaded for the ICA analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Dir_Selected_ICA_Infomax_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_Selected_ICA_Infomax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dir_Selected_ICA_Infomax as text
%        str2double(get(hObject,'String')) returns contents of Dir_Selected_ICA_Infomax as a double


% --- Executes during object creation, after setting all properties.
function Dir_Selected_ICA_Infomax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dir_Selected_ICA_Infomax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calcualte ICA using Infomax algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Calculate_PCA.
function Calculate_PCA_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate_PCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dir_ica_infomax;

cd(dir_ica_infomax)

mat_files = dir;

[files_number] = size(mat_files,1);

track_files = 0;

for ii = 3:files_number
      
    try
        
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)

        track_files = track_files + 1;
        
  matrix_file = mat_files(ii).name 
  
  temp_eeg_file = load(matrix_file);
  
%Choose the type of data to analyze  
  try
      
switch get(handles.Choice_Data_PCA,'Value') 
 
    case 1
           
           
            pca_data = temp_eeg_file.data_exported.eeg_data;
                    
    case 2
        
          
            pca_data = temp_eeg_file.data_exported.average_trials;
    
           
    case 3
                
        
pca_data = temp_eeg_file.data_exported.average_add;

    case 4

                       
        pca_data = temp_eeg_file.data_exported.average_sub;

end

  catch
   
       message = 'Invalid choice. Please, make sure your set of data support your choice. Check also the duration of the signal';

        msgbox(message,'Error','warn');
    
        return;
      
  end

  try
      
      time_d = temp_eeg_file.data_exported.time_average;
      
  catch
     
      time_d = temp_eeg_file.data_exported.time;
      
  end
  
if size(pca_data,1) < 2

    message = 'You need a minimum of 2 dimensions (e.g. electrodes) to perform PCA';

        msgbox(message,'Operation aborted','warn');
    
   return;
    
end

 %%Calculate PCA for each file uploaded and save the weights;
  [pca_space,E_Vectors_sorted,E_Values_sorted,perc_eing_val] = PCA_function(pca_data,time_d);
  
  saveas (gcf,['Six_PCA_' mat_files(ii).name(1:end-4) '.fig'])
  
  close(gcf)
  
  principal_component_space_save(track_files,1) = {pca_space'};
  names_files(track_files,1) = {matrix_file(1:end-4)};
  eigen_vectors_save(:,:,track_files) = {E_Vectors_sorted};
  eigenvalues_save(:,track_files) = {E_Values_sorted};
  pca_percentage_eigen_val_save(:,track_files) = {perc_eing_val};
    
    
    end

    catch
        
end

end

for kk = 1:size(pca_space,1)
     
      labels(kk,1) = {['PCA_' num2str(kk)]};
      
  end

data_exported.eeg_data = principal_component_space_save;
data_exported.sampling_frequency = temp_eeg_file.data_exported.sampling_frequency;
data_exported.time = time_d;
data_exported.names_files = names_files;
data_exported.pca_eigen_vectors = eigen_vectors_save;
data_exported.pca_eigenvalues = eigenvalues_save;
data_exported.pca_percentage_eigen_val_save = pca_percentage_eigen_val_save;
data_exported.labels = labels;

save('PCA_Files.mat','data_exported','-v7.3')
  
message = 'PCA for each file has been extracted and saved';

        msgbox(message,'Analysis completed','warn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose which type of data to analyze
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Choice_Data_PCA.
function Choice_Data_PCA_Callback(hObject, eventdata, handles)
% hObject    handle to Choice_Data_PCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Choice_Data_PCA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Choice_Data_PCA


% --- Executes during object creation, after setting all properties.
function Choice_Data_PCA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Choice_Data_PCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to extract the PCA components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function PCA_Help_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to PCA_Help_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PCA_GUI_Help();
