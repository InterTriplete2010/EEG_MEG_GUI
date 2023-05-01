function varargout = Remove_ICA(varargin)
% REMOVE_ICA M-file for Remove_ICA.fig
%      REMOVE_ICA, by itself, creates a new REMOVE_ICA or raises the existing
%      singleton*.
%
%      H = REMOVE_ICA returns the handle to a new REMOVE_ICA or the handle to
%      the existing singleton*.
%
%      REMOVE_ICA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOVE_ICA.M with the given input arguments.
%
%      REMOVE_ICA('Property','Value',...) creates a new REMOVE_ICA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Remove_ICA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Remove_ICA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Remove_ICA

% Last Modified by GUIDE v2.5 10-Feb-2022 15:25:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Remove_ICA_OpeningFcn, ...
                   'gui_OutputFcn',  @Remove_ICA_OutputFcn, ...
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


% --- Executes just before Remove_ICA is made visible.
function Remove_ICA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Remove_ICA (see VARARGIN)

% Choose default command line output for Remove_ICA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Remove_ICA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Remove_ICA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot the ICA(s) selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Plot_ICA.
function Plot_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_ica_plot;
global mat_file_directory_ica_plot;
global labels_ica_plotted;
global struct_data_ICA;

channel_names = get(handles.ICA_to_Plot,'String');

plot_all_channel_check = get(handles.Plot_All_ICA,'Value');

time_duration = plot_ICA_data(mat_file_directory_ica_plot,mat_file_ica_plot,labels_ica_plotted,channel_names,...
    plot_all_channel_check,struct_data_ICA);

    set(handles.Length_File_ICA,'String',time_duration);
   
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Window to be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Length_File_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to Length_File_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Length_File_ICA as text
%        str2double(get(hObject,'String')) returns contents of Length_File_ICA as a double


% --- Executes during object creation, after setting all properties.
function Length_File_ICA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Length_File_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ICA to be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in ICA_to_Plot.
function ICA_to_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to ICA_to_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ICA_to_Plot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ICA_to_Plot


% --- Executes during object creation, after setting all properties.
function ICA_to_Plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ICA_to_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%If checked, all the ICA will be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Plot_All_ICA.
function Plot_All_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_All_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Plot_All_ICA

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the ICA file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_ICA.
function Upload_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_ica_plot;
global mat_file_directory_ica_plot;
global table_tag_plot_ica;
global labels_ica_plotted;
global struct_data_ICA;

table_tag_plot_ica = handles.Table_Plot_ICA;

[mat_file_ica_plot,mat_file_directory_ica_plot] = uigetfile('*.mat','Select the mat file');

cd(mat_file_directory_ica_plot);
struct_data_ICA = load(mat_file_ica_plot);

set(handles.ICA_Uploaded,'String',mat_file_ica_plot);

labels_ica_plotted = struct_data_ICA.data_exported.labels';

%Filling the table with the electrodes
set(handles.Table_Plot_ICA,'Data',labels_ica_plotted );
set(handles.Table_Plot_ICA,'columnname',{'ICA Extracted'});

set(handles.ICA_to_Plot,'Value',1);
warning off
pause(0.5)
set(handles.ICA_to_Plot,'String','N/A');   
warning on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ICA file uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ICA_Uploaded_Callback(hObject, eventdata, handles)
% hObject    handle to ICA_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ICA_Uploaded as text
%        str2double(get(hObject,'String')) returns contents of ICA_Uploaded as a double


% --- Executes during object creation, after setting all properties.
function ICA_Uploaded_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ICA_Uploaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Select the ICA to be plotted
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes when selected cell(s) is changed in Table_Plot_ICA.
function Table_Plot_ICA_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Table_Plot_ICA (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global table_tag_plot_ica;
global channels_to_be_plotted;
global labels_ica_plotted;
%global tag_data;


event_data_indices = eventdata.Indices;

properties_table = get(table_tag_plot_ica);

channels_to_be_plotted = zeros(1,size(event_data_indices,1));

for kk = 1:size(event_data_indices,1)
   
    channels_to_be_plotted(1,kk) = event_data_indices(kk,1);
    
end

%tag_data = 1;
set(handles.ICA_to_Plot,'String', labels_ica_plotted(channels_to_be_plotted)');
set(handles.ICA_to_be_Removed,'Value', 1);
set(handles.ICA_to_be_Removed,'String', labels_ica_plotted(channels_to_be_plotted)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EEG to be uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_EEG_ICA.
function Upload_EEG_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_EEG_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat_file_eeg_plot;
global mat_file_directory_eeg_plot;
global data_struct_neural_data;
%global tag_data;


[mat_file_eeg_plot,mat_file_directory_eeg_plot] = uigetfile('*.mat','Select the mat file');

cd(mat_file_directory_eeg_plot);
data_struct_neural_data = load(mat_file_eeg_plot);

%tag_data = 1;
set(handles.EEG_Uploaded_ICA,'String',mat_file_eeg_plot);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EEG uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function EEG_Uploaded_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to EEG_Uploaded_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EEG_Uploaded_ICA as text
%        str2double(get(hObject,'String')) returns contents of EEG_Uploaded_ICA as a double


% --- Executes during object creation, after setting all properties.
function EEG_Uploaded_ICA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EEG_Uploaded_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Remove the selected ICA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Remove_ICA.
function Remove_ICA_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_ICA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data_struct_neural_data;
global struct_data_ICA;
global mat_file_eeg_plot;
%global tag_data;
global temp_eeg_data_pre;

%Choose the type of data to analyze  
  try
      
switch get(handles.Remove_ICA_Choice,'Value') 
 
    case 1
           
           
            neural_data = data_struct_neural_data.data_exported.eeg_data;
                    
    case 2
        
          
            neural_data = data_struct_neural_data.data_exported.average_trials;
    
           
    case 3
                
        
neural_data = data_struct_neural_data.data_exported.average_add;

    case 4

                       
        neural_data = data_struct_neural_data.data_exported.average_sub;

end

  catch
   
       message = 'Invalid choice. Please, make sure your set of data support your choice. Check also the duration of the signal';

        msgbox(message,'Error','warn');
    
        return;
      
  end

  try
      
      time_d = data_struct_neural_data.data_exported.time_average;
      
  catch
     
      time_d = data_struct_neural_data.data_exported.time;
      
  end


% if tag_data == 1
% 
%     temp_eeg_data_pre = neural_data;
% 
%    tag_data = 0;
%     
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sphering the data
%  temp_eeg_data_pre = temp_eeg_data_pre';
% mean_data = mean(temp_eeg_data_pre);
% temp_eeg_data_pre = temp_eeg_data_pre - repmat(mean_data,[size(temp_eeg_data_pre,1),1]);

%Whitening the data to have uncorrelated rows of the signals recorded
% var_data = temp_eeg_data_pre'*temp_eeg_data_pre;
% [Eig_Vect,Eig_Val] = eig(var_data);
% 
% %See if there are negative eingvalues. If there are, replace them with
% %the symbolic, negligible value of 10^-6
% neg_eing_val = find(Eig_Val < 0);
% Eig_Val(neg_eing_val) = 10^-6;
% temp_eeg_data_pre = (Eig_Vect*sqrt(inv(Eig_Val))*Eig_Vect'*temp_eeg_data_pre')';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try

ica_to_remove = str2num(cell2mat(get(handles.ICA_to_be_Removed,'String')));

catch

    message = 'No ICA component has been selected';
msgbox(message,'Operation Aborted','warn','replace');

    return;

end

if(length(ica_to_remove) > 1)

    message = 'Only one ICA components can be selected';
msgbox(message,'Operation Aborted','warn','replace');

    return;

end
%ica_selected = struct_data.data_exported.eeg_data(:,ica_to_remove);

%projected_ica = struct_data.data_exported.eeg_data(:,ica_to_remove)*struct_data.data_exported.A(:,ica_to_remove)'; %Project out the data in the sensor space; 

%ica_selected = struct_data.data_exported.eeg_data(ica_to_remove,:);
projected_ica = [];
projected_ica = struct_data_ICA.data_exported.A(:,ica_to_remove).*struct_data_ICA.data_exported.eeg_data(ica_to_remove,:); %Project out the data in the sensor space; 

%Remove the ICA component(s) that have been projected out
%data_ica_removed = (temp_eeg_data_pre - projected_ica);
data_ica_removed = neural_data - projected_ica;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The plotting is used for debugging purpose only
repr_sensor = 1;
figure
subplot(2,1,1)
%plot(time_d,temp_eeg_data_pre(repr_sensor,:),'k')
plot(time_d,neural_data(repr_sensor,:),'k')
hold on
plot(time_d,data_ica_removed(repr_sensor,:),'r')
legend('Before','After')
title(['Representative sensor#' num2str(repr_sensor)])
subplot(2,1,2)
plot(time_d,struct_data_ICA.data_exported.eeg_data(ica_to_remove,:))
title('ICA chosen')
legend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% data_exported.eeg_data = data_ica_removed;
% data_exported.ica_removed = {ica_to_remove};
% data_exported.sampling_frequency = struct_data.data_exported.sampling_frequency;
% data_exported.time = time_d;

find_fields = fieldnames(data_struct_neural_data.data_exported);

data_exported = [];

for kk = 1:length(find_fields)

    if (kk == 1)

    data_exported.eeg_data = data_ica_removed;

    else

      data_exported = setfield(data_exported,cell2mat(find_fields(kk)),getfield(data_struct_neural_data.data_exported,cell2mat(find_fields(kk))));  

    end
   
end

%save([mat_file_eeg_plot '_ICA_removed.mat'],'data_exported')
save([mat_file_eeg_plot '_ICA_removed.mat'],'data_exported')

message = 'The ICA selected component have been removed';
msgbox(message,'Calculations completed','warn','replace');

% --- Executes on selection change in ICA_to_be_Removed.
function ICA_to_be_Removed_Callback(hObject, eventdata, handles)
% hObject    handle to ICA_to_be_Removed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ICA_to_be_Removed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ICA_to_be_Removed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ICA to be removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes during object creation, after setting all properties.
function ICA_to_be_Removed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ICA_to_be_Removed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choose which type of data to analyze
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on selection change in Remove_ICA_Choice.
function Remove_ICA_Choice_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_ICA_Choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Remove_ICA_Choice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Remove_ICA_Choice


% --- Executes during object creation, after setting all properties.
function Remove_ICA_Choice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Remove_ICA_Choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description of how to use the GUI to remove ICA components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Help_Remove_ICA_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Remove_ICA_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Remove_ICA_Help();
