function Extract_Trials_function_all_electrodes(Files_Mat_file_selected,Files_Mat_file_directory,Seconds_Before_trigger,...
    Seconds_After_trigger,channels_recorded,channel_selected,trigger_selected,standardized_data,name_file_saved,artifact_neg_electrode,...
    artifact_pos_electrode,adj_trigger_value,max_N_sweeps,eeg_meg_scalp_map,...
         P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS);

cd(Files_Mat_file_directory)

data_eeg = load(Files_Mat_file_selected);
sampling_frequency = data_eeg.data_exported.sampling_frequency;

[channels samples] = size(data_eeg.data_exported.eeg_data);

triggers = data_eeg.data_exported.events_trigger;

position_saved_sweeps_average = [];

flag_reduce_size_single_trials = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Finding the triggers to use
trigger_to_use = 0;

try

    for kkk = 1:length(data_eeg.data_exported.events_trigger)
    
    if (data_eeg.data_exported.events_type(kkk) == trigger_selected)
    
        trigger_to_use = trigger_to_use + 1;
        
    end

end
    
catch
    
for kkk = 1:length(data_eeg.data_exported.events_trigger)
    
    if strcmp(data_eeg.data_exported.events_type(kkk),trigger_selected)
    
        trigger_to_use = trigger_to_use + 1;
        
    end

end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extracting the position of each trigger
triggers_analysis = zeros(1,trigger_to_use);
position_triggers = 1;
for kkk = 1:length(data_eeg.data_exported.events_trigger)

    try
    
    if (data_eeg.data_exported.events_type(kkk)== trigger_selected) 
    
        
        triggers_analysis(1,position_triggers) = triggers(kkk);
        position_triggers = position_triggers + 1;
    end

    catch
        
        if strcmp(data_eeg.data_exported.events_type(kkk),trigger_selected) 
        
        triggers_analysis(1,position_triggers) = triggers(kkk);
        position_triggers = position_triggers + 1;
    
        end
    
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%mean_save_eeg_plot = zeros(channels,length(round(Seconds_Before_trigger*sampling_frequency):round(Seconds_After_trigger*sampling_frequency)));

for ttt = 1:channels

    channel_selected = ttt
%% Extracting the trials of all the channels
save_eeg = [];

for kk = 1:length(triggers_analysis)
 
    %This "try-catch" is used to avoid the data to go out-of-bound, like in
    %the situation where the recordings have been stopped right after the
    %presentation of the last trigger and this does not allow the recording
    %of enough samples after the onset;
    try
    
    temp_eeg_rejection = data_eeg.data_exported.eeg_data(:,triggers_analysis(kk) + round(Seconds_Before_trigger*sampling_frequency):...
        triggers_analysis(kk) + round(Seconds_After_trigger*sampling_frequency));
    
    temp_eeg = data_eeg.data_exported.eeg_data(channel_selected,triggers_analysis(kk) + round(Seconds_Before_trigger*sampling_frequency):...
        triggers_analysis(kk) + round(Seconds_After_trigger*sampling_frequency));
         
    if (min(min(temp_eeg_rejection)) > artifact_neg_electrode && max(max(temp_eeg_rejection)) < artifact_pos_electrode)
        
            if (size(save_eeg,1) < max_N_sweeps)
            
        save_eeg = [save_eeg;temp_eeg];
        
        if (ttt == 1)
        
    position_saved_sweeps_average = [position_saved_sweeps_average;kk];
    
        end
    
            end
        end
    
        
    catch
    
         message = 'The time interval exceeds matrix dimension for at least the last trigger recorded. Check that you have enough samples for the analysis after each trigger. Recordings might have been stopped too early and there might not be enough samples after the last trigger for the analysis.';
msgbox(message,'Out of boundary','warn','replace');
        
    end
end

if (size(save_eeg,1) > 1)
    
    mean_average_plot = mean(save_eeg);
    
else

    mean_average_plot = save_eeg;
    
end

if (ttt == 1)
       
    save_single_trials = zeros(length(channels),size(save_eeg,1),size(mean_average_plot,2));
    
end

save_single_trials(ttt,:,:) = save_eeg;

%tt_mean = [Seconds_Before_trigger*sampling_frequency-1:Seconds_After_trigger*sampling_frequency-1]/sampling_frequency - adj_trigger_value - 0.9/1000; 
%-46ms is the adjustment time; 0.9ms keeps into account the delay due to
%the lenght of the tube
tt_mean = [Seconds_Before_trigger*sampling_frequency:Seconds_After_trigger*sampling_frequency]/sampling_frequency - adj_trigger_value - 0.9/1000;
tt_raw = [0:size(data_eeg.data_exported.eeg_data(channel_selected,:),2) - 1]/sampling_frequency;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Checking if the length of "time_domain" is the same as the lenght of the average vector
if (length(tt_mean) ~= length(mean_average_plot))
   
    if (length(tt_mean) > length(mean_average_plot))
        
        samples_removed = length(tt_mean) - length(mean_average_plot);
        
        tt_mean(end - samples_removed + 1) = [];
        
    else   
        
        samples_removed = length(mean_average_plot) - length(tt_mean);
        
        mean_average_plot(:,end - samples_removed + 1) = [];
                %mean_save_eeg_plot (:,end - samples_removed + 1) = [];
                flag_reduce_size_single_trials = 1;
                
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

find_onset = find(tt_mean >= 0,1,'First');

%% Checking if all the sweeps have been rejected
if (isempty(mean_average_plot))
    
    message = ('All the sweeps have been rejected. Change the artifact rejection threshold if you want to accept at least one sweep');
        msgbox(message,'Operation terminated','warn');
    
    return;

end


figure

subplot(2,1,1)
if (standardized_data == 1)

    mean_save_eeg_plot(ttt,:) = mapstd(mean_average_plot);  
    
else
    
    mean_save_eeg_plot(ttt,:) = mean_average_plot;
    
end

plot(1000*tt_mean,mean_save_eeg_plot(ttt,:))

try
    
hold on
   
      %line(tt_mean(find_onset),[min(mean_save_eeg_plot(ttt,:)):0.1:max(mean_save_eeg_plot(ttt,:))],'Color','k','LineWidth',32); 
  
      plot([tt_mean(find_onset) tt_mean(find_onset)],[min(mean_save_eeg_plot(ttt,:)) max(mean_save_eeg_plot(ttt,:))],'Color','k','LineWidth',1); 

  hold off

catch
    
end

axis tight

title(['\bfNumber of trials averaged: ' num2str(size(save_eeg,1))  ' - for channel - ' cell2mat(channels_recorded(channel_selected))])
    xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude (uV)')

    subplot(2,1,2)
    plot(tt_raw,data_eeg.data_exported.eeg_data(channel_selected,:))
    axis tight

title(['\bfRaw data of channel - ' cell2mat(channels_recorded(channel_selected))])
    xlabel('\bfTime (s)')
    ylabel('\bfAmplitude (uV)')
    
    if (standardized_data == 1)
    
    saveas(gcf,[name_file_saved '_' num2str(size(save_eeg,1)) '_' cell2mat(channels_recorded(channel_selected)) '_Standardized.fig'])
    
    else
    
     saveas(gcf,[name_file_saved '_' num2str(size(save_eeg,1)) '_' cell2mat(channels_recorded(channel_selected)) '_Non_Standardized.fig'])
            
    end
    
    pause(0.1)
 fig_prop = get(gcf);
close(fig_prop.Number);


end   
    
if (flag_reduce_size_single_trials == 1)
   
    save_single_trials(:,:,end) = [];
    
end

if (standardized_data == 1)
    
    save_eeg_folder = [name_file_saved '_Average_Trials_' num2str(size(save_eeg,1)) '_Standardized.mat'];

try
data_exported.eeg_data = []; 
data_exported.trials_samples_extracted = {size(save_eeg,1) size(save_eeg,1)}; 
data_exported.channel_trials = channels_recorded;
data_exported.trigger_used = trigger_selected;
data_exported.average_trials = mean_save_eeg_plot;
data_exported.single_trials = save_single_trials;
data_exported.pos_single_trials = position_saved_sweeps_average';
data_exported.grand_average_trials = mean(mean_save_eeg_plot);
data_exported.art_threshold = {artifact_pos_electrode artifact_pos_electrode};
data_exported.time_average = tt_mean;
data_exported.onset_average = tt_mean(find_onset);
data_exported.channels = data_eeg.data_exported.channels;
data_exported.samples = data_eeg.data_exported.samples;
data_exported.sampling_frequency = data_eeg.data_exported.sampling_frequency;
data_exported.trial_duration = data_eeg.data_exported.samples/data_eeg.data_exported.sampling_frequency;
data_exported.labels = data_eeg.data_exported.labels;

try
    
data_exported.sensors_removed = data_eeg.data_exported.sensors_removed;

catch
    
end

data_exported.chanlocs = data_eeg.data_exported.chanlocs;
data_exported.events_trigger = data_eeg.data_exported.events_trigger;
data_exported.events_type = data_eeg.data_exported.events_type;

try

data_exported.filter_type = data_eeg.data_exported.filter_type;
data_exported.low_cut_filter = data_eeg.data_exported.low_cut_filter;

catch
    
end

try
   
    data_exported.notch_filter = data_eeg.data_exported.notch_filter;
    
end

try
data_exported.high_cut_filter = data_eeg.data_exported.high_cut_filter;

catch
    
end

data_exported.order_filter = data_eeg.data_exported.order_filter;


catch
    
end

else
    
    save_eeg_folder = [name_file_saved '_Average_Trials_' num2str(size(save_eeg,1)) '.mat'];

 try
data_exported.eeg_data = []; 
data_exported.trials_samples_extracted = {size(save_eeg,1) size(save_eeg,2)}; 
data_exported.channel_trials = channels_recorded;
data_exported.trigger_used = trigger_selected;
data_exported.average_trials = mean_save_eeg_plot;
data_exported.single_trials = save_single_trials;
data_exported.pos_single_trials = position_saved_sweeps_average';
data_exported.grand_average_trials = mean(mean_save_eeg_plot);
data_exported.art_threshold = {artifact_neg_electrode artifact_pos_electrode};
data_exported.time_average = tt_mean;
data_exported.onset_average = tt_mean(find_onset);
data_exported.channels = data_eeg.data_exported.channels;
data_exported.samples = data_eeg.data_exported.samples;
data_exported.sampling_frequency = data_eeg.data_exported.sampling_frequency;
data_exported.trial_duration = data_eeg.data_exported.samples/data_eeg.data_exported.sampling_frequency;
data_exported.labels = data_eeg.data_exported.labels;

try
    
data_exported.sensors_removed = data_eeg.data_exported.sensors_removed;

catch
    
end

data_exported.chanlocs = data_eeg.data_exported.chanlocs;
data_exported.events_trigger = data_eeg.data_exported.events_trigger;
data_exported.events_type = data_eeg.data_exported.events_type;

try
data_exported.filter_type = data_eeg.data_exported.filter_type;
data_exported.low_cut_filter = data_eeg.data_exported.low_cut_filter;

catch
    
end

try
data_exported.high_cut_filter = data_eeg.data_exported.high_cut_filter;

catch
    
end

data_exported.order_filter = data_eeg.data_exported.order_filter;


catch
    
end   
    
end 

save (save_eeg_folder,'data_exported','-v7.3')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the average of the "N" channels, if more than one channel has been analyzed
if(size(mean_save_eeg_plot,1) > 1)
    
figure
plot(1000*tt_mean,mean(mean_save_eeg_plot(:,:)))

try
    
hold on
   
      plot([tt_mean(find_onset) tt_mean(find_onset)],[min(mean(mean_save_eeg_plot(:,:))) max(mean(mean_save_eeg_plot(:,:)))],'Color','k','LineWidth',1); 
    
hold off

catch
    
end

axis tight

title(['\bfNumber of trials averaged: ' num2str(size(save_eeg,1))  ' - for the average of all the channels'])
    xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude (uV)')

if (standardized_data == 1)
    
    saveas(gcf,[name_file_saved '_Average_Trials_' num2str(size(save_eeg,1)) '_Standardized.fig'])

    else
    
        saveas(gcf,[name_file_saved '_Average_Trials_' num2str(size(save_eeg,1)) '_Non_Standardized.fig'])
    
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

message = 'All the Epochs have been extracted. Scalp map analysis is in progress...';
msgbox(message,'End of the first part of the analysis','warn','replace');

try    
%% Creating the scalpmap for the P100, N100 and P200 peaks
if (eeg_meg_scalp_map == 1)

    scalp_map_Biosemi(data_exported.sensors_removed,data_exported.average_trials,tt_mean,channels,standardized_data,name_file_saved,data_eeg.data_exported.sampling_frequency,...
        P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS)

else
    
    scalp_map_MEG(data_exported.sensors_removed,data_exported.average_trials,tt_mean,channels,standardized_data,name_file_saved,data_eeg.data_exported.sampling_frequency)

end

catch
    
end

