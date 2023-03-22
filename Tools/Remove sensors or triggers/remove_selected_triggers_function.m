function remove_selected_triggers_function(mat_file_selected,mat_file_directory,triggers_to_remove);

%% Remove the selected triggers
inputfile = [mat_file_directory '\' mat_file_selected];
inputfileloaded = load(inputfile);

cd(mat_file_directory)

input_file_sensors = inputfileloaded.data_exported.eeg_data;

triggers_removed_code = inputfileloaded.data_exported.events_type(triggers_to_remove);
triggers_removed_latency = inputfileloaded.data_exported.events_trigger(triggers_to_remove);

new_triggers_code_names = inputfileloaded.data_exported.events_type';
new_triggers_code_names(triggers_to_remove,:) = [];

new_triggers_latency = inputfileloaded.data_exported.events_trigger';
new_triggers_latency(triggers_to_remove,:) = [];

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
data_exported.labels = inputfileloaded.data_exported.labels;

try
   
    data_exported.onset_average = inputfileloaded.data_exported.onset_average;
    data_exported.time_average = inputfileloaded.data_exported.time_average;
    
catch
    
end

try

    data_exported.sensors_removed = inputfileloaded.data_exported.labels(triggers_to_remove);

catch
    
end

data_exported.chanlocs = inputfileloaded.data_exported.chanlocs;
data_exported.events_trigger = new_triggers_latency';
data_exported.events_type = new_triggers_code_names';

   
catch
    
end

mat_file_selected(end-3:end) = [];

save_eeg = [mat_file_selected '_RT_' num2str(length(triggers_removed_code)) '.mat'];
save (save_eeg,'data_exported','-v7.3')

number_removed = length(triggers_removed_code);

if iscell(triggers_removed_code)

    triggers_removed_code = str2num(cell2mat(triggers_removed_code));
    
end

message = ['The following ' num2str(number_removed) ' triggers have been removed: ' num2str(triggers_removed_code)];

        msgbox(message,'Triggers removed','warn');
   
    number_saved = length(new_triggers_code_names);    
message_sensors_saved = ['The file has ' num2str(number_saved) ' triggers'];

        msgbox(message_sensors_saved,'Triggers saved','warn');
 
xlswrite ('Triggers_Removed',triggers_removed_code);
