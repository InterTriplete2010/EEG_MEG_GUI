function CWT_EEG_Function_COGMO(EEG_cwt_file_selected,sampling_frequency,startT,endT,cwtfiledata,...
    low_freq,high_freq,events_trigger,electrode_name_selected,step_wavelets,electrode_names,plot_save_fig,make_dir_data,...
    current_path_name,dec_f,time_domain)

%% Building up the mother wavelet
[rows_signal columns_signal] = size(cwtfiledata);

%length_window = zeros(1,high_freq - low_freq + 1);
length_window = zeros(1,length([low_freq:step_wavelets:high_freq]));

%Decimating the data by a factor "dec_f"   
cwtfiledata_dec = [];
cwtfiledata_dec = resample(cwtfiledata',1,dec_f)';

if(dec_f > 1)
   
    time_domain = (0:size(cwtfiledata_dec,2)-1)/(sampling_frequency/dec_f);
    
end

cwtfiledata = cwtfiledata_dec;
[rows_signal columns_signal] = size(cwtfiledata);
    

sampling_frequency = sampling_frequency/dec_f;

%% Checking if the number of samples is odd or even
check_odd_even = mod(columns_signal,2);

if (check_odd_even == 1)

    cwtfiledata(:,end) = [];
    [rows_signal columns_signal] = size(cwtfiledata);
endT = endT - 1;
time_domain(:,end) = [];

end


border = columns_signal;
border_effect = columns_signal/2;

fs = sampling_frequency;
N = columns_signal + border;  %Samples for eliminating the border effect
dt = 1/fs;   %Period
columns_dec = N;
t = ((0:N-1)-N/2+1)*dt;

df = fs/columns_dec;   %Frequency resolution

f = (0:columns_dec-1)*df;

%Creating matrix "H" used to shift back the mother wavelet
h = zeros(1,N);
h_decimate = h; %DownSample "h"  
h_decimate(round(length(h_decimate)/2)) = 1;
H = fft(h_decimate);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generation of wavelets to be stored in frequency domain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This is used to start saving the frequencies from row "1"; for instance,
%if the starting frequency is "20", this line of code will make sure that
%20 Hz will be saved in the first row "j" (starting_point = 19 (20-1) and j = 1 (20-19))
%starting_point = low_freq - 1; 
track_freq = 1;
energy_track = zeros(1,length([low_freq:step_wavelets:high_freq]));

for f0 = low_freq:step_wavelets:high_freq 
sf = f0/7;
    st = 1/(2*pi*sf);
        A = 1/sqrt(st*sqrt(pi)); %Normalization factor
            %j=f0-starting_point;
  j = track_freq;
            ond(j,:) = A*exp(-t.^2/(2*st^2)).*exp(2*i*pi*f0*t); %Generation of the Mother Wavelet (The Morlet in this case)
             
            ond_signal = ond(j,:);
            
               energy_track(j) =  sum(abs(ond_signal).^2)/fs;
            
               sg(j,:) = fft(ond_signal(1,:))./H;  %Computes FFT of the Mother Wavelet and shift wave back to zero (see Fourier Transform Property)
                
                ener(j)=sqrt(sum(sg(j,:).*conj(sg(j,:))))/N; %Computes the energy of the wavelet
                        freq(j)=f0;
                        
                        %sg(j,:) = ((fft(ond_signal(1,:))*2)/length(ond_signal))./H;  %Computes FFT of the Mother Wavelet and shift wave back to zero (see Fourier Transform Property)
                
                %ener(j)=sqrt(sum(sg(j,:).*conj(sg(j,:)))); %Computes the energy of the wavelet
                
                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                
                %% Saving the information about the lenght of each window
                temp_threshold = 0.01;
                [pks,locs] = findpeaks(real(ond(j,:)),'minpeakheight',temp_threshold);
                warning off
                while(isempty(pks))
                    
                    temp_threshold = temp_threshold - 0.01;
                    [pks,locs] = findpeaks(real(ond(j,:)),'minpeakheight',temp_threshold);
                
                end
                
                warning on
                
                find_window = zeros(1,2);
                
                %% Finding the first peak with 95% less of energy with respect to the first and last positive peaks of the mother wavelet
                find_window_first = real(ond(j,locs(1):-1:1));
                find_window_first_check = 1;
                
                for kk = 1:length(find_window_first)
                   
                    if ((pks(1) - find_window_first(1,kk))/pks(1) >= 0.95 & find_window_first_check == 1)
                    
                        find_window(1,1) = (locs(1) - kk);
                        find_window_first_check = 0;
                    
                    end
                
                end
                
                    find_window_last = real(ond(j,locs(end):end));
                    find_window_last_check = 1;
                    
                    for kk = 1:length(find_window_last)
                   
                    if ((pks(end) - find_window_last(1,kk))/pks(end) >= 0.95 & find_window_last_check == 1)
                    
                        find_window(1,2) = (locs(end) + kk);
                        find_window_last_check = 0;
                    
                    end
                
                    end
                    
              %Hamming window with 'Periodic' option selected for DFT/FFT purposes. Use 'symmetrical' for filtering,only      
               hamm_window = hamming(find_window(2) - find_window(1),'periodic');
               length_window(1,j) = (hamm_window'*hamm_window);
                %length_window(1,j) = sqrt((hamm_window'*hamm_window));
                
                sg(j,:) = sg(j,:)/length_window(1,j);
                
                track_freq = track_freq + 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                
                
end

%% Plotting the energy at each frequency to make sure they are all = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot([low_freq:step_wavelets:high_freq],energy_track)

xlabel('\bfFrequency')
ylabel('\bfEnergy')
title(['\bfEnergy of each frequency for each mother wavelet. The mean is: ' num2str(mean(energy_track))])
set(gca,'fontweight','bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Extension for the removal of the Border effect 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Creating the extension for the border effect for the signal "x"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
message = ('Calculating the amplitude and the energy');
msgbox(message,'Calculation in progress...','warn','replace');

save_wavelet_data = zeros(size(cwtfiledata,1),size(sg,1),size(cwtfiledata,2));

if make_dir_data == 1
    
    mkdir('Save Energy-Amplitude')
    
end


for elec_wav = 1:size(cwtfiledata,1)

    %display(['Electrode #' num2str(elec_wav)])
    display(['Electrode: ' electrode_name_selected(elec_wav)]);
    
 x_dec = cwtfiledata(elec_wav,:);       
 
 if size(cwtfiledata,1) > 1
   
     electrode_name_selected = electrode_names;
     
 %else
     
  %   electrode_name_selected = electrode_names(elec_wav);
     
 end
 
 border_effect = border_effect;

[rows_dec columns_dec] = size(x_dec);

diff_add_first_sum_x = x_dec (1:border_effect);
diff_add_last_sum_x = x_dec (border_effect + 1:end);

diff_border_sum_x = zeros(rows_dec, columns_dec + border_effect*2);

diff_border_sum_x(rows_dec, 1:border_effect) = diff_add_last_sum_x(:,:);
diff_border_sum_x(rows_dec, columns_dec + 1 + border_effect:border_effect*2 + columns_dec) = diff_add_first_sum_x(:,:);
diff_border_sum_x(rows_dec, border_effect + 1:columns_dec + border_effect) = x_dec(rows_dec,:);
fft_diff_border_sum_x = fft(diff_border_sum_x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Calculating the Energy 
[r c] = size(sg);

 FinalEnergy_sum_x = zeros(r,c); %Matrix used to store the energies for each frequency
          
        for k = 1:r
 
                    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Calculating the CWT and the energies for each frequency
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
 temp_abs_square_sum_x = zeros(1,c);   %Matrix used to temporarly store the energy
    
           wmor_sum_x = sg(k,:);
                msig_sum_x = fft_diff_border_sum_x(rows_dec,:);
                      temp_sum_x = wmor_sum_x.*msig_sum_x; 
  temp_sum_x_ifft = ifft(temp_sum_x);
                             
            %Calculating the energy            
               temp_abs_square_sum_x = abs(temp_sum_x_ifft).^2;
                                
           %Storing the energy of frequency "k"     
            FinalEnergy_sum_x(k,:) = temp_abs_square_sum_x; %Storing the energy of the "k" frequency
                            
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Removal of the border effect
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Energy_sum_x = FinalEnergy_sum_x;
elimination_border_sum_x = border_effect;

    
Energy_sum_x(:,1:elimination_border_sum_x) = [];


[righe_sum colonne_sum] = size(Energy_sum_x);
Energy_sum_x(:,columns_signal + 1:end) = [];



%% Plotting the energies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time-Frequency Representation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


save_wavelet_data(elec_wav,:,:) = Energy_sum_x;


%% Creating the range of frequencies with round(high_freq/low_freq) Hz step
frequency_range = [low_freq:step_wavelets:high_freq];

if time_domain(1) > 1
   
    time_domain = time_domain./1000;    %Divide the time doain by 1000 to have a better display of the time, if the data plotted are longer than 1 seconds
    events_trigger = events_trigger./1000;
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Filtering the time series

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[b,a] = butter(3,[frequency_range(1) frequency_range(end)]/(sampling_frequency/2)); 
  
%x_dec = filtfilt(b,a,x_dec);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%% Plotting and saving the energy
cd([current_path_name '\Save Energy-Amplitude'])

switch plot_save_fig 
    
    case 1
        
        display('Figures have neither been plotted nor saved. Only data have been saved')
        
    case 2    
        
figure
subplot(2,1,1)

        contourf(1000*time_domain,frequency_range,Energy_sum_x(:,:))

          set(gca,'fontweight','bold');
    try
        
        if(size(cwtfiledata,1) > 1)
            
            title(['\bfEnergy of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected(elec_wav)]);   
   
            
        else
            
    title(['\bfEnergy of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected]);   
   
        end
    
    catch
    
        if(size(cwtfiledata,1) > 1)
            
             title(['\bfEnergy of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected(elec_wav))]); 
            
        else
            
        title(['\bfEnergy of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected)]);   
           
        end
        
    end
    
    xlabel('\bfTime (ms)')
    ylabel('\bfFrequency (Hz)')  
%colorbar

subplot(2,1,2)
plot(1000*time_domain(1,:),x_dec(1,:))

axis tight

try
hold on
   
for trig_count = 1:length(events_trigger)
    
      plot([1000*events_trigger(trig_count) 1000*events_trigger(trig_count)],[min(x_dec(1,:)) max(x_dec(1,:))],'Color','k','LineWidth',1);
   
end

hold off

catch
       
end


xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude(\muV for EEG or fT for EG)')

    set(gca,'fontweight','bold')
 
    try
        
         if(size(cwtfiledata,1) > 1)
             
             saveas(gcf,['Energy_CWT_' EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected(elec_wav) '.fig'])
             
         else
        
saveas(gcf,['Energy_CWT_' EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected '.fig'])

         end

    catch
       
         if(size(cwtfiledata,1) > 1)
            
             saveas(gcf,['Energy_CWT_' EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected(elec_wav)) '.fig'])
             
         else
        
        saveas(gcf,['Energy_CWT_' EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected) '.fig'])

         end
        
    end

    close(gcf)
    
%% Plotting and saving the amplitude    
    case 3
figure
subplot(2,1,1)

 
        contourf(1000*time_domain,frequency_range,sqrt(Energy_sum_x(:,:)))

          set(gca,'fontweight','bold');
    try
        
        if(size(cwtfiledata,1) > 1)
            
            title(['\bfAmplitude of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected(elec_wav)]); 
            
        else
            
    title(['\bfAmplitude of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected]);   
   
        end
    
    catch
    
        if(size(cwtfiledata,1) > 1)
            
             title(['\bfAmplitude of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected(elec_wav))]);   
            
        else
            
        title(['\bfAmplitude of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected)]);   
           
        end
        
    end
    
    xlabel('\bfTime (ms)')
    ylabel('\bfFrequency (Hz)')  
%colorbar

subplot(2,1,2)
plot(1000*time_domain(1,:),x_dec(1,:))

axis tight

try
hold on
   
 for trig_count = 1:length(events_trigger)
    
      plot([1000*events_trigger(trig_count) 1000*events_trigger(trig_count)],[min(x_dec(1,:)) max(x_dec(1,:))],'Color','k','LineWidth',1);
   
end
       
hold off

catch
       
end


xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude(\muV for EEG or fT for MEG)')

    set(gca,'fontweight','bold')
 
    try
        
        if(size(cwtfiledata,1) > 1)
            
            saveas(gcf,['Amplitude_CWT_' EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected(elec_wav) '.fig'])
            
        else
            
saveas(gcf,['Amplitude_CWT_' EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected '.fig'])

        end

    catch
       
        if(size(cwtfiledata,1) > 1)
         
            saveas(gcf,['Amplitude_CWT_' EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected(elec_wav)) '.fig'])
            
        else
            
        saveas(gcf,['Amplitude_CWT_' EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected) '.fig'])

        end
        
    end    
 
    close(gcf)
    
    case 4

%Plotting the energy       
 figure
subplot(2,1,1)

        contourf(1000*time_domain,frequency_range,Energy_sum_x(:,:))

          set(gca,'fontweight','bold');
    try
        
        if(size(cwtfiledata,1) > 1)
            
            title(['\bfEnergy of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected(elec_wav)]);   
            
        else
        
    title(['\bfEnergy of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected]);   
   
        end
    
    catch
    
        if(size(cwtfiledata,1) > 1)
           
            title(['\bfEnergy of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected(elec_wav))]);  
            
        else
        
        title(['\bfEnergy of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected)]);   
        
        end
        
    end
    
    xlabel('\bfTime (ms)')
    ylabel('\bfFrequency (Hz)')  
%colorbar

subplot(2,1,2)
plot(1000*time_domain(1,:),x_dec(1,:))

axis tight

try
hold on
   
for trig_count = 1:length(events_trigger)
    
      plot([1000*events_trigger(trig_count) 1000*events_trigger(trig_count)],[min(x_dec(1,:)) max(x_dec(1,:))],'Color','k','LineWidth',1);
   
end

hold off

catch
       
end


xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude(\muV for EEG or fT for EG)')

    set(gca,'fontweight','bold')
 
    try
        
         if(size(cwtfiledata,1) > 1)
             
             saveas(gcf,['Energy_CWT_' EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected(elec_wav) '.fig'])
             
         else
        
saveas(gcf,['Energy_CWT_' EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected '.fig'])

         end

    catch
       
         if(size(cwtfiledata,1) > 1)
            
             saveas(gcf,['Energy_CWT_' EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected(elec_wav)) '.fig'])
             
         else
             
        saveas(gcf,['Energy_CWT_' EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected) '.fig'])

         end
        
    end

    close(gcf)       
        
%Plotting the amplitude
    figure
subplot(2,1,1)

 
        contourf(1000*time_domain,frequency_range,sqrt(Energy_sum_x(:,:)))

          set(gca,'fontweight','bold');
    try
        
        if(size(cwtfiledata,1) > 1)
            
            title(['\bfAmplitude of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected(elec_wav)]); 
            
        else
            
    title(['\bfAmplitude of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected]);   
   
        end
    
    catch
    
        if(size(cwtfiledata,1) > 1)
            
            title(['\bfAmplitude of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected(elec_wav))]);   
            
        else
            
        title(['\bfAmplitude of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected)]);   
           
        end
        
    end
    
    xlabel('\bfTime (ms)')
    ylabel('\bfFrequency (Hz)')  
%colorbar

subplot(2,1,2)
plot(1000*time_domain(1,:),x_dec(1,:))

axis tight

try
hold on
   
 for trig_count = 1:length(events_trigger)
    
      plot([1000*events_trigger(trig_count) 1000*events_trigger(trig_count)],[min(x_dec(1,:)) max(x_dec(1,:))],'Color','k','LineWidth',1);
   
end
       
hold off

catch
       
end


xlabel('\bfTime (ms)')
    ylabel('\bfAmplitude(\muV for EEG or fT for MEG)')

    set(gca,'fontweight','bold')
 
    try
        
         if(size(cwtfiledata,1) > 1)
            
             saveas(gcf,['Amplitude_CWT_' EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected(elec_wav) '.fig'])
             
         else
             
saveas(gcf,['Amplitude_CWT_' EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected '.fig'])

         end

    catch
       
        if(size(cwtfiledata,1) > 1)
           
             saveas(gcf,['Amplitude_CWT_' EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected(elec_wav)) '.fig'])
            
        else
            
        saveas(gcf,['Amplitude_CWT_' EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected) '.fig'])

        end
        
         close(gcf) 
        
    end       
    
    end
    
end

data_exported = [];

data_exported.energy = save_wavelet_data;
data_exported.amplitude = sqrt(save_wavelet_data);
data_exported.wave_form_time_decimated = cwtfiledata;%cwtfiledata_dec;
data_exported.sampling_frequency = sampling_frequency;
data_exported.dec_factor = dec_f;
data_exported.time_domain = 1000*time_domain;
data_exported.frequency_range = frequency_range;
data_exported.low_freq = low_freq;
data_exported.high_freq = high_freq;  
data_exported.labels = electrode_name_selected;

save([EEG_cwt_file_selected(1:end-4) '_Energy_Amplitude_Wavelets.mat'],'data_exported')

cd ..
