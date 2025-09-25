function varargout = Rotate_DSS_ERP_Sensor_Space_EEG(varargin)
% ROTATE_DSS_ERP_SENSOR_SPACE_EEG MATLAB code for Rotate_DSS_ERP_Sensor_Space_EEG.fig
%      ROTATE_DSS_ERP_SENSOR_SPACE_EEG, by itself, creates a new ROTATE_DSS_ERP_SENSOR_SPACE_EEG or raises the existing
%      singleton*.
%
%      H = ROTATE_DSS_ERP_SENSOR_SPACE_EEG returns the handle to a new ROTATE_DSS_ERP_SENSOR_SPACE_EEG or the handle to
%      the existing singleton*.
%
%      ROTATE_DSS_ERP_SENSOR_SPACE_EEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTATE_DSS_ERP_SENSOR_SPACE_EEG.M with the given input arguments.
%
%      ROTATE_DSS_ERP_SENSOR_SPACE_EEG('Property','Value',...) creates a new ROTATE_DSS_ERP_SENSOR_SPACE_EEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Rotate_DSS_ERP_Sensor_Space_EEG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Rotate_DSS_ERP_Sensor_Space_EEG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Rotate_DSS_ERP_Sensor_Space_EEG

% Last Modified by GUIDE v2.5 25-Sep-2025 08:55:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Rotate_DSS_ERP_Sensor_Space_EEG_OpeningFcn, ...
                   'gui_OutputFcn',  @Rotate_DSS_ERP_Sensor_Space_EEG_OutputFcn, ...
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


% --- Executes just before Rotate_DSS_ERP_Sensor_Space_EEG is made visible.
function Rotate_DSS_ERP_Sensor_Space_EEG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Rotate_DSS_ERP_Sensor_Space_EEG (see VARARGIN)

% Choose default command line output for Rotate_DSS_ERP_Sensor_Space_EEG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Rotate_DSS_ERP_Sensor_Space_EEG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Rotate_DSS_ERP_Sensor_Space_EEG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upload the DSS data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Upload_DSS_Weights.
function Upload_DSS_Weights_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_DSS_Weights (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSS_Selected_Name;
global DSS_Selected;
global table_tag_plot_dss;

table_tag_plot_dss = handles.Table_DSS_Components;

[DSS_Selected_Name,DSS_Directory] = uigetfile('*.mat','Upload the DSS');

cd(DSS_Directory)

DSS_Selected = load(DSS_Selected_Name);

set(handles.File_Uploaded_DSS_Sensor_Space,'String',DSS_Selected_Name(1:end-4));

set(handles.Table_DSS_Components,'Data',DSS_Selected.data_exported.labels);
set(handles.Table_DSS_Components,'columnname',{'DSS Extracted'});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DSS data uploaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function File_Uploaded_DSS_Sensor_Space_Callback(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_DSS_Sensor_Space (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of File_Uploaded_DSS_Sensor_Space as text
%        str2double(get(hObject,'String')) returns contents of File_Uploaded_DSS_Sensor_Space as a double

% --- Executes during object creation, after setting all properties.
function File_Uploaded_DSS_Sensor_Space_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_Uploaded_DSS_Sensor_Space (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DSS components available
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Rotate_DSS_Data.
function Rotate_DSS_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Rotate_DSS_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSS_Selected_Name;
global DSS_Selected;
global dss_to_be_rotated;

unfold_dss = unfold(DSS_Selected.data_exported.dss);
DSS_rotated_single_sweeps = fold(unfold_dss(:,dss_to_be_rotated)*DSS_Selected.data_exported.fromdss(dss_to_be_rotated,:),size(DSS_Selected.data_exported.dss,1));
DSS_rotated = (DSS_Selected.data_exported.average_trials(dss_to_be_rotated,:)'*DSS_Selected.data_exported.fromdss(dss_to_be_rotated,:))';

temp_fields_name = fieldnames(DSS_Selected.data_exported);
temp_fields = struct2cell(DSS_Selected.data_exported);
data_exported = [];
for kk = 1:length(temp_fields)

    try

    data_exported = setfield(data_exported,cell2mat(temp_fields_name(kk)),cell2mat(temp_fields(kk)));

    catch

        labels_elec = {};
        for ll = 1:length(temp_fields{kk})


            labels_elec(ll,1) = {num2str(ll)};

        end

        data_exported = setfield(data_exported,cell2mat(temp_fields_name(kk)),labels_elec);

    end

end

data_exported.sensors_single_sweeps = DSS_rotated_single_sweeps;
data_exported.average_trials = DSS_rotated;
data_exported.eeg_data = DSS_rotated;
data_exported.DSS_Rotated_Space = dss_to_be_rotated;

save([DSS_Selected_Name(1:end-4) '_Rotated_Space.mat'],'data_exported')  

message = 'The data have been rotated in the sensor space with the selected DSS';

        msgbox(message,'Data have been rotated','warn','replace');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DSS components available
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes when selected cell(s) is changed in Table_DSS_Components.
function Table_DSS_Components_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Table_DSS_Components (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global table_tag_plot_ica;
global dss_to_be_rotated;

event_data_indices = eventdata.Indices;

properties_table = get(table_tag_plot_ica);

dss_to_be_rotated = zeros(1,size(event_data_indices,1));

for kk = 1:size(event_data_indices,1)
   
    dss_to_be_rotated(1,kk) = event_data_indices(kk,1);
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Menu used to describe how to use the GUI to rotate the data back in the
%sensor space
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function Rotate_DSS_ERP_Sensor_Space_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Rotate_DSS_ERP_Sensor_Space_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Rotate_DSS_ERP_Sensor_Space_EEG_Help();

