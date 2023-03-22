function eeg_filtered = Band_Stop_Filter_Function_FIR (eeg_data_filter,cut_off_band_pass_low,cut_off_band_pass_high,sampling_frequency_data,order_band_pass); 

[electrodes samples] = size(eeg_data_filter);
eeg_filtered = [];


%% Filtering the raw data with a band pass filter
try
      
  b = fir1(order_band_pass,[cut_off_band_pass_high cut_off_band_pass_low]/(sampling_frequency_data/2),'stop'); 
  a = 1;
  %filter: order = order_band_pass; Cutoff Frequency: [cut_off_low_value cut_off_high_value]; 
  %band pass filter
  
 for kk = 1:electrodes        
     temp_data = eeg_data_filter(kk,:);
 
     data_filtered = filter(b,a,temp_data);
 
    %Data have been shifted to compensate for the phase-shift introduced by the FIR filter   
     [time_delay_fir freq_delay_fir]  = grpdelay(b,1); 
     data_filtered=data_filtered(1,round(mean(time_delay_fir)) + 1:end);  
     
     eeg_filtered = [eeg_filtered;data_filtered];
 
 end
 
 figure
 subplot(2,1,1)
 time_d = [0:samples-1]/sampling_frequency_data;
 plot(time_d,eeg_data_filter(1,:))
 title('\bfEEG before being filtered');
    
    ylabel('\bfAmplitude(uV)')
xlabel('\bfTime (s)')  

set(gca,'fontweight','bold')

 subplot(2,1,2)
 time_d = [0:size(eeg_filtered,2)-1]/sampling_frequency_data;
 plot(time_d,eeg_filtered(1,:),'r')
 title('\bfEEG after being filtered');
    
    ylabel('\bfAmplitude(uV)')
xlabel('\bfTime (s)')

set(gca,'fontweight','bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the frequency response of the filter
figure
freqz(b,a,sampling_frequency_data,'whole',sampling_frequency_data);
title('\bfFrequency response of the filter');

fvtool(b,a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    catch
  message = 'The cutoff frequency must be within the interval of (0,Sampling_Frequency/2)';

        msgbox(message,'Error!!!','warn');
  
  end