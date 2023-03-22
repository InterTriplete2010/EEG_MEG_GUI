function remove_selected_sensors_function_COGMO(mat_file_selected,mat_file_directory,sensors_to_remove);

inputfile = [mat_file_directory '\' mat_file_selected];
inputfileloaded = load(inputfile);

cd(mat_file_directory)

input_file_sensors = inputfileloaded.data_exported.eeg_data;

sensors_removed_names = inputfileloaded.data_exported.labels(sensors_to_remove);

new_sensors_names = inputfileloaded.data_exported.labels;
new_sensors_names(sensors_to_remove,:) = [];

input_file_sensors(sensors_to_remove,:) = [];

try
data_exported.eeg_data = input_file_sensors; 
data_exported.channels = size(input_file_sensors,1);
data_exported.samples = size(input_file_sensors,2);
try
    
    data_exported.time = inputfileloaded.data_exported.time;
    
catch
    
    data_exported.time = inputfileloaded.data_exported.time_average;
    
end
data_exported.sampling_frequency = inputfileloaded.data_exported.sampling_frequency;
data_exported.trial_duration = (size(input_file_sensors,2) - 1)/inputfileloaded.data_exported.sampling_frequency;
data_exported.labels = new_sensors_names;
data_exported.sensors_removed = inputfileloaded.data_exported.labels(sensors_to_remove);
%data_exported.chanlocs = inputfileloaded.data_exported.chanlocs;
data_exported.events_trigger = inputfileloaded.data_exported.events_trigger;
data_exported.events_type = inputfileloaded.data_exported.events_type;
data_exported.filter_type = inputfileloaded.data_exported.filter_type;
data_exported.low_cut_filter = inputfileloaded.data_exported.low_cut_filter;
data_exported.high_cut_filter = inputfileloaded.data_exported.high_cut_filter;
data_exported.order_filter = inputfileloaded.data_exported.order_filter;

try
   
    data_exported.onset_average = inputfileloaded.data_exported.onset_average;
    data_exported.time_average = inputfileloaded.data_exported.time_average;
    
catch
    
end

try

    data_exported.sensors_removed = inputfileloaded.data_exported.labels(sensors_to_remove);
data_exported.chanlocs = inputfileloaded.data_exported.chanlocs;

catch
    
end

   
catch
    
end

mat_file_selected(end-3:end) = [];

save_eeg = [mat_file_selected '_RS_' num2str(length(sensors_removed_names)) '.mat'];
save (save_eeg,'data_exported','-v7.3')

number_removed = length(sensors_removed_names); 
message = ['The following ' num2str(number_removed) ' sensors have been removed:' sensors_removed_names'];

        msgbox(message,'Sensors removed','warn');
   
    number_saved = length(new_sensors_names);    
message_sensors_saved = ['The following ' num2str(number_saved) ' sensors have been saved:' new_sensors_names'];

        msgbox(message_sensors_saved,'Sensors saved','warn');
 
%xlswrite ('Sensors_Removed',sensors_removed_names);
