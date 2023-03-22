function extract_peaks_latency_function_right_left_ear(IHS_file_directory_Right,IHS_file_selected_Right,IHS_file_directory_Left,IHS_file_selected_Left,lf_buttw_filt,hf_buttw_filt,order_buttw_filt,check_filter)

clear save_picks;

%Matrix where to save the peaks
save_picks = cell(3,9);

save_picks(1,2) = {'I Right - Left'};
save_picks(1,3) = {'II Right - Left'};
save_picks(1,4) = {'III Right - Left'};
save_picks(1,5) = {'IV Right - Left'};
save_picks(1,6) = {'V Right - Left'};
save_picks(1,7) = {'VI Right - Left'};
save_picks(1,8) = {'VII Right - Left'};
save_picks(1,9) = {'VIII Right - Left'};

save_picks(1,1) = {'Measurement'};
save_picks(2,1) = {'Latency (ms)'};
save_picks(3,1) = {'Amplitude (uV)'};

 
%% Uploading the right ear
  cd(IHS_file_directory_Right)
  right_ear_struct = load(IHS_file_selected_Right);
  right_ear_data = right_ear_struct.data_exported.grand_av;
  
%% Uploading the left ear
  cd(IHS_file_directory_Left)
  left_ear_struct = load(IHS_file_selected_Left);
  left_ear_data = left_ear_struct.data_exported.grand_av;      
  
  if (check_filter == 1)
      
      [b,a] = butter(order_buttw_filt,[hf_buttw_filt lf_buttw_filt]/(left_ear_struct.data_exported.sampling_frequency/2));
      
      check_stability(b,a);
      
  end
  
   if (check_filter == 1)
    
      right_ear_data = filtfilt(b,a,right_ear_data);
      left_ear_data = filtfilt(b,a,left_ear_data);
  
   end
  
    average_sweeps_diff = left_ear_data - right_ear_data;
  
  
  [pks,locs] = findpeaks(average_sweeps_diff,'MinPeakProminence',0.01);
  
  find_locs_positive = find(locs > right_ear_struct.data_exported.time_zero_position);
  
  %Removing local minmum that occurs before 1ms 
  find_local_max_before_1ms = find(right_ear_struct.data_exported.time(locs(find_locs_positive)) < 0.7);
  find_locs_positive(find_local_max_before_1ms) = [];
  
  figure
  plot(right_ear_struct.data_exported.time,average_sweeps_diff); hold on;
plot(right_ear_struct.data_exported.time(locs(find_locs_positive)),pks(find_locs_positive)+0.01,'k^','markerfacecolor',[1 0 0]);

xlabel('\bfTime(ms)')
  ylabel('\bfAmplitue(uV)')
    title(['\bfPeaks of the Right - Left Ear'])
  
    set(gca,'fontweight','bold')
  
    try
  %Labeling the peaks
  text(right_ear_struct.data_exported.time(locs(find_locs_positive(1))),pks(find_locs_positive(1))+0.02,'I')
  text(right_ear_struct.data_exported.time(locs(find_locs_positive(2))),pks(find_locs_positive(2))+0.02,'II')
  text(right_ear_struct.data_exported.time(locs(find_locs_positive(3))),pks(find_locs_positive(3))+0.02,'III')
  text(right_ear_struct.data_exported.time(locs(find_locs_positive(4))),pks(find_locs_positive(4))+0.02,'IV')
  text(right_ear_struct.data_exported.time(locs(find_locs_positive(5))),pks(find_locs_positive(5))+0.02,'V')
  text(right_ear_struct.data_exported.time(locs(find_locs_positive(6))),pks(find_locs_positive(6))+0.02,'VI')
  text(right_ear_struct.data_exported.time(locs(find_locs_positive(7))),pks(find_locs_positive(7))+0.02,'VII')
  text(right_ear_struct.data_exported.time(locs(find_locs_positive(8))),pks(find_locs_positive(8))+0.02,'VIII')
  
    catch
  
  line(right_ear_struct.data_exported.time(right_ear_struct.data_exported.time_zero_position + 1), [min(average_sweeps_diff):0.001:max(average_sweeps_diff)])
  
    end
   
    if (length(find_locs_positive) > 8)
        
        length_data = 8;
        
    else
        
        length_data = length(find_locs_positive);
        
    end
    
  %Saving the latency and amplitude of the peaks     
        save_picks(2,2:length_data + 1) = num2cell(right_ear_struct.data_exported.time(locs(find_locs_positive(1:length_data))));
        save_picks(3,2:length_data + 1) = num2cell(pks(find_locs_positive(1:length_data)));
        
    axis([0 10 min(average_sweeps_diff) - 0.1 max(average_sweeps_diff) + 0.1])
    saveas(gcf,['Peaks_Right_Left.fig'])
%saveas(gcf,['Peaks_' data_exported.ear '.png'])   


xlswrite ('Peaks_Right_Left.xls',save_picks)
