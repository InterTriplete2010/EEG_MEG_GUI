function [PPx_add_transient PPx_sub_transient Freq_transient rms_post_stim_transient rms_post_stim_transient_sub] = transient_analysis_cABR(pre_stim_data, ...
    pre_stim_data_sub,post_stim_transient,sub_polarity_transient,time_transient,sampling_frequency,channels_recorded,channel_selected,frequency_to_plot,...
    name_file_saved,window_fft_val_trans,overlap_fft_val_trans,nfft_fft_val_trans)

%% Plotting the analysis for the envelope 
rms_pre_stim_transient = sqrt(mean(pre_stim_data.^2));
    rms_post_stim_transient = sqrt(mean(post_stim_transient.^2));
    
    save_rms_transient(1) = rms_pre_stim_transient;
    save_rms_transient(2) = rms_post_stim_transient;
    
    snr_data_transient = 20*log10(rms_post_stim_transient/rms_pre_stim_transient);
    
figure
subplot(3,2,1)

plot(time_transient,post_stim_transient)

set(gca,'fontweight','bold')

axis tight

title(['\bfTransient response for Channel' channels_recorded(channel_selected) 'with SNR: ' num2str(snr_data_transient)])
    xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude (uV)')

subplot(3,2,3)

 [PPx_add_transient Freq_transient] = pwelch(post_stim_transient,window_fft_val_trans,overlap_fft_val_trans,nfft_fft_val_trans,sampling_frequency);
 find_1Kz_transient = find(Freq_transient <= frequency_to_plot,1,'Last');
        
        plot(Freq_transient(1:find_1Kz_transient),sqrt(PPx_add_transient(1:find_1Kz_transient)))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfAmplitude(uV)')
        title('\bfAmplitude of the transient region')
        
        set(gca,'fontweight','bold')
        
    subplot(3,2,5)
               
        plot(Freq_transient(1:find_1Kz_transient),PPx_add_transient(1:find_1Kz_transient))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfPSD')
        title('\bfPSD of the transient region')
        
        set(gca,'fontweight','bold')   

 %% Plotting the analysis for the fine structure  
 rms_pre_stim_transient_sub = sqrt(mean(pre_stim_data_sub.^2));
    rms_post_stim_transient_sub = sqrt(mean(sub_polarity_transient.^2));
    
    save_rms_transient_sub(1) = rms_pre_stim_transient_sub;
    save_rms_transient_sub(2) = rms_post_stim_transient_sub;
    
    snr_data_transient_sub = 20*log10(rms_post_stim_transient_sub/rms_pre_stim_transient_sub);
 
  subplot(3,2,2)
    plot(time_transient,sub_polarity_transient)
    
    xlabel('\bfTime(ms)')
        ylabel('\bfAmplitude(uV)')
        title(['\bfTransient Region (Fine Structure) with SNR: ' num2str(snr_data_transient_sub)])
       
        set(gca,'fontweight','bold')
    
        axis tight
        
        subplot(3,2,4)
    [PPx_sub_transient Freq_transient] = pwelch(sub_polarity_transient,window_fft_val_trans,overlap_fft_val_trans,nfft_fft_val_trans,sampling_frequency);
    
        find_1Kz_transient = find(Freq_transient <= frequency_to_plot,1,'Last');
        
        plot(Freq_transient(1:find_1Kz_transient),sqrt(PPx_sub_transient(1:find_1Kz_transient)))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfAmplitude(uV)')
        title('\bfAmplitude of the Transient Region (Fine Structure)')
        
        set(gca,'fontweight','bold')
        
        subplot(3,2,3)
        hold on
        plot(Freq_transient(1:find_1Kz_transient),sqrt(PPx_sub_transient(1:find_1Kz_transient)),'r') 
        hold off
        
       legend('Envelope','Fine Structure')
        
    subplot(3,2,6)
               
        plot(Freq_transient(1:find_1Kz_transient),PPx_sub_transient(1:find_1Kz_transient))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfPSD')
        title('\bfPSD of the Transient Region (Fine Structure)')
        
        set(gca,'fontweight','bold')
        
        subplot(3,2,5)
        hold on
        plot(Freq_transient(1:find_1Kz_transient),PPx_sub_transient(1:find_1Kz_transient),'r') 
        hold off
        
       legend('Envelope','Fine Structure')
        
        saveas(gcf,[name_file_saved '_Time_FFT_Transient_Region_' cell2mat(channels_recorded(channel_selected)) '.fig'])       
 
        %% RMS values for the envelope
        figure
        bar(save_rms_transient)
        xlabel('\bfPre-Post')
        ylabel('\bfRMS')
        title(['\bfRMS values pre/post of the Transient Region of the Envelope of ' channels_recorded(channel_selected)])
               
        set(gca,'xticklabel',{' Pre';'Post'});
       set(gca,'fontweight','bold')
       
       legend(num2str(save_rms_transient))
       
       saveas(gcf,[name_file_saved '_RMS_Transient_Region_Envelope_' cell2mat(channels_recorded(channel_selected)) '.fig'])
       
       %% RMS values for the fine structure
        figure
        bar(save_rms_transient_sub)
        xlabel('\bfPre-Post')
        ylabel('\bfRMS')
        title(['\bfRMS values pre/post of the Transient Region of the Fine Structure of ' channels_recorded(channel_selected)])
               
        set(gca,'xticklabel',{' Pre';'Post'});
       set(gca,'fontweight','bold')
       
       legend(num2str(save_rms_transient_sub))
       
       saveas(gcf,[name_file_saved '_RMS_Transient_Region_Fine_Structure_' cell2mat(channels_recorded(channel_selected)) '.fig'])
       
       
       