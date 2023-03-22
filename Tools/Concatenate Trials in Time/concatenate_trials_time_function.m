function concatenate_trials_time_function(Files_Mat_file_directory,Files_Mat_file_selected)

cd(Files_Mat_file_directory)

temp_data = load(Files_Mat_file_selected);

conc_trials_time = zeros(size(temp_data.data_exported.single_trials,1),size(temp_data.data_exported.single_trials,2)*size(temp_data.data_exported.single_trials,3));

start_trial = 1;
end_trial = size(temp_data.data_exported.single_trials,3);

for kk = 1:size(temp_data.data_exported.single_trials,2)
    
    conc_trials_time(:,start_trial:end_trial) = squeeze(temp_data.data_exported.single_trials(:,kk,:));
    
    start_trial = start_trial + size(temp_data.data_exported.single_trials,3);
    end_trial = end_trial + size(temp_data.data_exported.single_trials,3);
    
end
          
          

%% Time domain
figure
time_d = 1000*(0:size(conc_trials_time,2)-1)/temp_data.data_exported.sampling_frequency; 

plot(time_d,conc_trials_time(1,:))
xlabel('\bfTime (ms)')
ylabel('\bfAmplitude (uV)')

axis tight
set(gca,'fontweight','bold');

title(['\bfConcatenated data of channel' temp_data.data_exported.labels(1)])

try 
    
data_exported.eeg_data = []; 
data_exported.trials_samples_extracted = temp_data.data_exported.trials_samples_extracted; 
data_exported.channel_trials = temp_data.data_exported.channel_trials;
data_exported.trigger_used = temp_data.data_exported.trigger_used;
data_exported.average_trials = conc_trials_time;
data_exported.single_trials = temp_data.data_exported.single_trials;
data_exported.pos_single_trials = temp_data.data_exported.pos_single_trials;
data_exported.grand_average_trials = temp_data.data_exported.grand_average_trials;
data_exported.art_threshold = temp_data.data_exported.art_threshold;
data_exported.time_average = (0:size(conc_trials_time,2)-1)/temp_data.data_exported.sampling_frequency;
data_exported.onset_average = temp_data.data_exported.onset_average;
data_exported.channels = temp_data.data_exported.channels;
data_exported.samples = size(conc_trials_time,2);
data_exported.sampling_frequency = temp_data.data_exported.sampling_frequency;
data_exported.trial_duration = size(conc_trials_time,2)/temp_data.data_exported.sampling_frequency;
data_exported.labels = temp_data.data_exported.labels;

try
    
data_exported.sensors_removed = temp_data.data_exported.sensors_removed;

catch
    
end

data_exported.chanlocs = temp_data.data_exported.chanlocs;
data_exported.events_trigger = temp_data.data_exported.events_trigger;
data_exported.events_type = temp_data.data_exported.events_type;

try
data_exported.filter_type = temp_data.data_exported.filter_type;
data_exported.low_cut_filter = temp_data.data_exported.low_cut_filter;

catch
    
end

try
data_exported.high_cut_filter = temp_data.data_exported.high_cut_filter;

catch
    
end

data_exported.order_filter = temp_data.data_exported.order_filter;


catch
    
end   
    

    save_eeg = [Files_Mat_file_selected(1:end-4) '_Conc_Time'];
    
save (save_eeg,'data_exported','-v7.3') %-v7.3 is used to save data > 2Gbytes)

message = (['The concatanation of ' num2str(size(temp_data.data_exported.single_trials,2)) ' trials has been saved']);

        msgbox(message,'The trials have been concatenated','warn');

