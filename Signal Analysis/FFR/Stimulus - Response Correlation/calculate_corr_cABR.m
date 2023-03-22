function calculate_corr_cABR(stimulus_wave,mat_file_directory_corr_plot, ...
                      freq_stim_wave,order_buttw_filt,lf_buttw_filt,hf_buttw_filt,phase_filter_analysis,filter_check,extract_env_resp,select_window_user,start_t,end_t, ...
                      handles,dist_peaks,height_peaks)

%% Uploadind the responses for each subject

cd(mat_file_directory_corr_plot)

dir_files = dir;

[files_number] = size(dir_files,1);
track_subjects = 0;

clear save_corr

save_corr(1,1) = {'File Name'};
save_corr(1,2) = {'Max Correlation value'};
save_corr(1,3) = {'Max Correlation value (Fisher)'};
save_corr(1,4) = {'Max Lag (ms)'};
save_corr(1,5) = {'Mean Periodicity (ms)'};


save_fig = [];

for ii = 3:files_number
              
  matrix_file = dir_files(ii).name;      
  
  if (strcmp(matrix_file(1,end-2:end),'fig') == 1) 
  
      track_subjects = track_subjects + 1;
     
      save_corr(track_subjects + 1,1) = {matrix_file};
      
    open(matrix_file)

    pause(0.1)
    
  subplot(3,2,1);
  
  fig_I_tag = get(gca,'Children');
  
  temp_data = get(fig_I_tag(end));
  
  if (extract_env_resp == 1)
  
      save_fig = [save_fig;abs(hilbert(temp_data.YData))];
    
  else
     
      try
      
      save_fig = [save_fig;temp_data.YData];
      
      catch
         
          message = 'Data must have the same size. Please, check the figures to make sure that the waveforms match in duration.';
msgbox(message,'Operation aborted.','warn','replace');

return;

      end
      
  end
      
      close(gcf)
      
  end
  
end

%% Calculate the correlation for each lag
time_resp = temp_data.XData;

%sampl_freq = 16384;
sampl_freq = 1000*(1./diff(time_resp(1:2)));
set(handles.SF_FFR,'String',sampl_freq);

%% Extracting the envelope of the stimulus
env_stim = abs(hilbert(stimulus_wave));

%Building the transfer function for the filter
if (filter_check == 1)

    [b,a] = butter(order_buttw_filt,[lf_buttw_filt hf_buttw_filt]/(freq_stim_wave/2));

    if (phase_filter_analysis == 1)
        
        filt_env = filtfilt(b,a,env_stim);

    else
        
        filt_env = filter(b,a,env_stim);
        
    end
    
else
   
   filt_env = env_stim; 
    
end


ds_da = resample(filt_env,round(sampl_freq),freq_stim_wave);

new_tt = 1000*[0:length(ds_da) - 1]/sampl_freq;

ds_da_analysis = [];

if (select_window_user == 1)
   
   keep_time_s = find(time_resp >= start_t,1,'First');
keep_time_e = find(time_resp <= end_t,1,'Last');

save_fig = save_fig(:,keep_time_s:keep_time_e); 

end

ds_da_analysis = ds_da;

 if(size(save_fig,2) > length(ds_da_analysis))
      
       message = 'The length of the selected time window must be smaller than the length of the auditory stimulus. Please, change the values of the time window and re-run the analysis';
msgbox(message,'Operation aborted','warn','replace');
       
       return;
       
   end

dist_peaks_samples = round(dist_peaks*sampl_freq/1000);

for hh = 1:size(save_fig,1)
               
da_corr = [];

for yy = 0:size(ds_da_analysis,2) - size(save_fig,2)
   
    da_corr(yy+1) = corr2(ds_da_analysis(1,1 + yy:size(save_fig(hh,:),2) + yy),save_fig(hh,:));
    
end
       
    save_corr(hh + 1,2) = {max(da_corr)};

    save_corr(hh + 1,3) = {0.5*(log(1+max(da_corr)) - log(1-max(da_corr)))};
    max_corr = max(da_corr);
    max_lag = find(max_corr == da_corr);
    
    save_corr(hh + 1,4) = {max_lag./sampl_freq};
    [pks,locs] = findpeaks(da_corr,'MinPeakDistance',dist_peaks_samples,'MinPeakHeight',height_peaks);
    
    if(length(locs) > 1)
        
    save_corr(hh + 1,5) = {1000*mean(diff(locs./sampl_freq))};
    
    else
        
      save_corr(hh + 1,5) = {1000*locs./sampl_freq}; 
    
    end
    
end

xlswrite ('Corr_Stimulus_Response.xls',save_corr);
 
message = 'The correlation stimulus-response has been calculated.';
msgbox(message,'End of the analysis.','warn','replace');

