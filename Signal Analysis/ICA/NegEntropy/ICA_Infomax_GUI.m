function varargout = ICA_Infomax_GUI(varargin)
% ICA_INFOMAX_GUI MATLAB code for ICA_Infomax_GUI.fig
%      ICA_INFOMAX_GUI, by itself, creates a new ICA_INFOMAX_GUI or raises the existing
%      singleton*.
%
%      H = ICA_INFOMAX_GUI returns the handle to a new ICA_INFOMAX_GUI or the handle to
%      the existing singleton*.
%
%      ICA_INFOMAX_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICA_INFOMAX_GUI.M with the given input arguments.
%
%      ICA_INFOMAX_GUI('Property','Value',...) creates a new ICA_INFOMAX_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ICA_Infomax_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ICA_Infomax_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ICA_Infomax_GUI

% Last Modified by GUIDE v2.5 22-Mar-2023 10:42:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ICA_Infomax_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ICA_Infomax_GUI_OutputFcn, ...
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


% --- Executes just before ICA_Infomax_GUI is made visible.
function ICA_Infomax_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ICA_Infomax_GUI (see VARARGIN)

% Choose default command line output for ICA_Infomax_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ICA_Infomax_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ICA_Infomax_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the mat file for the ICA analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Dir_ICA_Entropy.
function Dir_ICA_Entropy_Callback(hObject, eventdata, handles)
% hObject    handle to Dir_ICA_Entropy (see GCBO)
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
%Calcualte ICA using Negative Entropy algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Calculate_ICA_Infomax.
function Calculate_ICA_Infomax_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate_ICA_Infomax (see GCBO)
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
      
switch get(handles.Data_Type_ICA,'Value') 
 
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

  grad_step = str2double(get(handles.Step_Grad_ICA,'String'));
  max_iter = str2double(get(handles.Max_Iter_ICA,'String'));
  toll_step = str2num(get(handles.Toll_Step_ICA,'String'));
  
  [weights source_signal] = ICA_Alex_Max_NegEntropy_ToolBox(ica_data,grad_step,max_iter,toll_step);
  
%% Saving the ICA components and the converting matrix
%data_exported.eeg_data = ica_data'*weights;    %Project the data into the ICA space
data_exported.eeg_data = source_signal';    %Project the data into the ICA space
data_exported.sampling_frequency = temp_eeg_file.data_exported.sampling_frequency;
data_exported.time = time_d;
data_exported.W = weights';
data_exported.A = inv(weights');   %Inverse matrix to prejct out the ICA data;

for gg = 1:size(data_exported.eeg_data,1)
   
   labels(gg) = {gg}; 
    
end

data_exported.labels = labels;

save([matrix_file(1:end-4) '_ica.mat'],'data_exported')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This chunck of code is used for debugging
%Plotting the first 6 ICA components, if 6 have been calculated. Otherwise,
%plot the maximum number of componenets calculated

% if size(data_exported.eeg_data,2) >= 6
%     
%     plot_ica = 6
%     
% else
%     
%     plot_ica = size(ica_data,2);
%     
% end
% 
% figure
% for kk = 1:plot_ica
%     
%    subplot(plot_ica,1,kk)
%    
%     plot(time_d,data_exported.eeg_data(:,kk))
%     
%     title(['ICA#' num2str(kk)])
%     
%     axis tight
%     
% end
% 
%   xlabel('\bfTime (s)')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    end
    
end

message = 'ICA for each file has been extracted and saved';

        msgbox(message,'Analysis completed','warn');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose which type of data to analyze
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Data_Type_ICA.
function Data_Type_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Type_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Data_Type_ICA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Data_Type_ICA


% --- Executes during object creation, after setting all properties.
function Data_Type_ICA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_Type_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step for the gradient ascent
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Step_Grad_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to Step_Grad_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step_Grad_ICA as text
%        str2double(get(hObject,'String')) returns contents of Step_Grad_ICA as a double


% --- Executes during object creation, after setting all properties.
function Step_Grad_ICA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step_Grad_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Maximum iterations for the ICA analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Max_Iter_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Iter_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Iter_ICA as text
%        str2double(get(hObject,'String')) returns contents of Max_Iter_ICA as a double


% --- Executes during object creation, after setting all properties.
function Max_Iter_ICA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Iter_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tollerance to terminate the ICA calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Toll_Step_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to Toll_Step_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Toll_Step_ICA as text
%        str2double(get(hObject,'String')) returns contents of Toll_Step_ICA as a double


% --- Executes during object creation, after setting all properties.
function Toll_Step_ICA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Toll_Step_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Help Function for ICA (NegEntropy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function ICA_NegEntropy_Help_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to ICA_NegEntropy_Help_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ICA_Entropy_Help();
