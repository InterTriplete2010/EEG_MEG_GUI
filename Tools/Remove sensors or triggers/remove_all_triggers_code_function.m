function remove_all_triggers_code_function(mat_file_selected,mat_file_directory,triggers_to_remove_code);

%% Remove the selected triggers
inputfile = [mat_file_directory '\' mat_file_selected];
inputfileloaded = load(inputfile);

cd(mat_file_directory)

input_file_sensors = inputfileloaded.data_exported.eeg_data;
find_trigger_pos = [];

for gg = 1:length(triggers_to_remove_code)
temp_trigg_code = [];

     temp_trigg_code = find(triggers_to_remove_code(gg) == inputfileloaded.data_exported.events_type);

     find_trigger_pos(length(find_trigger_pos) + 1:length(temp_trigg_code) + length(find_trigger_pos),1) = temp_trigg_code;
     
end

new_triggers_code_names = inputfileloaded.data_exported.events_type';
new_triggers_code_names(find_trigger_pos,:) = [];

new_triggers_latency = inputfileloaded.data_exported.events_trigger';
new_triggers_latency(find_trigger_pos,:) = [];

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

    data_exported.sensors_removed = inputfileloaded.data_exported.labels(triggers_to_remove_code);

catch
    
end

data_exported.chanlocs = inputfileloaded.data_exported.chanlocs;
data_exported.events_trigger = new_triggers_latency';
data_exported.events_type = new_triggers_code_names';

   
catch
    
end

mat_file_selected(end-3:end) = [];

save_eeg = [mat_file_selected '_R_ALL_T_' num2str(length(find_trigger_pos)) '.mat'];
save (save_eeg,'data_exported')

number_removed = length(find_trigger_pos); 
message = ['All the triggers with the following codes ' num2str(triggers_to_remove_code') ' have been removed'];

        msgbox(message,'Triggers removed','warn');
   
    number_saved = length(new_triggers_code_names);    
message_sensors_saved = ['The file has ' num2str(number_saved) ' triggers'];

        msgbox(message_sensors_saved,'Triggers saved','warn');
 
xlswrite ('Triggers_Removed',triggers_to_remove_code');