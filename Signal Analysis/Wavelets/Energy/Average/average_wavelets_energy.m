function average_wavelets_energy(Files_Energ_Ampl_directory,analysis_mode,freq_bin,freq_range,start_point_t,end_point_t,start_point_ss,end_point_ss)

cd(Files_Energ_Ampl_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

average_files_energ_ampl = 0;
average_files_wave_form_dec = 0;
%average_files_original_wave_form = 0;

track_files = 0;

freq_analyzed = [];
freq_chosen = [];

data_exported = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ii = 3:files_number
    
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)

        track_files = track_files + 1;
        
  matrix_file = mat_files(ii).name     
  
  load(matrix_file);
  
  if (analysis_mode == 1)
      
      data_wavelets = data_exported.amplitude;
      
  else
     
      data_wavelets = data_exported.energy;
            
  end
  
  if size(data_wavelets,1) < 2
     
      data_plf = squeeze(data_wavelets(1,:,:));
      
                average_files_energ_ampl = average_files_energ_ampl + data_plf;
            average_files_wave_form_dec = average_files_wave_form_dec + data_exported.wave_form_time_decimated;
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setting the parameters to calcuate the mean PLF for each frequency and for each subject
if (isempty(freq_analyzed))
    
freq_analyzed = data_exported.frequency_range;

track_freq = 1;

for gg = 1:length(freq_range)
   
    try
        
  freq_chosen(track_freq) = find(freq_analyzed >= freq_range(gg),1,'First');  
  
  if (freq_analyzed(freq_chosen(track_freq)) - freq_bin/2 < 1 || freq_analyzed(freq_chosen(track_freq)) + freq_bin/2 > max(freq_analyzed))
      
      freq_chosen(track_freq) = [];
      
  else
      
      track_freq = track_freq + 1;
      
  end
  
    catch
       
                
    end
    
end

if (isempty(freq_chosen))
    
    message = ('The bin/frequencies selected cannot be applied to the selected data. Please, change either the bin or the frequencies');

        msgbox(message,'Operation aborted','warn');

    
    return;
end

save_mean_plf_trans(1,1) = {'File (Region I)'};
save_mean_plf_ss(1,1) = {'File (Region II)'};

for oo = 1:length(freq_chosen)

    save_mean_plf_trans(1,oo + 1) = {freq_analyzed(freq_chosen(oo))};
    save_mean_plf_ss(1,oo + 1) = {freq_analyzed(freq_chosen(oo))};

end

trans_start_samples = find(data_exported.time_domain >= start_point_t,1,'First');
trans_end_samples = find(data_exported.time_domain <= end_point_t,1,'Last');

ss_start_samples = find(data_exported.time_domain >= start_point_ss,1,'First');
ss_end_samples = find(data_exported.time_domain <= end_point_ss,1,'Last');

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%               
                
save_mean_plf_trans(track_files + 1,1) = {matrix_file};
save_mean_plf_ss(track_files + 1,1) = {matrix_file};

temp_data_plf = squeeze(data_wavelets(1,:,:));
    
    for ll = 1:length(freq_chosen) 
    
            
%     save_mean_plf_trans(track_files + 1,ll + 1) = {mean(mean(abs(temp_data_plf(freq_chosen(ll) - freq_bin/2: freq_chosen(ll) + freq_bin/2,trans_start_samples:trans_end_samples))))};
%     save_mean_plf_ss(track_files + 1,ll + 1) = {mean(mean(abs(temp_data_plf(freq_chosen(ll) - freq_bin/2 : freq_chosen(ll) + freq_bin/2,ss_start_samples:ss_end_samples))))};
    
            save_mean_plf_trans(track_files + 1,ll + 1) = {mean(mean(temp_data_plf(freq_chosen(ll) - freq_bin/2: freq_chosen(ll) + freq_bin/2,trans_start_samples:trans_end_samples)))};
    save_mean_plf_ss(track_files + 1,ll + 1) = {mean(mean(temp_data_plf(freq_chosen(ll) - freq_bin/2 : freq_chosen(ll) + freq_bin/2,ss_start_samples:ss_end_samples)))};

end
    
  else
  
      track_name_save = 1;
    
     %% Initializing the matrices where to save the PLF data for the grand average  
  if (track_files == 1)
      
      average_files_energ_ampl = zeros(size(data_wavelets,1),size(data_wavelets,2),size(data_wavelets,3));
      average_files_wave_form_dec = zeros(size(data_exported.wave_form_time_decimated,1),size(data_exported.wave_form_time_decimated,2));
      
      reference_sensors = data_exported.labels;
      reference_sensors_number = size(reference_sensors,1);
      
  end
  
  %Checking if one or more sensors have been removed from the analysis and
  %replace each position with an 'NaN' row. Missing electrodes are checked
  %with respect to the first file analyzed
  current_labels = data_exported.labels;
  
  if (size(current_labels,1) ~= reference_sensors_number)
  
      add_zeros_rows = check_missing_electrodes(reference_sensors,current_labels);

      add_zeros_3Dmatrix = zeros(length(add_zeros_rows),size(data_wavelets,2),size(data_wavelets,3));
        data_wavelets = [data_wavelets(1:add_zeros_rows - 1,:,:);add_zeros_3Dmatrix;data_wavelets(add_zeros_rows:end,:,:)];
    add_zeros_matrix = zeros(length(add_zeros_rows),size(data_wavelets,3));
      data_exported.wave_form_time_decimated = [data_exported.wave_form_time_decimated(1:add_zeros_rows - 1,:);add_zeros_matrix;data_exported.wave_form_time_decimated(add_zeros_rows:end,:)];
  
  end

   
  for hh = 1:size(data_wavelets,1)
  
          average_files_energ_ampl(hh,:,:) = squeeze(average_files_energ_ampl(hh,:,:)) + squeeze(data_wavelets(hh,:,:));
            average_files_wave_form_dec(hh,:) = average_files_wave_form_dec(hh,:) + data_exported.wave_form_time_decimated(hh,:);
                %average_files_original_wave_form = average_files_original_wave_form + data_exported.wave_form_time_original;
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setting the parameters to calcuate the mean PLF for each frequency and for each subject
if(track_files == 1 && hh == 1)
    
freq_analyzed = [];

end

%if (isempty(freq_analyzed))
 if(hh == 1 && track_files == 1)   
     
freq_analyzed = data_exported.frequency_range;

track_freq = 1;

for gg = 1:length(freq_range)
   
    try
        
  freq_chosen(track_freq) = find(freq_analyzed == freq_range(gg));  
  
  if (freq_chosen(track_freq) - freq_bin/2 < 1 || freq_chosen(track_freq) + freq_bin/2 > max(freq_analyzed))
      
      freq_chosen(track_freq) = [];
      
  else
      
      track_freq = track_freq + 1;
      
  end
  
    catch
       
                
    end
    
end

if (isempty(freq_chosen))
    
    message = ('The bin/frequencies selected cannot be applied to the selected data. Please, change either the bin or the frequencies');

        msgbox(message,'Operation aborted','warn');

        return;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save_mean_plf_trans(1,1,1:size(data_wavelets,1)) = {'File (Region I)'};
save_mean_plf_ss(1,1,1:size(data_wavelets,1)) = {'File (Region II)'};

%% Initializing the excel file where the averages will be saved
for oo = 1:length(freq_chosen)

    save_mean_plf_trans(1,oo + 1,:) = {freq_analyzed(freq_chosen(oo))};
    save_mean_plf_ss(1,oo + 1,:) = {freq_analyzed(freq_chosen(oo))};

end

trans_start_samples = find(data_exported.time_domain >= start_point_t,1,'First');
trans_end_samples = find(data_exported.time_domain <= end_point_t,1,'Last');

ss_start_samples = find(data_exported.time_domain >= start_point_ss,1,'First');
ss_end_samples = find(data_exported.time_domain <= end_point_ss,1,'Last');

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%               
    
if (track_name_save == 1)

    save_mean_plf_trans(track_files + 1,1,:) = {matrix_file};
save_mean_plf_ss(track_files + 1,1,:) = {matrix_file};

track_name_save = 0;

end

for ll = 1:length(freq_chosen)

       
%         save_mean_plf_trans(track_files + 1,ll + 1,hh) = {mean(mean(abs(squeeze(data_wavelets(hh,freq_chosen(ll) - freq_bin/2: freq_chosen(ll) + freq_bin/2,trans_start_samples:trans_end_samples)))))};
%         save_mean_plf_ss(track_files + 1,ll + 1,hh) = {mean(mean(abs(squeeze(data_wavelets(hh,freq_chosen(ll) - freq_bin/2 : freq_chosen(ll) + freq_bin/2,ss_start_samples:ss_end_samples)))))};
%         
           
        save_mean_plf_trans(track_files + 1,ll + 1,hh) = {mean(mean(squeeze(data_wavelets(hh,freq_chosen(ll) - freq_bin/2: freq_chosen(ll) + freq_bin/2,trans_start_samples:trans_end_samples))))};
        save_mean_plf_ss(track_files + 1,ll + 1,hh) = {mean(mean(squeeze(data_wavelets(hh,freq_chosen(ll) - freq_bin/2 : freq_chosen(ll) + freq_bin/2,ss_start_samples:ss_end_samples))))};
                

    
end
 
  end 
   
  end 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Averaging the data
    
    mean_trials_average = average_files_energ_ampl/track_files;
        average_files_wave_form_dec = average_files_wave_form_dec/track_files;
            %average_files_original_wave_form = average_files_original_wave_form/track_files;
 
            
%% Plotting the average 
freq_plot = freq_analyzed;

if size(data_wavelets,1) < 2
    
figure
   subplot(2,1,1) 
%contourf(data_exported.time_domain,freq_plot,abs(mean_trials_average))
 contourf(data_exported.time_domain,freq_plot,mean_trials_average)
  
    xlabel('\bfTime (ms)')
    ylabel('\bfFrequency (Hz)')
    
axis tight

if (analysis_mode == 1)
    
title(['\bfAmplitude - Average of ' num2str(track_files) ' files'])

else

   title(['\bfEnergy - Average of ' num2str(track_files) ' files'])
      
end

subplot(2,1,2)

subplot(2,1,2)
plot(data_exported.time_domain,average_files_wave_form_dec)

axis tight

xlabel('\bfTime (ms)')
    
    set(gca,'fontweight','bold')

    if (analysis_mode == 1)
        
        saveas(gcf,['Grand_Average_Amplitude_' num2str(track_files) '_Files.fig'])
        ylabel('\bfAmplitude (muV)')
        
    else
        
       saveas(gcf,['Grand_Average_Energy_' num2str(track_files) '_Files.fig'])
        ylabel('\bfAmplitude (muV^2)')
        
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (analysis_mode == 1)
    
    xlswrite (['Amplitude_' num2str(track_files) '_Files'],save_mean_plf_trans,1)
    xlswrite (['Amplitude_' num2str(track_files) '_Files'],save_mean_plf_ss,2)
    
else
    
    xlswrite (['Energy_' num2str(track_files) '_Files'],save_mean_plf_trans,1)
    xlswrite (['Energy_' num2str(track_files) '_Files'],save_mean_plf_ss,2)
    
end

message = (['The average of ' num2str(track_files) ' files has been calculated and saved']);

        msgbox(message,'Files have been averaged and saved','warn');

else
   
   for kk = 1:size(mean_trials_average,1)

    figure
   subplot(2,1,1) 
%contourf(data_exported.time_domain,freq_plot,abs(squeeze(mean_trials_average(kk,:,:))))
contourf(data_exported.time_domain,freq_plot,squeeze(mean_trials_average(kk,:,:)))
 

    xlabel('\bfTime (ms)')
ylabel('\bfFrequency (Hz)')

axis tight

if (analysis_mode == 1)
    
title(['\bfAmplitude - Average of ' track_files ' files for electrode - ' reference_sensors(kk)])

else
    
    title(['\bfEnergy - Average of ' track_files ' files for electrode - ' reference_sensors(kk)])

end

subplot(2,1,2)
plot(data_exported.time_domain,average_files_wave_form_dec(kk,:))

axis tight

xlabel('\bfTime (ms)')
    %ylabel('\bfAmplitude (\muV)')

    set(gca,'fontweight','bold')

    if (analysis_mode == 1)
        
        saveas(gcf,['Grand_Average_Amplitude_' num2str(track_files) '_Files' cell2mat(reference_sensors(kk)) '.fig'])
        ylabel('\bfAmplitude (muV)')
        
    else
        
        saveas(gcf,['Grand_Average_Energy_' num2str(track_files) '_Files' cell2mat(reference_sensors(kk)) '.fig'])
        ylabel('\bfAmplitude (muV^2)')
        
    end
    
    close (gcf)
    
     if (analysis_mode == 1)
         
         xlswrite (['Amplitude_' cell2mat(reference_sensors(kk)) '_' num2str(track_files)],save_mean_plf_trans(:,:,kk),1)
         xlswrite (['Amplitude_' cell2mat(reference_sensors(kk)) '_' num2str(track_files)],save_mean_plf_ss(:,:,kk),2)

     else
         
         xlswrite (['Energy_' cell2mat(reference_sensors(kk)) '_' num2str(track_files)],save_mean_plf_trans(:,:,kk),1)
         xlswrite (['Energy_' cell2mat(reference_sensors(kk)) '_' num2str(track_files)],save_mean_plf_ss(:,:,kk),2)
         
     end

    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
message = (['The average of ' num2str(track_files) ' files and ' num2str(kk) ' electrodes has been calculated and saved']);

        msgbox(message,'Files have been averaged and saved','warn'); 
    
end

