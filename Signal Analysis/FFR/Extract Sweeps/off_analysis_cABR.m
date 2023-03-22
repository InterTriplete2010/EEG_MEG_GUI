function [PPx_add_off PPx_sub_off Freq_off rms_post_stim_off rms_post_stim_off_sub] = off_analysis_cABR(pre_stim_data,pre_stim_data_sub, ...
    post_stim_off,sub_polarity_off,time_off,sampling_frequency, channels_recorded,channel_selected,frequency_to_plot,...
    name_file_saved,window_fft_val_ss,overlap_fft_val_ss,nfft_fft_val_ss)

%% Plotting the analysis for the envelope 
rms_pre_stim_off = sqrt(mean(pre_stim_data.^2));
    rms_post_stim_off = sqrt(mean(post_stim_off.^2));
    
    save_rms_off(1) = rms_pre_stim_off;
    save_rms_off(2) = rms_post_stim_off;
    
    snr_data_off = 20*log10(rms_post_stim_off/rms_pre_stim_off);
    
figure
subplot(3,2,1)

plot(time_off,post_stim_off)

set(gca,'fontweight','bold')

axis tight

title(['\bfOff-response for Channel' channels_recorded(channel_selected) 'with SNR: ' num2str(snr_data_off)])
    xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude (uV)')

subplot(3,2,3)

 [PPx_add_off Freq_off] = pwelch(post_stim_off,window_fft_val_ss,overlap_fft_val_ss,nfft_fft_val_ss,sampling_frequency);
 find_1Kz_off = find(Freq_off <= frequency_to_plot,1,'Last');
        
        plot(Freq_off(1:find_1Kz_off),sqrt(PPx_add_off(1:find_1Kz_off)))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfAmplitude(uV)')
        title('\bfAmplitude of the off-response region')
        
        set(gca,'fontweight','bold')
        
    subplot(3,2,5)
               
        plot(Freq_off(1:find_1Kz_off),PPx_add_off(1:find_1Kz_off))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfPSD')
        title('\bfPSD of the off-response region')
        
        set(gca,'fontweight','bold')   

 %% Plotting the analysis for the fine structure  
  rms_pre_stim_off_sub = sqrt(mean(pre_stim_data_sub.^2));
  rms_post_stim_off_sub = sqrt(mean(sub_polarity_off.^2));
    
    save_rms_off_sub(1) = rms_pre_stim_off_sub;
    save_rms_off_sub(2) = rms_post_stim_off_sub;
    
    snr_data_off_sub = 20*log10(rms_post_stim_off_sub/rms_pre_stim_off_sub);
 
  subplot(3,2,2)
    plot(time_off,sub_polarity_off)
    
    xlabel('\bfTime(ms)')
        ylabel('\bfAmplitude(uV)')
        title(['\bfOff-response Region (Fine Structure) with SNR: ' num2str(snr_data_off_sub)])
       
        set(gca,'fontweight','bold')
    
        axis tight
        
        subplot(3,2,4)
    [PPx_sub_off Freq_off] = pwelch(sub_polarity_off,window_fft_val_ss,overlap_fft_val_ss,nfft_fft_val_ss,sampling_frequency);
    
        find_1Kz_off = find(Freq_off <= frequency_to_plot,1,'Last');
        
        plot(Freq_off(1:find_1Kz_off),sqrt(PPx_sub_off(1:find_1Kz_off)))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfAmplitude(uV)')
        title('\bfAmplitude of the Off-Response Region (Fine Structure)')
        
        set(gca,'fontweight','bold')
        
        subplot(3,2,3)
        hold on
        plot(Freq_off(1:find_1Kz_off),sqrt(PPx_sub_off(1:find_1Kz_off)),'r') 
        hold off
        
       legend('Envelope','Fine Structure')
        
    subplot(3,2,6)
               
        plot(Freq_off(1:find_1Kz_off),PPx_sub_off(1:find_1Kz_off))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfPSD')
        title('\bfPSD of the Off-Response Region (Fine Structure)')
        
        set(gca,'fontweight','bold')
        
        subplot(3,2,5)
        hold on
        plot(Freq_off(1:find_1Kz_off),PPx_sub_off(1:find_1Kz_off),'r') 
        hold off
        
       legend('Envelope','Fine Structure')
        
        saveas(gcf,[name_file_saved '_Time_FFT_Off_Response_Region_' cell2mat(channels_recorded(channel_selected)) '.fig'])       
 
        %% RMS values for the envelope
        figure
        bar(save_rms_off)
        xlabel('\bfPre-Post')
        ylabel('\bfRMS')
        title(['\bfRMS values pre/post of the Off-Response Region of the Envelope of ' channels_recorded(channel_selected)])
               
        set(gca,'xticklabel',{' Pre';'Post'});
       set(gca,'fontweight','bold')
       
       legend(num2str(save_rms_off))
       
       saveas(gcf,[name_file_saved '_RMS_Off_Response_Region_Envelope_' cell2mat(channels_recorded(channel_selected)) '.fig'])
       
       %% RMS values for the fine structure
        figure
        bar(save_rms_off_sub)
        xlabel('\bfPre-Post')
        ylabel('\bfRMS')
        title(['\bfRMS values pre/post of the Off-Response of the Fine Structure of ' channels_recorded(channel_selected)])
               
        set(gca,'xticklabel',{' Pre';'Post'});
       set(gca,'fontweight','bold')
       
       legend(num2str(save_rms_off_sub))
       
       saveas(gcf,[name_file_saved '_RMS_Off_Response_Region_Fine_Structure_' cell2mat(channels_recorded(channel_selected)) '.fig'])
       