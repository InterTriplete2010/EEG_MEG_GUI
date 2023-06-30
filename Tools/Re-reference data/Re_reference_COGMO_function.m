function Re_reference_COGMO_function(mat_file_eeg_re_reference,mat_file_directory_re_reference,load_eeg,channels_recorded,channel_selected_pos,common_av,ears_mastoids_av,single_channel,add_old_reference_check,name_old_reference);

eeg_data = load_eeg.data_exported.eeg_data;

if (common_av == 1)

    new_ref = mean(eeg_data(:,:));
    mat_file_eeg_re_reference(end-3:end) = [];
save_eeg = [mat_file_eeg_re_reference '_Re_referenced_Common_Average.mat'];

end
   
if (ears_mastoids_av == 1)
    
    new_ref = eeg_data(channel_selected_pos,:)/2;
    mat_file_eeg_re_reference(end-3:end) = [];
save_eeg = cell2mat([mat_file_eeg_re_reference '_Re_referenced_Average_Ears_Mastoids_' channels_recorded(channel_selected_pos) '.' 'mat']);

end

if (single_channel == 1)
    
    new_ref = eeg_data(channel_selected_pos,:);
    mat_file_eeg_re_reference(end-3:end) = [];
save_eeg = cell2mat([mat_file_eeg_re_reference '_Re_referenced_' channels_recorded(channel_selected_pos) '.' 'mat']);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
new_vector = [];
for kk = 1:size(eeg_data,1)
    
temp_ref = eeg_data(kk,:);
temp_ref_vect = temp_ref - new_ref;
new_vector = [new_vector;temp_ref_vect];

end

%Check if the old reference has to be added to the data
if (add_old_reference_check == 1) && (common_av == 1 || single_channel == 1)
    
   new_vector = [new_vector;-new_ref]; 
    
    %length(load_eeg.data_exported.labels);
    
    load_eeg.data_exported.labels(length(load_eeg.data_exported.labels) + 1) = {name_old_reference};
   
end

try

data_exported.eeg_data = new_vector; 
data_exported.channels = size(load_eeg.data_exported,1);
data_exported.samples = load_eeg.data_exported.samples;
data_exported.sampling_frequency = load_eeg.data_exported.sampling_frequency;
data_exported.trial_duration = load_eeg.data_exported.trial_duration;

try
    
    data_exported.time = load_eeg.data_exported.time;
    
catch
    
    data_exported.time = load_eeg.data_exported.time_average;
    
end

data_exported.labels = load_eeg.data_exported.labels;
data_exported.events_trigger = load_eeg.data_exported.events_trigger;
data_exported.events_type = load_eeg.data_exported.events_type;
data_exported.chanlocs = load_eeg.data_exported.chanlocs;

catch
    
end

save (save_eeg,'data_exported')

message = 'EEGs have been re-referenced and saved';

        msgbox(message,'Re-referencing','warn');
