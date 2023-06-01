function Extract_Trials_function_all_electrodes_Fast(Files_Mat_file_selected,Files_Mat_file_directory,Seconds_Before_trigger,...
    Seconds_After_trigger,channels_recorded,channel_selected,trigger_selected,standardized_data,name_file_saved,artifact_neg_electrode,...
    artifact_pos_electrode,adj_trigger_value,max_N_sweeps,eeg_meg_scalp_map,...
         P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS,plot_save_av_chan,plot_save_scalp_map_data,abs_val_peaks)

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

%tt_mean = [Seconds_Before_trigger*sampling_frequency-1:Seconds_After_trigger*sampling_frequency-1]/sampling_frequency - adj_trigger_value - 0.9/1000; 
%-46ms is the adjustment time; 0.9ms keeps into account the delay due to
%the lenght of the tube
tt_mean = [round(Seconds_Before_trigger*sampling_frequency):round(Seconds_After_trigger*sampling_frequency)]/sampling_frequency - round(adj_trigger_value*sampling_frequency)/sampling_frequency;% - 0.9/1000;
tt_raw = [0:size(data_eeg.data_exported.eeg_data(channel_selected,:),2) - 1]/sampling_frequency;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Extracting the trials of all the channels
save_single_trials = zeros(channels,max_N_sweeps,length(tt_mean));
track_sweeps = 1;    
temp_eeg_rejection = [];
position_saved_sweeps_average = [];

display(' ');
for kk = 1:length(triggers_analysis)
display(['Sweep# ' num2str(kk)]);   
    %This "try-catch" is used to avoid the data to go out-of-bound, like in
    %the situation where the recordings have been stopped right after the
    %presentation of the last trigger and this does not allow the recording
    %of enough samples after the onset;
    try
    
    temp_eeg_rejection = data_eeg.data_exported.eeg_data(:,triggers_analysis(kk) + round(Seconds_Before_trigger*sampling_frequency):...
        triggers_analysis(kk) + round(Seconds_After_trigger*sampling_frequency));
         
    if (min(min(temp_eeg_rejection)) > artifact_neg_electrode && max(max(temp_eeg_rejection)) < artifact_pos_electrode)
        
            if (track_sweeps <= max_N_sweeps)
            
        save_single_trials(:,track_sweeps,:) = temp_eeg_rejection;
        track_sweeps = track_sweeps + 1;
        temp_eeg_rejection = [];
            position_saved_sweeps_average = [position_saved_sweeps_average;kk];
            
            end
        end
    
        
    catch
    
         message = 'The time interval exceeds matrix dimension for at least the last trigger recorded. Check that you have enough samples for the analysis after each trigger. Recordings might have been stopped too early and there might not be enough samples after the last trigger for the analysis.';
msgbox(message,'Out of boundary','warn','replace');
        
    end
end

if (track_sweeps - 1 ~= size(save_single_trials,2))
   
    save_single_trials(:,track_sweeps:end,:) = [];
    
end

%% Checking if the length of "time_domain" is the same as the lenght of the average vector
if (length(tt_mean) ~= size(save_single_trials,3))
   
    if (length(tt_mean) > size(save_single_trials,3))
        
        samples_removed = length(tt_mean) - size(save_single_trials,3);
        
        tt_mean(end - samples_removed + 1) = [];
        
    else   
        
        samples_removed = size(save_single_trials,3) - length(tt_mean);
        
                flag_reduce_size_single_trials = 1;
                
    end
    
end    

if length(tt_mean) > round((Seconds_After_trigger - Seconds_Before_trigger)*sampling_frequency)

    tt_mean(:,end - (length(tt_mean) - round((Seconds_After_trigger - Seconds_Before_trigger)*sampling_frequency)) - 1) = [];
    save_single_trials(:,:,end - (length(tt_mean) - round((Seconds_After_trigger - Seconds_Before_trigger)*sampling_frequency)) - 1) = [];
    
elseif length(tt_mean) < round((Seconds_After_trigger - Seconds_Before_trigger)*sampling_frequency)
  
     tt_mean(:,end + (length(tt_mean) - round((Seconds_After_trigger - Seconds_Before_trigger)*sampling_frequency))) = (length(tt_mean) + 1)./sampling_frequency;
    save_single_trials(:,:,end + (length(tt_mean) - round((Seconds_After_trigger - Seconds_Before_trigger)*sampling_frequency))) = 0;
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

find_onset = find(tt_mean >= 0,1,'First');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting and saving all the channels
if (plot_save_av_chan == 1 && size(save_single_trials,2) > 0)
    
for ll = 1:size(save_single_trials,1)
   
    figure
    subplot(2,1,1)
    
    if(size(save_single_trials,2) > 1)
        
    plot(1000*tt_mean,mean(squeeze(save_single_trials(ll,:,:))))
    
    else
       
        plot(1000*tt_mean,squeeze(save_single_trials(ll,:,:)))
        
    end
    
    hold on
   
    if(size(save_single_trials,2) > 1)
        
     plot([tt_mean(find_onset) tt_mean(find_onset)],[min(mean(squeeze(save_single_trials(ll,:,:)))) max(mean(squeeze(save_single_trials(ll,:,:))))],'Color','k','LineWidth',1); 

    else
       
       plot([tt_mean(find_onset) tt_mean(find_onset)],[min(squeeze(save_single_trials(ll,:,:))) max(squeeze(save_single_trials(ll,:,:)))],'Color','k','LineWidth',1);  
        
    end
     
  hold off

  axis tight

title(['\bfNumber of trials averaged: ' num2str(size(save_single_trials,2))  ' - for channel - ' cell2mat(channels_recorded(ll))])
    xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude (uV)')

    subplot(2,1,2)
    plot(1000*tt_raw,data_eeg.data_exported.eeg_data(ll,:))
    axis tight

title(['\bfRaw data of channel - ' cell2mat(channels_recorded(ll))])
    xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude (uV)')
    
    if (standardized_data == 1)
    
    saveas(gcf,[name_file_saved '_' num2str(size(save_single_trials,2)) '_' cell2mat(channels_recorded(ll)) '_Trigg_' num2str(trigger_selected) '_Standardized.fig'])
    
    else
    
     saveas(gcf,[name_file_saved '_' num2str(size(save_single_trials,2)) '_' cell2mat(channels_recorded(ll)) '_Trigg_' num2str(trigger_selected) '_Non_Standardized.fig'])
            
    end
    
    pause(0.05)
 fig_prop = get(gcf);
close(fig_prop.Number);
    
end

end

%% Checking if all the sweeps have been rejected
if (isempty(save_single_trials))
    
    close(gcf)

    message = ('All the sweeps have been rejected. Change the artifact rejection threshold if you want to accept at least one sweep');
        msgbox(message,'Operation terminated','warn');
    
    return;

end

    
if (flag_reduce_size_single_trials == 1)
   
    save_single_trials(:,:,end) = [];
    
end


if (standardized_data == 1)
    
    save_eeg_folder = [name_file_saved '_Average_Trials_' num2str(size(save_single_trials,2)) '_Trigg_' num2str(trigger_selected) '_Standardized.mat'];

try
data_exported.eeg_data = []; 
data_exported.trials_samples_extracted = {size(save_single_trials,2) size(save_single_trials,3)}; 
data_exported.channel_trials = channels_recorded;
data_exported.trigger_used = trigger_selected;
data_exported.average_trials = squeeze(mean(save_single_trials,2));
%If only 1 channel is present, transpose the average to have the samples
%organized in columns
if(size(save_single_trials,1) < 2)
   
    data_exported.average_trials = data_exported.average_trials';
    
end
data_exported.single_trials = save_single_trials;
data_exported.pos_single_trials = position_saved_sweeps_average';
%Compute the grand-average across sensors only if there are more 
%than 1 channel
if(size(save_single_trials,1) > 1)
    
    data_exported.grand_average_trials = mean(squeeze(mean(save_single_trials,2)));
    
else
    
    data_exported.grand_average_trials = squeeze(mean(save_single_trials,2))';
        
end
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

data_exported.events_trigger = data_eeg.data_exported.events_trigger;
data_exported.events_type = data_eeg.data_exported.events_type;

try

data_exported.filter_type = data_eeg.data_exported.filter_type;
data_exported.low_cut_filter = data_eeg.data_exported.low_cut_filter;

catch
    
end

try
   
    data_exported.notch_filter = data_eeg.data_exported.notch_filter;
    
catch
    
end

try
data_exported.high_cut_filter = data_eeg.data_exported.high_cut_filter;

catch
    
end

data_exported.order_filter = data_eeg.data_exported.order_filter;
data_exported.chanlocs = data_eeg.data_exported.chanlocs;

catch
    
end

else
    
    save_eeg_folder = [name_file_saved '_Average_Trials_' num2str(size(save_single_trials,2)) '_Trigg_' num2str(trigger_selected) '.mat'];

 try
     
data_exported.eeg_data = []; 
data_exported.trials_samples_extracted = {size(save_single_trials,2) size(save_single_trials,3)}; 
data_exported.channel_trials = channels_recorded;
data_exported.trigger_used = trigger_selected;
data_exported.average_trials = squeeze(mean(save_single_trials,2));
%If only 1 channel is present, transpose the average to have the samples
%organized in columns
if(size(save_single_trials,1) < 2)
   
    data_exported.average_trials = data_exported.average_trials';
    
end
data_exported.single_trials = save_single_trials;
data_exported.pos_single_trials = position_saved_sweeps_average';
%Compute the grand-average across sensors only if there are more 
%than 1 channel
if(size(save_single_trials,1) > 1)
    
    data_exported.grand_average_trials = mean(squeeze(mean(save_single_trials,2)));
    
else
    
    data_exported.grand_average_trials = squeeze(mean(save_single_trials,2))';
        
end

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
data_exported.chanlocs = data_eeg.data_exported.chanlocs;

catch
    
end   
    
end 

save (save_eeg_folder,'data_exported','-v7.3')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Extract the peaks
try
    
if (eeg_meg_scalp_map == 1)
    
extract_peaks_RMS_Biosemi(data_exported.average_trials,tt_mean,channels,standardized_data,name_file_saved,data_eeg.data_exported.sampling_frequency,...
        P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS,data_exported.labels,abs_val_peaks)

else
   
    extract_peaks_RMS_MEG(data_exported.average_trials,tt_mean,channels,standardized_data,name_file_saved,data_eeg.data_exported.sampling_frequency,...
        P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS,data_eeg.data_exported.labels,abs_val_peaks)
    
end

catch
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Creating the scalpmaps
if (plot_save_scalp_map_data == 1)

    message = 'All the Epochs have been extracted. Scalp map analysis is in progress...';
msgbox(message,'End of the first part of the analysis','warn','replace');

try    
%% Creating the scalpmap for up to 3 peaks selected by the users. It usually is P1 (M50), N1 (M100) and P2 (M200)
try
channels_names = data_exported.labels;
if (eeg_meg_scalp_map == 1)

    scalp_map_Biosemi(data_exported.average_trials,tt_mean,channels,standardized_data,name_file_saved,data_eeg.data_exported.sampling_frequency,...
        P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS,channels_names,abs_val_peaks)

else
    
    scalp_map_MEG(data_exported.average_trials,tt_mean,channels,standardized_data,name_file_saved,data_eeg.data_exported.sampling_frequency,...
        P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS,data_eeg.data_exported.labels,abs_val_peaks)

end

catch
    
end

catch
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

else
   
    message = 'All the Epochs have been extracted. End of the analysis';    
    
end

