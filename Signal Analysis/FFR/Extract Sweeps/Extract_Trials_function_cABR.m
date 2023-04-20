function Extract_Trials_function_cABR(Files_Mat_file_selected,Files_Mat_file_directory,Seconds_Before_trigger,...
    First_sample_after_trigger,Seconds_After_trigger,channels_recorded,channel_selected,trigger_selected, trigger_selected_next, ...
    standardized_data,name_file_saved,artifact_neg_electrode,artifact_pos_electrode,...
    lf_filter,hf_filter,order_filter,filter_phase,minimum_threshold_peaks,minimum_distance_peaks,norm_factor,adj_trigger_value,max_trials, ...
    First_sample_transient_region,First_sample_ss_region,Last_sample_ss_region,...
    First_sample_off_set_region,Last_sample_off_set_region,...
    window_fft_val_whole,overlap_fft_val_whole,nfft_fft_val_whole,...
    window_fft_val_trans,overlap_fft_val_trans,nfft_fft_val_trans,...
    window_fft_val_ss,overlap_fft_val_ss,nfft_fft_val_ss,...
    window_fft_val_off,overlap_fft_val_off,nfft_fft_val_off)
            

%Matrix used to save the RMS values
%First row: envelope; Second row: TFS
%Column 1: Noise; Column 2: Entire response; Column 3: Transient response;
%Column 4: SS response; Column 5: off-response;
save_rms_values_areas = zeros(2,5);

cd(Files_Mat_file_directory)

data_eeg = load(Files_Mat_file_selected);
sampling_frequency = data_eeg.data_exported.sampling_frequency;

window_fft_val_whole = round(window_fft_val_whole*sampling_frequency);
overlap_fft_val_whole = round(overlap_fft_val_whole*sampling_frequency);
nfft_fft_val_whole = round(nfft_fft_val_whole*sampling_frequency);
window_fft_val_trans = round(window_fft_val_trans*sampling_frequency);
overlap_fft_val_trans = round(overlap_fft_val_trans*sampling_frequency);
nfft_fft_val_trans = round(nfft_fft_val_trans*sampling_frequency);
window_fft_val_ss = round(window_fft_val_ss*sampling_frequency);
overlap_fft_val_ss = round(overlap_fft_val_ss*sampling_frequency);
nfft_fft_val_ss = round(nfft_fft_val_ss*sampling_frequency);
window_fft_val_off = round(window_fft_val_off*sampling_frequency);
overlap_fft_val_off = round(overlap_fft_val_off*sampling_frequency);
nfft_fft_val_off = round(nfft_fft_val_off*sampling_frequency);

[channels samples] = size(data_eeg.data_exported.eeg_data);

triggers = data_eeg.data_exported.events_trigger;

%Building the transfer function for the filter
[b,a] = butter(order_filter,[lf_filter hf_filter]/(data_eeg.data_exported.sampling_frequency/2));

fvtool(b,a)
check_stability(b,a)

%% Extracting the triggers to use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

triggers_analysis = zeros(2,trigger_to_use);
position_triggers_rar = 1;
position_triggers_compr = 1;

for kkk = 1:length(data_eeg.data_exported.events_trigger)

    try
    
    if (data_eeg.data_exported.events_type(kkk) == trigger_selected) 
    
        
        triggers_analysis(1,position_triggers_rar) = triggers(kkk);
        position_triggers_rar = position_triggers_rar + 1;
        
    elseif (data_eeg.data_exported.events_type(kkk) == trigger_selected_next)
        
        triggers_analysis(2,position_triggers_compr) = triggers(kkk);
        position_triggers_compr = position_triggers_compr + 1;
        
    end

    catch
        
        if strcmp(data_eeg.data_exported.events_type(kkk),trigger_selected) 
        
        triggers_analysis(1,position_triggers_rar) = triggers(kkk);
        position_triggers_rar = position_triggers_rar + 1;
        
        elseif strcmp(data_eeg.data_exported.events_type(kkk),trigger_selected_next) 
        
        triggers_analysis(2,position_triggers_compr) = triggers(kkk);
        position_triggers_compr = position_triggers_compr + 1;
        
    end
    
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Removing the extra trigger, if the numbers of rar and comp triggers are not identical
if (mod(length(triggers),2) ~= 0)
   
    triggers_analysis(:,end) = [];
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Filtering the data and extracting the sweeps of all the channels
if (filter_phase == 1)
    
    eeg_data_filtered = filtfilt(b,a,data_eeg.data_exported.eeg_data(channel_selected,:));
    
else
    
    eeg_data_filtered = filter(b,a,data_eeg.data_exported.eeg_data(channel_selected,:));
    
end
%eeg_data_filtered = data_eeg.data_exported.eeg_data(channel_selected,:);

try
save_eeg_rar = [];
save_eeg_compr = [];

count_sweeps_rejected = zeros(2,1);

%Keeping track of how many sweeps have been saved per polarity
sweeps_compr = 0;
sweeps_rar = 0;

sweeps_rej_compr = 0;
sweeps_rej_rar = 0;

%% Staring the extraction of the sweeps
for kk = 1:size(triggers_analysis,2)
    
    try
     
    %% Analysis for the rarefraction
    temp_eeg_rar = eeg_data_filtered(1,round(triggers_analysis(1,kk) + Seconds_Before_trigger*sampling_frequency):round(triggers_analysis(1,kk) + Last_sample_off_set_region*sampling_frequency));
    
    if (min(temp_eeg_rar) > artifact_neg_electrode && max(temp_eeg_rar) < artifact_pos_electrode && sweeps_rar < max_trials)
        
        save_eeg_rar = [save_eeg_rar;temp_eeg_rar];
    
        sweeps_rar = sweeps_rar + 1;
        
        elseif(sweeps_rar < max_trials)
            
            sweeps_rej_rar = sweeps_rej_rar + 1;
        
        end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This part of the code will be executed only if two different triggers were detected   
    %% Analysis for the compression
    try
    temp_eeg_compr = eeg_data_filtered(1,round(triggers_analysis(2,kk) + Seconds_Before_trigger*sampling_frequency):round(triggers_analysis(2,kk) + Last_sample_off_set_region*sampling_frequency));
        
    if (min(temp_eeg_compr) > artifact_neg_electrode && max(temp_eeg_compr) < artifact_pos_electrode && sweeps_compr < max_trials)
        
        save_eeg_compr = [save_eeg_compr;temp_eeg_compr];
    
        sweeps_compr = sweeps_compr + 1;
        
        elseif(sweeps_compr < max_trials)
            
            sweeps_rej_compr = sweeps_rej_compr + 1;
        
    end
    
    catch
        
    end
    
    catch
      
        message = ['The time interval exceeds matrix dimension for at least the last trigger recorded. Check that you have enough samples for the analysis' ...
        'after each trigger. Recordings might have been stopped too early and there might not be enough samples after the last trigger for the analysis.', ...
        'Check also for phantom triggers that could have caused the correct sequence of triggers to be disrupted. This would caused some trigger latency', ...
        'to be set to set to zero causing a negative value to be read by the data vector.'];
msgbox(message,'Out of boundary','warn','replace');
        
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
end

catch

     message = 'The time interval exceeds matrix dimension';
msgbox(message,'Out of boundary','warn','replace');
    return;
    
end

%% Counting how many sweeps have been rejected 
count_sweeps_rejected(1,1) = sweeps_rej_rar;
count_sweeps_rejected(2,1) = sweeps_rej_compr;

    eeg_sweeps = [save_eeg_rar;save_eeg_compr];

%% If all the sweeps have been rejected or only one has been saved, terminate the analysis    
    if (isempty(eeg_sweeps) || size(eeg_sweeps,1) == 1)
       
        message = 'All the sweeps have been rejected. Data are too noisy or the rejection threshold is too low.';
msgbox(message,'No average was calculated.','warn','replace');
        
return;
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%% Averaging the rar and compr sweeps. Checking whether one or two triggers were detected    
    av_rar = mean(save_eeg_rar);
    av_compr = mean(save_eeg_compr);
    
    %mean_average_plot = mean(eeg_sweeps);
    if (~isnan(av_compr))
    
        mean_average_plot = (av_rar + av_compr)/2;
    
    else
            
        mean_average_plot = av_rar;
        
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %time_domain = [Seconds_Before_trigger*sampling_frequency + 1:Seconds_After_trigger*sampling_frequency]/sampling_frequency + (adj_trigger_value + 1/sampling_frequency);
if (adj_trigger_value ~= 0)
    %time_domain = [Seconds_Before_trigger*sampling_frequency - 1:size(eeg_sweeps,2) - 2]/sampling_frequency + adj_trigger_value - 0.9/1000;
%time_domain = [-1:size(eeg_sweeps,2) - 2]/sampling_frequency + adj_trigger_value - 0.9/1000 + Seconds_Before_trigger;
    %0.9ms have been introduced to account for the delay of the ear-phone

    %time_domain = [0:size(eeg_sweeps,2) - 1]/sampling_frequency + adj_trigger_value + Seconds_Before_trigger;
 time_domain = [0:size(eeg_sweeps,2) - 1]/sampling_frequency + round(adj_trigger_value*sampling_frequency)/sampling_frequency + round(Seconds_Before_trigger*sampling_frequency)/sampling_frequency;

else
   
 %time_domain = [0:size(eeg_sweeps,2) - 1]/sampling_frequency + Seconds_Before_trigger; 
 time_domain = [0:size(eeg_sweeps,2) - 1]/sampling_frequency + round(Seconds_Before_trigger*sampling_frequency)/sampling_frequency;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Checking if the length of "time_domain" is the same as the lenght of the average vector
if (length(time_domain) ~= length(mean_average_plot))
   
    if (length(time_domain) > length(mean_average_plot))
        
        samples_removed = length(time_domain) - length(mean_average_plot);
        
        time_domain(end - samples_removed + 1) = [];
        
    else   
        
        samples_removed = length(mean_average_plot) - length(time_domain);
        
        mean_average_plot(end - samples_removed + 1) = [];
                
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

find_onset = find(time_domain >= 0,1,'First');

frequency_to_plot = 2000;   %Plotting only the frequencies up to 2kHz

    %% Finding the and save the pre and post stimulus data for the envelope
    pre_stim_data = mean_average_plot(1:find_onset);
    post_stim_data = mean_average_plot(find(time_domain >= (First_sample_after_trigger + adj_trigger_value),1,'First'):end);
    
    rms_pre_stim = sqrt(mean(pre_stim_data.^2));
    rms_post_stim = sqrt(mean(post_stim_data.^2));
    
    save_rms(1) = rms_pre_stim;
    save_rms(2) = rms_post_stim;
    
    save_rms_values_areas(1,1) = rms_pre_stim;
    save_rms_values_areas(1,2) = rms_post_stim;
    
    snr_data = 20*log10(rms_post_stim/rms_pre_stim);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%% Plotting the analysis for the envelope      
figure
subplot(3,2,1)

if (standardized_data == 1)

    mean_save_eeg_plot = mapstd(mean_average_plot);  
    
else
    
    mean_save_eeg_plot = mean_average_plot;
    
end

plot(time_domain*1000,mean_save_eeg_plot)


try
    
hold on
   
      plot([time_domain(find_onset) time_domain(find_onset)],[min(mean_save_eeg_plot) max(mean_save_eeg_plot)],'Color','k','LineWidth',1); 
  
hold off

catch
    
end

set(gca,'fontweight','bold')

axis tight

title(['\bfNumber of trials averaged: ' num2str(size(eeg_sweeps,1))  ' - for channel - ' cell2mat(channels_recorded(channel_selected)) ' with SNR: ' num2str(snr_data)])
    xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude (uV)')

subplot(3,2,3)

 %[PPx_add Freq] = pwelch(post_stim_data,length(post_stim_data),length(post_stim_data)/2,round(sampling_frequency),sampling_frequency);
 [PPx_add Freq] = pwelch(post_stim_data,window_fft_val_whole,overlap_fft_val_whole,nfft_fft_val_whole,sampling_frequency);

 find_1Kz = find(Freq <= frequency_to_plot,1,'Last');
        
        plot(Freq(1:find_1Kz),sqrt(PPx_add(1:find_1Kz)))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfAmplitude(uV)')
        title('\bfAmplitude of cABR')
        
        set(gca,'fontweight','bold')
        
    subplot(3,2,5)
               
        plot(Freq(1:find_1Kz),PPx_add(1:find_1Kz))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfPSD')
        title('\bfPSD of cABR')
        
        set(gca,'fontweight','bold')   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
 %% Plotting the analysis for the fine structure 
 
 if (~isempty(save_eeg_compr))
    
       sub_polarity_sweeps_filtered = (mean(save_eeg_rar) - mean(save_eeg_compr))/2;

        else
            
        sub_polarity_sweeps_filtered = mean(save_eeg_rar);

            end
 
 sub_polarity_sweeps_interval = sub_polarity_sweeps_filtered(1,find(time_domain >= (First_sample_after_trigger + adj_trigger_value),1,'First'):end);
 
 %Calculating the SNR value for the fine structure
 pre_stim_data_sub = sub_polarity_sweeps_filtered(1:find_onset);
    post_stim_data_sub = sub_polarity_sweeps_interval(find(time_domain >= (First_sample_after_trigger + adj_trigger_value),1,'First'):end);
    
    rms_pre_stim_sub = sqrt(mean(pre_stim_data_sub.^2));
    rms_post_stim_sub = sqrt(mean(post_stim_data_sub.^2));
    
    save_rms_sub(1) = rms_pre_stim_sub;
    save_rms_sub(2) = rms_post_stim_sub;
    
    save_rms_values_areas(2,1) = rms_pre_stim_sub;
    save_rms_values_areas(2,2) = rms_post_stim_sub;
    
    snr_data_sub = 20*log10(rms_post_stim_sub/rms_pre_stim_sub);
 
 subplot(3,2,2)
    plot(time_domain*1000,sub_polarity_sweeps_filtered)
    
    xlabel('\bfTime(ms)')
        ylabel('\bfAmplitude(uV)')
        title(['\bfFFR (Fine Structure) with SNR: ' num2str(snr_data_sub)])
        
        %line(time_domain(find_onset),[min(sub_polarity_sweeps_filtered):0.01:max(sub_polarity_sweeps_filtered)],'Color','k','LineWidth',32); 
    
        hold on
        
            plot([time_domain(find_onset) time_domain(find_onset)],[min(sub_polarity_sweeps_filtered) max(sub_polarity_sweeps_filtered)],'Color','k','LineWidth',1); 
  
        hold off
        
        set(gca,'fontweight','bold')
    
        axis tight
        
        subplot(3,2,4)
        %[PPx_sub Freq] = pwelch(sub_polarity_sweeps_interval,length(post_stim_data),length(post_stim_data)/2,length(post_stim_data),sampling_frequency);
    [PPx_sub Freq] = pwelch(sub_polarity_sweeps_interval,window_fft_val_whole,overlap_fft_val_whole,nfft_fft_val_whole,sampling_frequency);
    
        find_1Kz = find(Freq <= frequency_to_plot,1,'Last');
        
        plot(Freq(1:find_1Kz),sqrt(PPx_sub(1:find_1Kz)))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfAmplitude(uV)')
        title('\bfAmplitude of FFR (Fine Structure)')
        
        set(gca,'fontweight','bold')
        
        subplot(3,2,3)
        hold on
        plot(Freq(1:find_1Kz),sqrt(PPx_sub(1:find_1Kz)),'r') 
        hold off
        
       legend('Envelope','Fine structure')
        
    subplot(3,2,6)
               
        plot(Freq(1:find_1Kz),PPx_sub(1:find_1Kz))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfPSD')
        title('\bfPSD of FFR (Fine Structure)')
        
        set(gca,'fontweight','bold')
        
        subplot(3,2,5)
        hold on
        plot(Freq(1:find_1Kz),PPx_sub(1:find_1Kz),'r') 
        hold off
        
       legend('Envelope','Fine Structure')
        
        saveas(gcf,[name_file_saved '_Time_FFT_' cell2mat(channels_recorded(channel_selected)) '.fig'])       
 
        %% RMS values for the envelope
        figure
        bar(save_rms)
        xlabel('\bfPre-Post')
        ylabel('\bfRMS')
        title(['\bfRMS values pre/post of ' channels_recorded(channel_selected)])
               
        set(gca,'xticklabel',{' Pre';'Post'});
       set(gca,'fontweight','bold')
       
       legend(num2str(save_rms))
       
       saveas(gcf,[name_file_saved '_RMS_Envelope_' cell2mat(channels_recorded(channel_selected)) '.fig'])
       
       %% RMS values for the fine structure
        figure
        bar(save_rms_sub)
        xlabel('\bfPre-Post')
        ylabel('\bfRMS')
        title(['\bfRMS values pre/post of the fine structure of ' channels_recorded(channel_selected)])
               
        set(gca,'xticklabel',{' Pre';'Post'});
       set(gca,'fontweight','bold')
       
       legend(num2str(save_rms_sub))
       
       saveas(gcf,[name_file_saved '_RMS_Fine_Structure_' cell2mat(channels_recorded(channel_selected)) '.fig'])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
%% Detecting the peaks of the post-stimulus
minimum_distance_peaks_function = round((minimum_distance_peaks/1000)*sampling_frequency);

time_d = time_domain(find(time_domain >= (First_sample_after_trigger + adj_trigger_value),1,'First'):end);

%[pks,locs] = findpeaks(post_stim_data,'minpeakheight',minimum_threshold_peaks,'minpeakdistance',find(minimum_distance_peaks >= data_exported.time,1,'First'));
[pks,locs] = findpeaks(post_stim_data,'minpeakheight',minimum_threshold_peaks,'minpeakdistance',minimum_distance_peaks_function);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Eliminating the fake peaks. If no peaks have been found, an 
% exception will be thrown and the code will skip to the next
% operation
try
for kk = 1:length(norm_factor)

    find_current_peak = find(time_d(locs)*1000 <= norm_factor(kk));

temp_peaks(kk) = pks(find_current_peak(end));
temp_loc(kk) = locs(find_current_peak(end));

end

pks = temp_peaks;
locs = temp_loc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
  plot(time_d*1000,post_stim_data); hold on;
plot(time_d(locs)*1000,pks+0.005,'k^','markerfacecolor',[1 0 0]);

xlabel('\bfTime (ms)')
  ylabel('\bfAmplitue(uV)')
    title(['\bfPeaks of file ' cell2mat(channels_recorded(channel_selected))])
  
    set(gca,'fontweight','bold')
    
    %axis tight

    saveas(gcf,['Peaks_FFR_' cell2mat(channels_recorded(channel_selected)) '.fig'])

            
    save_picks_cABR(2,:) = num2cell(time_d(locs)*1000);
    save_picks_cABR(1,:) = {'Latency (ms)'};
    
    save_picks_cABR(4,:) = {'Amplitude (uV)'};
    save_picks_cABR(5,:) = num2cell(pks);
    
    xlswrite ([name_file_saved '_Peaks_File_' cell2mat(channels_recorded(channel_selected))],save_picks_cABR)
    
    catch
        
        message = ['No peak has been detected for the channel: ' cell2mat(channels_recorded(channel_selected)) '. Change the threshold to detect the peaks or change the latencies of the expected peaks'];

        msgbox(message,'No peak detected','warn');
        
    end;
    
    clear save_picks_cABR;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%% Calculating the RMS per region: Transient, Steady-State and Off-set    

try
%Transient
post_stim_transient = mean_average_plot(find(time_domain >= (First_sample_transient_region + adj_trigger_value),1,'First'):find(time_domain <= (Seconds_After_trigger + adj_trigger_value),1,'Last'));   
sub_polarity_transient = sub_polarity_sweeps_filtered(1,find(time_domain >= (First_sample_transient_region + adj_trigger_value),1,'First'):find(time_domain <= (Seconds_After_trigger + adj_trigger_value),1,'Last'));
time_transient = 1000*time_domain(find(time_domain >= (First_sample_transient_region + adj_trigger_value),1,'First'):find(time_domain <= (Seconds_After_trigger + adj_trigger_value),1,'Last'));

[PPx_add_transient PPx_sub_transient Freq_transient rms_post_stim_trans rms_post_stim_trans_sub] = transient_analysis_cABR(pre_stim_data,pre_stim_data_sub, ...
    post_stim_transient,sub_polarity_transient,time_transient,sampling_frequency,channels_recorded,...
    channel_selected,frequency_to_plot,name_file_saved,...
    window_fft_val_trans,overlap_fft_val_trans,nfft_fft_val_trans);

save_rms_values_areas(1,3) = rms_post_stim_trans;
    save_rms_values_areas(2,3) = rms_post_stim_trans_sub;

%Steady-State
post_stim_ss = mean_average_plot(find(time_domain >= (First_sample_ss_region + adj_trigger_value),1,'First'):find(time_domain <= (Last_sample_ss_region + adj_trigger_value),1,'Last'));   
sub_polarity_ss = sub_polarity_sweeps_filtered(1,find(time_domain >= (First_sample_ss_region + adj_trigger_value),1,'First'):find(time_domain <= (Last_sample_ss_region + adj_trigger_value),1,'Last'));
time_ss = 1000*time_domain(find(time_domain >= (First_sample_ss_region + adj_trigger_value),1,'First'):find(time_domain <= (Last_sample_ss_region + adj_trigger_value),1,'Last'));

[PPx_add_ss PPx_sub_ss Freq_ss rms_post_stim_ss rms_post_stim_ss_sub] = ss_analysis_cABR(pre_stim_data,pre_stim_data_sub,post_stim_ss, ...
    sub_polarity_ss,time_ss,sampling_frequency,channels_recorded,channel_selected,frequency_to_plot,name_file_saved,...
    window_fft_val_ss,overlap_fft_val_ss,nfft_fft_val_ss);

save_rms_values_areas(1,4) = rms_post_stim_ss;
    save_rms_values_areas(2,4) = rms_post_stim_ss_sub;

%Off-Set
post_stim_off = mean_average_plot(find(time_domain >= (First_sample_off_set_region + adj_trigger_value),1,'First'):find(time_domain <= (Last_sample_off_set_region + adj_trigger_value),1,'Last'));   
sub_polarity_off = sub_polarity_sweeps_filtered(1,find(time_domain >= (First_sample_off_set_region + adj_trigger_value),1,'First'):find(time_domain <= (Last_sample_off_set_region + adj_trigger_value),1,'Last'));
time_off = 1000*time_domain(find(time_domain >= (First_sample_off_set_region + adj_trigger_value),1,'First'):find(time_domain <= (Last_sample_off_set_region + adj_trigger_value),1,'Last'));

[PPx_add_off PPx_sub_off Freq_off rms_post_stim_off rms_post_stim_off_sub] = off_analysis_cABR(pre_stim_data,pre_stim_data_sub,post_stim_off, ...
    sub_polarity_off,time_off,sampling_frequency,channels_recorded,channel_selected,frequency_to_plot,name_file_saved,...
    window_fft_val_off,overlap_fft_val_off,nfft_fft_val_off);
catch
    
    message = 'It is likely that one of more parameters for the FFT analysis have not been chosen correctly'
        msgbox(message,'Operation aborted','warn');
    
    return;
    
end

save_rms_values_areas(1,5) = rms_post_stim_off;
    save_rms_values_areas(2,5) = rms_post_stim_off_sub;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

%% Saving the RMS values
xlswrite ([name_file_saved '_RMS_Values.xls'],save_rms_values_areas);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%% Saving the data if they have been standardized          
if (standardized_data == 1)
    
save_eeg_folder = [name_file_saved '_Average_Trials_' num2str(size(eeg_sweeps,1)) '_' cell2mat(channels_recorded(channel_selected)) '_Standardized.mat'];

try
%data_exported.eeg_data = data_eeg.data_exported.eeg_data; 
data_exported.eeg_data = [];  
data_exported.average_trials = mean_save_eeg_plot;
data_exported.rar_sweeps = save_eeg_rar;
data_exported.compr_sweeps = save_eeg_compr;
data_exported.sweeps_rejected = count_sweeps_rejected;
data_exported.average_add = mean_save_eeg_plot;
data_exported.average_sub = sub_polarity_sweeps_filtered;
data_exported.time_average = time_domain;
%data_exported.add_fourier_power = PPx_add';
%data_exported.sub_fourier_power = PPx_sub';
%data_exported.fourier_frequency = Freq';
%data_exported.add_fourier_power_transient = PPx_add_transient';
%data_exported.sub_fourier_power_transient = PPx_sub_transient';
%data_exported.fourier_frequency_transient = Freq_transient';
%data_exported.add_fourier_power_ss = PPx_add_ss';
%data_exported.sub_fourier_power_ss = PPx_sub_ss';
%data_exported.fourier_frequency_ss = Freq_ss';
%data_exported.add_fourier_power_off = PPx_add_off';
%data_exported.sub_fourier_power_off = PPx_sub_off';
%data_exported.fourier_frequency_off = Freq_off';
data_exported.channel_trials = channels_recorded(channel_selected);
data_exported.code_trials = trigger_selected;
data_exported.average_trials = mean_save_eeg_plot;
data_exported.onset_average_time = time_domain(find_onset);
data_exported.onset_average_sample = find_onset;
data_exported.channels = data_eeg.data_exported.channels;
data_exported.samples = data_eeg.data_exported.samples;
data_exported.sampling_frequency = data_eeg.data_exported.sampling_frequency;
data_exported.trial_duration = data_eeg.data_exported.samples/data_eeg.data_exported.sampling_frequency;
%data_exported.labels = data_eeg.data_exported.labels;
data_exported.labels = channels_recorded(channel_selected);
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

try
    
data_exported.order_filter = data_eeg.data_exported.order_filter;

catch
    
end

catch
    
end


else
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
%% Saving the data if they have not been standardized

save_eeg_folder = [name_file_saved '_Average_Trials_' num2str(size(eeg_sweeps,1)) '_' cell2mat(channels_recorded(channel_selected)) '.mat'];

try
%data_exported.eeg_data = data_eeg.data_exported.eeg_data; 
data_exported.eeg_data = []; 
data_exported.average_trials = mean_save_eeg_plot;
data_exported.rar_sweeps = save_eeg_rar;
data_exported.compr_sweeps = save_eeg_compr;
data_exported.sweeps_rejected = count_sweeps_rejected;
data_exported.average_add = mean_save_eeg_plot;
data_exported.average_sub = sub_polarity_sweeps_filtered;
data_exported.time_average = time_domain;
% data_exported.add_fourier_power = PPx_add';
% data_exported.sub_fourier_power = PPx_sub';
% data_exported.fourier_frequency = Freq';
% data_exported.add_fourier_power_transient = PPx_add_transient';
% data_exported.sub_fourier_power_transient = PPx_sub_transient';
% data_exported.fourier_frequency_transient = Freq_transient';
% data_exported.add_fourier_power_ss = PPx_add_ss';
% data_exported.sub_fourier_power_ss = PPx_sub_ss';
% data_exported.fourier_frequency_ss = Freq_ss';
% data_exported.add_fourier_power_off = PPx_add_off';
% data_exported.sub_fourier_power_off = PPx_sub_off';
% data_exported.fourier_frequency_off = Freq_off';
data_exported.channel_trials = channels_recorded(channel_selected);
data_exported.code_trials = trigger_selected;
data_exported.average_trials = mean_save_eeg_plot;
data_exported.onset_average_time = time_domain(find_onset);
data_exported.onset_average_sample = find_onset;
data_exported.channels = data_eeg.data_exported.channels;
data_exported.samples = data_eeg.data_exported.samples;
data_exported.sampling_frequency = data_eeg.data_exported.sampling_frequency;
data_exported.trial_duration = data_eeg.data_exported.samples/data_eeg.data_exported.sampling_frequency;
%data_exported.labels = data_eeg.data_exported.labels;
data_exported.labels = channels_recorded(channel_selected);

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

try

data_exported.order_filter = data_eeg.data_exported.order_filter;

catch 
    
end

catch
    
end

end

save (save_eeg_folder,'data_exported')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    


message = ['Sweeps Rejected Rarefraction and Condensation: ' num2str(data_exported.sweeps_rejected(1)) ' / ' num2str(data_exported.sweeps_rejected(2))];
msgbox(message,'Sweeps Rejected','warn','replace');

message = 'All the Epochs have been extracted';
msgbox(message,'End of the analysis','warn','replace');


