function CWT_PLF_Function(EEG_cwt_file_selected,sampling_frequency,startT,endT,cwtfiledata,...
    low_freq,high_freq,electrode_name_selected,dec_fact,condition_chosen_folder,time_domain_temp,step_wav_plf,plot_save_figures_plf,electrode_selected_plf)

%% Building up the mother wavelet
%[rows_signal columns_signal] = size(cwtfiledata);

%length_window = zeros(1,high_freq - low_freq + 1);
length_window = zeros(1,length([low_freq:step_wav_plf:high_freq]));
                                        
if dec_fact > 1
    
    if size(cwtfiledata,3) > 1
%Decimating the data by a factor "dec_fact"
for pp = 1:size(cwtfiledata,1)
  
    for hh = 1:size(cwtfiledata,2)
    
cwtfiledata_dec(pp,hh,:) = resample(squeeze(cwtfiledata(pp,hh,:)),1,dec_fact);
    
    end
end

else
   
     cwtfiledata_dec = resample(cwtfiledata',1,dec_fact)';
    
    end
  
else
    
 cwtfiledata_dec = cwtfiledata; 

end

sampling_frequency = sampling_frequency/dec_fact;

if size(cwtfiledata_dec,3) > 1

    time_domain = [0:size(cwtfiledata_dec,3)-1]/sampling_frequency + time_domain_temp(1);%resample(time_domain_temp,1,dec_fact);
    
else
    
    time_domain = [0:size(cwtfiledata_dec,2)-1]/sampling_frequency + time_domain_temp(1);%resample(time_domain_temp,1,dec_fact);
    
    
end

cwtfiledata = cwtfiledata_dec;

%% Creating a new folder where to save the results
dir_data_eeg = what;
        dir_data_eeg = dir_data_eeg.path;
            dir_save_data_PLF = ['Save_PLF_' condition_chosen_folder];

if (~exist(['Save_PLF_' condition_chosen_folder]))

                    mkdir(dir_save_data_PLF);
                
end

%% Checking if the number of samples is odd or even
if size(cwtfiledata,3) > 1
    
[rows_signal sweeps_recorded columns_signal] = size(cwtfiledata);

else
    
    [sweeps_recorded columns_signal] = size(cwtfiledata);
    rows_signal = 1;
    
end

check_odd_even = mod(columns_signal,2);

if (check_odd_even == 1)

    if size(cwtfiledata,3) > 1
    
        cwtfiledata(:,:,end) = [];
    [rows_signal sweeps_recorded columns_signal] = size(cwtfiledata);
endT = columns_signal;
time_domain(:,end) = [];

    else
       
   cwtfiledata(:,end) = [];
    columns_signal = size(cwtfiledata,2);
    rows_signal = 1;
endT = columns_signal;
time_domain(:,end) = [];     
        
    end

end

if size(cwtfiledata,3) > 1
    
temp_av_data = squeeze(mean(cwtfiledata,2));

else
    
   temp_av_data = (mean(cwtfiledata',2))'; 

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

energy_track = zeros(1,length([low_freq:1:high_freq]));

%This is used to start saving the frequencies from row "1"; for instance,
%if the starting frequency is "20", this line of code will make sure that
%20 Hz will be saved in the first row "j" (starting_point = 19 (20-1) and j = 1 (20-19))
track_freq = 1;
energy_track = zeros(1,length([low_freq:step_wav_plf:high_freq]));

for f0 = low_freq:step_wav_plf:high_freq 
sf = f0/7;
    st = 1/(2*pi*sf);
        A = 1/sqrt(st*sqrt(pi)); %Normalization factor
            %j=f0-starting_point;
  j = track_freq;
            ond(j,:) = A*exp(-t.^2/(2*st^2)).*exp(2*i*pi*f0*t); %Generation of the Mother Wavelet (The Morlet in this case)
             
            ond_signal = ond(j,:);
            
               energy_track(j) =  sum(abs(ond_signal).^2)/fs;
            
               sg(j,:) = fft(ond_signal(1,:))./H;  %Computes FFT of the Mother Wavelet and shift wave back to zero (see Fourier Transform Property)
                
                %ener(j)=sqrt(sum(sg(j,:).*conj(sg(j,:))))/N; %Computes the energy of the wavelet
                        freq(j)=f0;
                        
                        %sg(j,:) = ((fft(ond_signal(1,:))*2)/length(ond_signal))./H;  %Computes FFT of the Mother Wavelet and shift wave back to zero (see Fourier Transform Property)
                
                %ener(j)=sqrt(sum(sg(j,:).*conj(sg(j,:)))); %Computes the energy of the wavelet
            track_freq = track_freq + 1;
                                        
end

%% Plotting the energy at each frequency to make sure they are all = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot([low_freq:step_wav_plf:high_freq],energy_track)

xlabel('\bfFrequency')
ylabel('\bfEnergy')
title(['\bfEnergy of each frequency for each mother wavelet. The mean is: ' num2str(mean(energy_track))])
set(gca,'fontweight','bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
     

%% Extension for the removal of the Border effect 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Creating the extension for the border effect for the signal "x"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
message = ('Calculating the PLF');
msgbox(message,'Calculation in progress...','warn','replace');

if size(cwtfiledata,3) > 1
    
save_wavelet_data = zeros(size(sg,1),size(cwtfiledata,2),size(cwtfiledata,1));

else

  save_wavelet_data = zeros(size(sg,1),size(cwtfiledata,2)); 
    
end

h = waitbar(0,'0','Name','Calculation in progress... Estimated time left (minutes)');

time_left = 0;


%% Calculating the PLF
[r c] = size(sg);
    
tic

save_final_PLF = zeros(rows_signal,r,c);

for ll = 1:rows_signal

    display(['Sensor# ' num2str(ll)]);
    
    Final_PLF = zeros(r,c); %Matrix used to store the energies for each frequency
     
  if size(cwtfiledata(ll,:,:),3) > 1
      
      end_loop = size(cwtfiledata(ll,:,:),2);
    
  else
  
      end_loop = size(cwtfiledata,1);
      
  end
  
    for hh = 1:end_loop       
    
         waitbar(hh/end_loop,h,sprintf('%f',time_left))
        
    if size(cwtfiledata,3) > 1 
        
 x_dec = squeeze(cwtfiledata(ll,hh,:))';       
 
    else
        
     x_dec = cwtfiledata(hh,:);  
 
    end
 
 %border_effect = border_effect;

[rows_dec columns_dec] = size(x_dec);

diff_add_first_sum_x = x_dec (1:border_effect);
diff_add_last_sum_x = x_dec (border_effect + 1:end);

diff_border_sum_x = zeros(rows_dec, columns_dec + border_effect*2);

diff_border_sum_x(rows_dec, 1:border_effect) = diff_add_last_sum_x(:,:);
diff_border_sum_x(rows_dec, columns_dec + 1 + border_effect:border_effect*2 + columns_dec) = diff_add_first_sum_x(:,:);
diff_border_sum_x(rows_dec, border_effect + 1:columns_dec + border_effect) = x_dec(rows_dec,:);
fft_diff_border_sum_x = fft(diff_border_sum_x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
        for k = 1:r
 
                    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Calculating the CWT and the energies for each frequency
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
   
           wmor_sum_x = sg(k,:);
                msig_sum_x = fft_diff_border_sum_x(rows_dec,:);
                      temp_sum_x = wmor_sum_x.*msig_sum_x; 
  temp_sum_x_ifft = ifft(temp_sum_x);
                             
            %Calculating and storing the PLF            
                  
            Final_PLF(k,:) =  Final_PLF(k,:) + (temp_sum_x_ifft./abs(temp_sum_x_ifft)); %Storing the PLF of the "k" frequency
                            
        end

        if (hh == 1)
        
        time_elapsed = toc;
        
        end
  
  time_left = time_elapsed*(end_loop - hh)/60;

    end

    Final_PLF = Final_PLF/hh;
    
    save_final_PLF(ll,:,:) = Final_PLF; 
    
end

close (h)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Removal of the border effect
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Final_PLF = [];

Final_PLF = save_final_PLF(:,:,:);


elimination_border_sum_x = border_effect;

    
Final_PLF(:,:,1:elimination_border_sum_x) = [];


[channels righe_sum colonne_sum] = size(Final_PLF);
Final_PLF(:,:,columns_signal + 1:end) = [];



%% Plotting the phase
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time-Frequency Representation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Creating the range of frequencies with round(high_freq/low_freq) Hz step
frequency_range = [low_freq:step_wav_plf:high_freq];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%frequency_range = frequency_range(end:-1:1);
cd([dir_data_eeg '\' dir_save_data_PLF])

switch plot_save_figures_plf
    
    case 1
       
         display('Figures have neither been plotted nor saved. Only data have been saved')
               
    case 2

%% Plotting and saving the PLF for each channel
for gg = 1:size(Final_PLF,1)
figure

contourf(1000*time_domain,frequency_range,abs(squeeze(Final_PLF(gg,:,:))))
 
 max_value = max(max((abs(squeeze(Final_PLF(gg,:,:))))));
 
 try 
     
 hcb = contourcmap([0:(max_value/30):max_value],...
'jet','colorbar','on','location','vertical');
        %contourf(time_domain,frequency_range,abs(Final_PLF(:,:)))

 catch
     
 end
 
 
          set(gca,'fontweight','bold');
    try
        
        if (size(Final_PLF,1) > 1)
            
    title(['PLF of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected(gg)], 'interpreter', 'none');   
   
        else
            
            title(['PLF of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected(electrode_selected_plf)], 'interpreter', 'none');
        
        end
    
    catch
    
        if (size(Final_PLF,1) > 1)
            
        title(['PLF of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected(gg))], 'interpreter', 'none');   
        
        else
           
            title(['PLF of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected(electrode_selected_plf))], 'interpreter', 'none');   
            
        end
        
    end
    
    axis_properties = get(gca);
    y_axis_prop = axis_properties.YTick;
    set(gca,'YTickLabel',y_axis_prop);
    
    xlabel('\bfTime (s)')
    ylabel('\bfFrequency (Hz)')  
%colorbar
try
    
try
        
    if (size(Final_PLF,1) > 1)
        
        saveas(gcf,[EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected(gg) '_PLF.fig'])
        
    else
        
        saveas(gcf,[EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected(electrode_selected_plf) '_PLF.fig'])
        
    end
    
catch
    
    if (size(Final_PLF,1) > 1)
        
        saveas(gcf,[EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected(gg)) '_PLF.fig'])
        
    else
        
        saveas(gcf,[EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected(electrode_selected_plf)) '_PLF.fig'])
        
    end
    
end
    
catch
    
end

close (gcf)

%% Plotting and saving the PLF and the grand_average
figure
subplot(2,1,1)
%image(time_domain,frequency_range,(abs(Final_PLF(:,:)).^2)*65535)%max(max((abs(Final_PLF(:,:))).^2)))
 %image(time_domain,frequency_range,63*((abs(Final_PLF(:,:)))./max_value))
 contourf(1000*time_domain,frequency_range,abs(squeeze(Final_PLF(gg,:,:))))
 
% hcb = contourcmap([0:(max_value/30):max_value],...
%'jet','colorbar','on','location','vertical')
        %contourf(time_domain,frequency_range,abs(Final_PLF(:,:)))

          set(gca,'fontweight','bold');
          try
              
              if (size(Final_PLF,1) > 1)
                  
                  title(['PLF of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected(gg)], 'interpreter', 'none');
                  
              else
                  
                  title(['PLF of ' EEG_cwt_file_selected(1:end-4) ' ' electrode_name_selected(electrode_selected_plf)], 'interpreter', 'none');
                  
              end
              
          catch
              
              if (size(Final_PLF,1) > 1)
                  
                  title(['PLF of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected(gg))], 'interpreter', 'none');
                  
              else
                  
                  title(['PLF of ' EEG_cwt_file_selected(1:end-4) ' ' cell2mat(electrode_name_selected(electrode_selected_plf))], 'interpreter', 'none');
                  
              end
              
          end
    
       
    set(gca,'YTickLabel',y_axis_prop);
    
    xlabel('\bfTime (s)')
    ylabel('\bfFrequency (Hz)')  
%colorbar

subplot(2,1,2)
plot(1000*time_domain(1,:),temp_av_data(gg,:))

axis tight

xlabel('\bfTime (s)')
    ylabel('\bfAmplitude(uV)')

    set(gca,'fontweight','bold')
 
    try
        
    try
        
        if (size(Final_PLF,1) > 1)
            
saveas(gcf,[EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected(gg) '_PLF_Time.fig'])

        else
        
           saveas(gcf,[EEG_cwt_file_selected(1:end-4) '_' electrode_name_selected(electrode_selected_plf) '_PLF_Time.fig'])
            
        end
        
    catch
       
         if (size(Final_PLF,1) > 1)
             
        saveas(gcf,[EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected(gg)) '_PLF_Time.fig'])

         else
            
             saveas(gcf,[EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected(electrode_selected_plf)) '_PLF_Time.fig']) 
             
         end
        
    end 
    
    catch
        
    end

    close (gcf)
    
end
    
end

data_exported.plf = Final_PLF;
data_exported.wave_form_time_decimated = temp_av_data;
data_exported.sampling_frequency = sampling_frequency;
data_exported.dec_factor = dec_fact;
data_exported.time_domain = 1000*time_domain;
data_exported.frequency_range = frequency_range;
data_exported.low_freq = low_freq;
data_exported.high_freq = high_freq;

if (size(Final_PLF,1) > 1)
    
    data_exported.labels = electrode_name_selected;
    save ([EEG_cwt_file_selected(1:end-4) '_All_Sensors_PLF.mat'],'data_exported')
    
else
    
    data_exported.labels = electrode_name_selected(electrode_selected_plf);
    save ([EEG_cwt_file_selected(1:end-4) '_' cell2mat(electrode_name_selected(electrode_selected_plf)) '_PLF.mat'],'data_exported')
    
end


cd ..




