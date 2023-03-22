%This function computes the frequency analysis of the selected channel by using the "PWelch" function 

function PWelch_COGMO_Function(channel_name,eegfiledata,window_variable,noverlap_variable,nfft_variable,sampling_frequency,all_chan_choice,start_time)

if all_chan_choice ~= 1  

    try
 
figure   
subplot(2,1,1)
    pwelch(eegfiledata,round(window_variable*sampling_frequency),round(noverlap_variable*sampling_frequency),round(nfft_variable*sampling_frequency),sampling_frequency);
        
    title(['\bfPower Spectral Density Estimate via PWelch of channel: ' channel_name]);
    
    ylabel('\bfPower/frequency (dB/Hz)')

    if(sampling_frequency >= 2000)

        xlabel('\bfFrequency (KHz)')

    else

xlabel('\bfFrequency (Hz)')    

    end

set(gca,'fontweight','bold')

   subplot(2,1,2)
    
time_d = [0:length(eegfiledata) - 1]/sampling_frequency + start_time/sampling_frequency;
plot(time_d,eegfiledata)
title('\bfEEG/MEG');
    
    ylabel('\bfAmplitude(\muV for EEG or fT for MEG)')
xlabel('\bfTime (s)')  

set(gca,'fontweight','bold')

catch
   
    message = 'Some of the parameters of the Welch method have not been set correctly';

        msgbox(message,'Error','warn');
    
end


else
  
    figure 
    
      try   
     
subplot(2,1,1)

hold on

    pwelch(eegfiledata',window_variable*sampling_frequency,noverlap_variable*sampling_frequency,nfft_variable*sampling_frequency,sampling_frequency);

   subplot(2,1,2)
   
   hold on
   
time_d = [0:size(eegfiledata,2) - 1]/sampling_frequency;
plot(time_d,eegfiledata')

  
 title('\bfPower Spectral Density Estimate via PWelch of all the channels');
  
subplot(2,1,1) 
    ylabel('\bfPower/frequency (dB/Hz)')

    if(sampling_frequency > 1000)

        xlabel('\bfFrequency (KHz)')

    else

xlabel('\bfFrequency (Hz)')    

    end

set(gca,'fontweight','bold')

subplot(2,1,2)
title('\bfEEG/MEG');
    
    ylabel('\bfAmplitude(\muV for EEG or fT for MEG)')
xlabel('\bfTime (s)')  

set(gca,'fontweight','bold')

catch
   
    message = 'Some of the parameters of the Welch method have not been set correctly';

        msgbox(message,'Error','warn');
    
 end

end
