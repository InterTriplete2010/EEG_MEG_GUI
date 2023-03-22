function eeg_filtered = Band_Pass_Filter_Function_COGMO (eeg_data_filter,cut_off_band_pass_low,cut_off_band_pass_high,sampling_frequency_data,order_band_pass,zp_option); 

[electrodes samples] = size(eeg_data_filter);
eeg_filtered = zeros(electrodes,samples);


%% Filtering the raw data with a band pass filter
try
      
  [b,a] = butter(order_band_pass,[cut_off_band_pass_high cut_off_band_pass_low]/(sampling_frequency_data/2)); 
  %Butterworth filter: order = order_band_pass; Cutoff Frequency: [cut_off_low_value cut_off_high_value]; 
  %band pass filter
  
 for kk = 1:electrodes        
     temp_data = eeg_data_filter(kk,:);
 
     if (zp_option == 1)
     
     data_filtered = filtfilt(b,a,temp_data);
 
     else
        
         data_filtered = filter(b,a,temp_data);
         
     end
     
          
     eeg_filtered(kk,:) = data_filtered;
 
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
 plot(time_d,eeg_filtered(1,:),'r')
 title('\bfEEG after being filtered');
    
    ylabel('\bfAmplitude(uV)')
xlabel('\bfTime (s)')

set(gca,'fontweight','bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Check if the filter is stable and plot the polar coordinates in a 
%cartesian plane 

check_stability(b,a);

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