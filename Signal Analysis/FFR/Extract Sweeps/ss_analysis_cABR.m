function [PPx_add_ss PPx_sub_ss Freq_ss rms_post_stim_ss rms_post_stim_ss_sub] = ss_analysis_cABR(pre_stim_data,pre_stim_data_sub,post_stim_ss, ...
    sub_polarity_ss,time_ss,sampling_frequency,channels_recorded,channel_selected,frequency_to_plot,name_file_saved,...
    window_fft_val_ss,overlap_fft_val_ss,nfft_fft_val_ss)

%% Plotting the analysis for the envelope 
rms_pre_stim_ss = sqrt(mean(pre_stim_data.^2));
    rms_post_stim_ss = sqrt(mean(post_stim_ss.^2));
    
    save_rms_ss(1) = rms_pre_stim_ss;
    save_rms_ss(2) = rms_post_stim_ss;
    
    snr_data_ss = 20*log10(rms_post_stim_ss/rms_pre_stim_ss);
    
figure
subplot(3,2,1)

plot(time_ss,post_stim_ss)

set(gca,'fontweight','bold')

axis tight

title(['\bfSteady-State response for Channel' channels_recorded(channel_selected) 'with SNR: ' num2str(snr_data_ss)])
    xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude (uV)')

subplot(3,2,3)

 [PPx_add_ss Freq_ss] = pwelch(post_stim_ss,window_fft_val_ss,overlap_fft_val_ss,nfft_fft_val_ss,sampling_frequency);
 find_1Kz_ss = find(Freq_ss <= frequency_to_plot,1,'Last');
        
        plot(Freq_ss(1:find_1Kz_ss),sqrt(PPx_add_ss(1:find_1Kz_ss)))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfAmplitude(uV)')
        title('\bfAmplitude of the steady-state region')
        
        set(gca,'fontweight','bold')
        
    subplot(3,2,5)
               
        plot(Freq_ss(1:find_1Kz_ss),PPx_add_ss(1:find_1Kz_ss))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfPSD')
        title('\bfPSD of the steady-state region')
        
        set(gca,'fontweight','bold')   

 %% Plotting the analysis for the fine structure 
 rms_pre_stim_ss_sub = sqrt(mean(pre_stim_data_sub.^2));
    rms_post_stim_ss_sub = sqrt(mean(sub_polarity_ss.^2));
    
    save_rms_ss_sub(1) = rms_pre_stim_ss_sub;
    save_rms_ss_sub(2) = rms_post_stim_ss_sub;
    
    snr_data_ss_sub = 20*log10(rms_post_stim_ss_sub/rms_pre_stim_ss_sub);
    
  subplot(3,2,2)
    plot(time_ss,sub_polarity_ss)
    
    xlabel('\bfTime(ms)')
        ylabel('\bfAmplitude(uV)')
        title(['\bfSteady-State Region (Fine Structure) with SNR: ' num2str(snr_data_ss_sub)])
       
        set(gca,'fontweight','bold')
    
        axis tight
        
        subplot(3,2,4)
    [PPx_sub_ss Freq_ss] = pwelch(sub_polarity_ss,window_fft_val_ss,overlap_fft_val_ss,nfft_fft_val_ss,sampling_frequency);
    
        find_1Kz_ss = find(Freq_ss <= frequency_to_plot,1,'Last');
        
        plot(Freq_ss(1:find_1Kz_ss),sqrt(PPx_sub_ss(1:find_1Kz_ss)))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfAmplitude(uV)')
        title('\bfAmplitude of the Steady-State Region (Fine Structure)')
        
        set(gca,'fontweight','bold')
        
        subplot(3,2,3)
        hold on
        plot(Freq_ss(1:find_1Kz_ss),sqrt(PPx_sub_ss(1:find_1Kz_ss)),'r') 
        hold off
        
       legend('Envelope','Fine Structure')
        
    subplot(3,2,6)
               
        plot(Freq_ss(1:find_1Kz_ss),PPx_sub_ss(1:find_1Kz_ss))   
    
        xlabel('\bfFrequency(Hz)')
        ylabel('\bfPSD')
        title('\bfPSD of the Steady-State Region (Fine Structure)')
        
        set(gca,'fontweight','bold')
        
        subplot(3,2,5)
        hold on
        plot(Freq_ss(1:find_1Kz_ss),PPx_sub_ss(1:find_1Kz_ss),'r') 
        hold off
        
       legend('Envelope','Fine Structure')
        
        saveas(gcf,[name_file_saved '_Time_FFT_Steady_State_Region_' cell2mat(channels_recorded(channel_selected)) '.fig'])       
 
        %% RMS values of the envelope
        figure
        bar(save_rms_ss)
        xlabel('\bfPre-Post')
        ylabel('\bfRMS')
        title(['\bfRMS values pre/post of the Steady-State Region of the Envelope of ' channels_recorded(channel_selected)])
               
        set(gca,'xticklabel',{' Pre';'Post'});
       set(gca,'fontweight','bold')
       
       legend(num2str(save_rms_ss))
       
       saveas(gcf,[name_file_saved '_RMS_Steady_State_Region_Envelope_' cell2mat(channels_recorded(channel_selected)) '.fig'])
       
       %% RMS values for the fine structure
        figure
        bar(save_rms_ss_sub)
        xlabel('\bfPre-Post')
        ylabel('\bfRMS')
        title(['\bfRMS values pre/post of the Steady-State Region of the Fine Structure of ' channels_recorded(channel_selected)])
               
        set(gca,'xticklabel',{' Pre';'Post'});
       set(gca,'fontweight','bold')
       
       legend(num2str(save_rms_ss_sub))
       
       saveas(gcf,[name_file_saved '_RMS_Steady_State_Region_Fine_Structure_' cell2mat(channels_recorded(channel_selected)) '.fig'])
       