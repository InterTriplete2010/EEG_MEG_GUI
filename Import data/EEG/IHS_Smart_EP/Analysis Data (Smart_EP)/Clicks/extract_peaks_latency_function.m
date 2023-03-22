function extract_peaks_latency_function(IHS_file_directory,lf_buttw_filt,hf_buttw_filt,order_buttw_filt,check_filter)

calcuate_transfer_function = 1;

cd(IHS_file_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

%Matrix where to save the peaks
save_picks = cell(1,17);

save_picks(1,1) = {'File Name'};

save_picks(1,2) = {'I Left'};
save_picks(1,3) = {'II Left'};
save_picks(1,4) = {'III Left'};
save_picks(1,5) = {'IV Left'};
save_picks(1,6) = {'V Left'};
save_picks(1,7) = {'VI Left'};
save_picks(1,8) = {'VII Left'};
save_picks(1,9) = {'VIII Left'};

save_picks(1,10) = {'I Right'};
save_picks(1,11) = {'II Right'};
save_picks(1,12) = {'III Right'};
save_picks(1,13) = {'IV Right'};
save_picks(1,14) = {'V Right'};
save_picks(1,15) = {'VI Right'};
save_picks(1,16) = {'VII Right'};
save_picks(1,17) = {'VIII Right'};

track_files = 2;

for ii = 3:files_number
    
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)

  matrix_file = mat_files(ii).name;      
  
  save_picks(track_files,1) = {[matrix_file(1:end-4) '_Latency']};
  save_picks(track_files + 1,1) = {[matrix_file(1:end-4) '_Amplitude']};
  
  load(matrix_file);
  
  if (check_filter == 1)
      
  if (calcuate_transfer_function == 1)
      
      [b,a] = butter(order_buttw_filt,[lf_buttw_filt hf_buttw_filt]/(data_exported.sampling_frequency/2)); 

      calcuate_transfer_function = 0;
  
      check_stability(b,a);
      
  end
  
  end
  
  if (check_filter == 1)
    
      average_sweeps_filtered = filtfilt(b,a,data_exported.grand_av);
  
  else
      
    average_sweeps_filtered = data_exported.grand_av;
  
  end
  
  [pks,locs] = findpeaks(average_sweeps_filtered,'MinPeakProminence',0.01);
  
  find_locs_positive = find(locs > data_exported.time_zero_position);
  
  %Removing local minmum that occurs before 1ms and removing that local
  %minimum
  find_local_max_before_1ms = find(data_exported.time(locs(find_locs_positive)) < 0.7);
  find_locs_positive(find_local_max_before_1ms) = [];
  
  figure
  plot(data_exported.time,average_sweeps_filtered); hold on;
plot(data_exported.time(locs(find_locs_positive)),pks(find_locs_positive)+0.01,'k^','markerfacecolor',[1 0 0]);

xlabel('\bfTime(ms)')
  ylabel('\bfAmplitue(uV)')
    title(['\bfPeaks of the ' data_exported.ear(1) ' Ear'])
  
    set(gca,'fontweight','bold')
  
    time_onset = data_exported.time_zero_position;     
    axis ([0 10 (min(average_sweeps_filtered(1,time_onset:end)) - 0.05) (max(average_sweeps_filtered(1,time_onset:end)) + 0.05)])
    
    try
  %Labeling the peaks
  text(data_exported.time(locs(find_locs_positive(1))),pks(find_locs_positive(1))+0.02,'I')
  text(data_exported.time(locs(find_locs_positive(2))),pks(find_locs_positive(2))+0.02,'II')
  text(data_exported.time(locs(find_locs_positive(3))),pks(find_locs_positive(3))+0.02,'III')
  text(data_exported.time(locs(find_locs_positive(4))),pks(find_locs_positive(4))+0.02,'IV')
  text(data_exported.time(locs(find_locs_positive(5))),pks(find_locs_positive(5))+0.02,'V')
  text(data_exported.time(locs(find_locs_positive(6))),pks(find_locs_positive(6))+0.02,'VI')
  text(data_exported.time(locs(find_locs_positive(7))),pks(find_locs_positive(7))+0.02,'VII')
  text(data_exported.time(locs(find_locs_positive(8))),pks(find_locs_positive(8))+0.02,'VIII')
  
    catch
  
  line(data_exported.time(data_exported.time_zero_position + 1), [min(average_sweeps_filtered):0.001:max(average_sweeps_filtered)])
  
    end
   
    if (length(find_locs_positive) > 8)
        
        length_data = 8;
        
    else
        
        length_data = length(find_locs_positive);
        
    end
    
  %Saving the peaks  
    if (strcmp(data_exported.ear,'Left') == 1)
        
        save_picks(track_files,2:length_data) = num2cell(data_exported.time(locs(find_locs_positive(1:length_data))));
    save_picks(track_files + 1,2:length_data) = num2cell(pks(find_locs_positive(1:length_data)));
    else
        
        save_picks(track_files,10:9 + length_data) = num2cell(data_exported.time(locs(find_locs_positive(1:length_data))));
        save_picks(track_files + 1,10:9 + length_data) = num2cell(pks(find_locs_positive(1:length_data)));
    end
  
min_peak = zeros(1,size(data_exported.odd_even_sweeps,2));
max_peak = zeros(1,size(data_exported.odd_even_sweeps,2));

%min_peak = min(min(min(squeeze(data_exported.odd_even_sweeps(:,:,time_onset:end)))));
%max_peak = max(max(max(squeeze(data_exported.odd_even_sweeps(:,:,time_onset:end)))));
    
%axis ([0 10 min_peak max_peak])
    
    
    saveas(gcf,['Peaks_' cell2mat(data_exported.ear(1)) '_' matrix_file(1:end-4) '.fig'])
%saveas(gcf,['Peaks_' data_exported.ear '.png'])   

%% Plotting the individual trials to check clicks consistency
figure
curr_fig = gcf;

for kk = 1:size(data_exported.odd_even_sweeps,2)
    
    figure(curr_fig)
    
    vect_color = randi(255,1,3)/255; %Randomly assigning a color to each waveform
    
    if (check_filter == 1)
        
        plot(data_exported.time,filtfilt(b,a,mean(squeeze(data_exported.odd_even_sweeps(:,kk,:)))'),'Color',vect_color)
        
        min_peak(1,kk) = min(filtfilt(b,a,mean(squeeze(data_exported.odd_even_sweeps(:,kk,time_onset:end)))'));
        max_peak(1,kk) = max(filtfilt(b,a,mean(squeeze(data_exported.odd_even_sweeps(:,kk,time_onset:end)))'));
        
    else
        
        plot(data_exported.time,mean(squeeze(data_exported.odd_even_sweeps(:,kk,:)))','Color',vect_color)
        
        min_peak(1,kk) = min(mean(squeeze(data_exported.odd_even_sweeps(:,kk,time_onset:end)))');
        max_peak(1,kk) = max(mean(squeeze(data_exported.odd_even_sweeps(:,kk,time_onset:end)))');
        
    end
    
    xlabel('\bfTime(ms)')
    ylabel('\bfAmplitue(uV)')
    
    hold on
    
end

hold off

title(['\bfClicks of file ' matrix_file])
set(gca,'fontweight','bold')

axis ([0 10 min(min_peak) max(max_peak)])

saveas(gcf,['Clicks_Trials_File_' matrix_file(1:end-4) '.fig'])

track_files = track_files + 2;

    end
    
end
xlswrite ('Peaks',save_picks)


