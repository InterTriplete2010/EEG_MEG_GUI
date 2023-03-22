function Extract_portion_signal_function_COGMO(mat_file_selected,mat_file_directory,time_window_signal,table_tag);

inputfile = [mat_file_directory '\' mat_file_selected];
inputfileloaded = load(inputfile);

cd(mat_file_directory)

input_file_sensors = inputfileloaded.data_exported.eeg_data;

if time_window_signal(1) == 0
   
    time_window_signal(1) = 1/inputfileloaded.data_exported.sampling_frequency;
    
end

if round(time_window_signal(2)*inputfileloaded.data_exported.sampling_frequency) > size(inputfileloaded.data_exported.eeg_data,2)
   
    time_window_signal(2) = size(inputfileloaded.data_exported.eeg_data,2)/inputfileloaded.data_exported.sampling_frequency;
    
end

signal_extracted = input_file_sensors(:,round(time_window_signal(1)*inputfileloaded.data_exported.sampling_frequency):round(time_window_signal(2)*inputfileloaded.data_exported.sampling_frequency));

%Removing the triggers that don't belong to the time window
triggers_to_remove = find(inputfileloaded.data_exported.events_trigger < round(time_window_signal(1)*inputfileloaded.data_exported.sampling_frequency));
inputfileloaded.data_exported.events_trigger(triggers_to_remove) = [];
inputfileloaded.data_exported.events_type(triggers_to_remove) = [];


triggers_to_remove = find(inputfileloaded.data_exported.events_trigger > round(time_window_signal(2)*inputfileloaded.data_exported.sampling_frequency));
inputfileloaded.data_exported.events_trigger(triggers_to_remove) = [];
inputfileloaded.data_exported.events_type(triggers_to_remove) = [];

%Updating the table
save_info_update(:,1) = inputfileloaded.data_exported.events_type;

[matrix_count_triggers] = count_triggers_COGMO(save_info_update(:,1));

try

save_info_update(:,2) = matrix_count_triggers;
save_info_update(:,3) = inputfileloaded.data_exported.events_trigger/inputfileloaded.data_exported.sampling_frequency;
save_info_update(:,4) = inputfileloaded.data_exported.events_trigger/inputfileloaded.data_exported.sampling_frequency/60;

catch
   
    save_info_update(:,2) = matrix_count_triggers;
    
    for ppp = 1:length(inputfileloaded.data_exported.events_trigger)
        
    save_info_update(ppp,3) = {inputfileloaded.data_exported.events_trigger(ppp)/inputfileloaded.data_exported.sampling_frequency};
    save_info_update(ppp,4) = {inputfileloaded.data_exported.events_trigger(ppp)/inputfileloaded.data_exported.sampling_frequency/60};
    
    end

end

set(table_tag,'Data',save_info_update);
set(table_tag,'columnname',{'Code';'Count Triggers';'Time (s)';'Time (m)'});

%Recalculate the position of the triggers based on the window extracted
inputfileloaded.data_exported.events_trigger = inputfileloaded.data_exported.events_trigger - round(time_window_signal(1)*inputfileloaded.data_exported.sampling_frequency) + 1;

try
data_exported.eeg_data = signal_extracted; 
data_exported.channels = size(signal_extracted,1);
data_exported.samples = size(signal_extracted,2);
data_exported.time = (0:size(signal_extracted,2) - 1)/inputfileloaded.data_exported.sampling_frequency;
data_exported.sampling_frequency = inputfileloaded.data_exported.sampling_frequency;
data_exported.trial_duration = (size(signal_extracted,2) - 1)/inputfileloaded.data_exported.sampling_frequency;
data_exported.labels = inputfileloaded.data_exported.labels;
data_exported.chanlocs = inputfileloaded.data_exported.chanlocs;
data_exported.events_trigger = inputfileloaded.data_exported.events_trigger;
data_exported.events_type = inputfileloaded.data_exported.events_type;

   
catch
    
end

mat_file_selected(end-3:end) = [];

save_eeg = [mat_file_selected '_Window_' num2str(time_window_signal(1)) '_' num2str(time_window_signal(2)) '.mat'];
save (save_eeg,'data_exported')

message = 'The portion of the signal has been extracted and saved';

        msgbox(message,'Signal extracted','warn');