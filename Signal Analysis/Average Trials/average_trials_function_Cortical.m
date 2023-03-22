function average_trials_function_Cortical(Files_Mat_file_directory,Files_Mat_file_selected,standardized_data_check,fft_check)

clear save_sample;

cd(Files_Mat_file_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

average_files = 0;

track_files = 0;

for ii = 3:files_number
    
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)

        track_files = track_files + 1;
        
  matrix_file = mat_files(ii).name;      
  
 display(['File name: ' matrix_file]);
  
  load(matrix_file);
  
  try
  
      temp_data_av = data_exported.average_trials;
      
      if size(temp_data_av,1) > size(temp_data_av,2) 
          
          temp_data_av = temp_data_av';
          
      end
      
          average_files = average_files + temp_data_av;
          
          catch

      message = ('The matrix dimension of the files selected must agree. The operation will be aborted and the size of each file will be calculated and saved in a file named: Size_files');

        msgbox(message,'Operation aborted','warn');
      

        track_files = 0;

        save_sample(1,1) = {'File Name'};
        save_sample(1,2) = {'Size vector'};
        
for zz = 3:files_number
    
    if (strcmp(mat_files(zz).name(end-3:end), '.mat') == 1)

        track_files = track_files + 1;
        
  matrix_file = mat_files(zz).name;      
  
  load(matrix_file);
        
  save_sample(track_files + 1,1) = {matrix_file};
        save_sample(track_files + 1,2) = {size(data_exported.average_trials,1)};
            
    end
    
end

xlswrite ('Size_files',save_sample)

close(gcf)

message = ('The size of each file has been calculated and saved');

        msgbox(message,'Operation completed','warn');

        return;
        
  end
          
  end
  
      
end

%% Averaging the data
    
    mean_trials_average = average_files/track_files;
    

if (standardized_data_check == 1)
    
    mean_trials_average = mapstd(mean_trials_average);
    
end


%% Plotting the average     
figure
    
plot(1000*data_exported.time_average,mean_trials_average')
   
    xlabel('\bfTime (ms)')
ylabel('\bfAmplitude (uV)')

axis tight

%title(['\bfAverage of channel: ' cell2mat(data_exported.channel_trials(1))])

    %saveas(gcf,['Grand_Average_' cell2mat(data_exported.channel_trials(1)) '.fig'])
    
    title('\bfGrand average of all the channels')

        legend(data_exported.labels)
    
            saveas(gcf,'Grand_Average_All_Channels.fig')
        
    close(gcf)
    
    if fft_check == 1

        [Pxx Freq] = pwelch(mean_trials_average',[],[],[],data_exported.sampling_frequency);
        figure
        
        plot(Freq,Pxx)
        
        xlabel('\bfFrequency (Hz)')
ylabel('\bfPower Spectral Density (uV)')

axis tight

%title(['\bfFF of channel: ' cell2mat(data_exported.channel_trials(1))])


    %saveas(gcf,['FFT_Grand_Average_' cell2mat(data_exported.channel_trials(1)) '.fig'])
    
    title('\bfFFT all channels')

        legend(data_exported.labels)
    
            saveas(gcf,'FFT_Grand_Average_All_Channels.fig')

                close(gcf)
    
    end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

time_gand_av = data_exported.time_average;
sampling_frequency = data_exported.sampling_frequency;
labels = data_exported.labels;

total_sweeps = cell2mat(data_exported.trials_samples_extracted);
message = (['The average of ' num2str(track_files) ' files and ' num2str(total_sweeps(1)*track_files) ' sweeps have been calculated and saved']);

clear data_exported

data_exported.average_trials = mean_trials_average;
data_exported.time = time_gand_av;
data_exported.sampling_frequency = sampling_frequency;
data_exported.labels = labels;

save('Grand_Av.mat','data_exported')

 msgbox(message,'Files have been averaged and saved','warn');


