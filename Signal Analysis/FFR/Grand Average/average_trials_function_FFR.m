function average_trials_function_FFR(Files_Mat_file_directory,Files_Mat_file_selected,standardized_data_check,...
    start_whole_resp,end_whole_resp,start_tran,end_tran,start_ss,end_ss)

clear save_sample;

cd(Files_Mat_file_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

average_files = 0;
average_files_TFS = 0;
track_files = 0;

for ii = 3:files_number
    
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)

        track_files = track_files + 1;
        
  matrix_file = mat_files(ii).name     
  
  load(matrix_file);
  
  try
  
          average_files = average_files + (mean(data_exported.rar_sweeps) + mean(data_exported.compr_sweeps))/2;
          average_files_TFS = average_files_TFS + (mean(data_exported.rar_sweeps) - mean(data_exported.compr_sweeps))/2;
 
  catch

      message = ('The matrix dimension of the files selected must agree. The operation will be aborted and the size of each file will be calculated and saved in a Size_files file');

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
        save_sample(track_files + 1,2) = {size(data_exported.rar_sweeps,2)};
            
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
    mean_trials_average_TFS = average_files_TFS/track_files;
    mean_trials_SE = std(average_files)/sqrt(track_files);



if (standardized_data_check == 1)
    
    mean_trials_average = mapstd(mean_trials_average);
    mean_trials_average_TFS = mapstd(mean_trials_average_TFS);
end


%% Plotting the average for the envelope and fine structure
try
time_dd = 1000*data_exported.time;    

catch
   
    
    time_dd = 1000*[-1:length(mean_trials_average)-2]/data_exported.sampling_frequency - 46.9;
end

for kk = 1:size(mean_trials_average,1)
    
figure
  
subplot(2,1,1)   

plot(time_dd,mean_trials_average(kk,:))
   
    xlabel('\bfTime (ms)')
ylabel('\bfAmplitude (uV)')

axis tight

title(['\bfEnvelope of channel: ' cell2mat(data_exported.channel_trials(kk))])

            
        subplot(2,1,2)
        
        plot(time_dd,mean_trials_average_TFS(kk,:))
   
    xlabel('\bfTime (ms)')
ylabel('\bfAmplitude (uV)')

axis tight

title(['\bfTFS of channel: ' cell2mat(data_exported.channel_trials(kk))])


    saveas(gcf,['Grand_Average_' cell2mat(data_exported.channel_trials(kk)) '.fig'])
        
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculating the FFT for the Transient and SS regions of the Envelope and TFS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Whole response
figure

%whole response
data_whole = mean_trials_average(1,find(time_dd >= start_whole_resp,1,'First'):find(time_dd <= end_whole_resp,1,'Last'));
[P_t F_t] = pwelch(data_whole,length(data_whole),length(data_whole)/2,data_exported.sampling_frequency,data_exported.sampling_frequency);

subplot(3,2,1)
plot(F_t,sqrt(P_t))
xlabel('\bfFrequency(Hz)')
ylabel('\bfuV')
title('\bfWhole response (Frequency domain)')

time_whole = time_dd(1,find(time_dd >= start_whole_resp,1,'First'):find(time_dd <= end_whole_resp,1,'Last'));
subplot(3,2,2)
plot(time_whole,data_whole)
xlabel('\bfTime (ms)')
ylabel('\bfAmplitude (uV)')
title('\bfWhole response (Time domain)')

%Transition response
data_transition = mean_trials_average(1,find(time_dd >= start_tran,1,'First'):find(time_dd <= end_tran,1,'Last'));
[P_t F_t] = pwelch(data_transition,length(data_transition),length(data_transition)/2,data_exported.sampling_frequency,data_exported.sampling_frequency);

subplot(3,2,3)
plot(F_t,sqrt(P_t))
xlabel('\bfFrequency(Hz)')
ylabel('\bfuV')
title('\bfTransition Region (Frequency domain)')

time_trans = time_dd(1,find(time_dd >= start_tran,1,'First'):find(time_dd <= end_tran,1,'Last'));
subplot(3,2,4)
plot(time_trans,data_transition)
xlabel('\bfTime (ms)')
ylabel('\bfAmplitude (uV)')
title('\bfTransition Region (Time domain)')

%Steady-State Region
data_ss = mean_trials_average(1,find(time_dd >= start_ss,1,'First'):find(time_dd <= end_ss,1,'Last'));
[P_s F_s] = pwelch(data_ss,length(data_ss),length(data_ss)/2,data_exported.sampling_frequency,data_exported.sampling_frequency);

subplot(3,2,5)
plot(F_s,sqrt(P_s))
xlabel('\bfFrequency(Hz)')
ylabel('\bfuV')
title('\bfSteady-State Region (Frequency domain)')

time_ss = time_dd(1,find(time_dd >= start_ss,1,'First'):find(time_dd <= end_ss,1,'Last'));
subplot(3,2,6)
plot(time_ss,data_ss)
xlabel('\bfTime (ms)')
ylabel('\bfAmplitude (uV)')
title('\bfSteady-State Region (Time domain)')

%axis([0 0.03 0 1000])

saveas(gcf,['FFT_Envelope_' cell2mat(data_exported.channel_trials(kk)) '.fig'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TFS
%Whole response
figure
data_whole = mean_trials_average_TFS(1,find(time_dd >= start_whole_resp,1,'First'):find(time_dd <= end_whole_resp,1,'Last'));
[P_t F_t] = pwelch(data_whole,length(data_whole),length(data_whole)/2,data_exported.sampling_frequency,data_exported.sampling_frequency);

subplot(3,2,1)
plot(F_t,sqrt(P_t))
xlabel('\bfFrequency(Hz)')
ylabel('\bfuV')
title('\bfWhole response (Frequency domain)')

subplot(3,2,2)
plot(time_whole,data_whole)
xlabel('\bfTime (ms)')
ylabel('\bfAmplitude (uV)')
title('\bfWhole response (Time domain)')

%Transition Region
data_transition = mean_trials_average_TFS(1,find(time_dd >= start_tran,1,'First'):find(time_dd <= end_tran,1,'Last'));
[P_t F_t] = pwelch(data_transition,length(data_transition),length(data_transition)/2,data_exported.sampling_frequency,data_exported.sampling_frequency);

subplot(3,2,3)
plot(F_t,sqrt(P_t))
xlabel('\bfFrequency(Hz)')
ylabel('\bfuV')
title('\bfTransition Region (Frequency domain)')

subplot(3,2,4)
plot(time_trans,data_transition)
xlabel('\bfTime (ms)')
ylabel('\bfAmplitude (uV)')
title('\bfTransition Region (Time domain)')


%Steady-State Region

data_ss = mean_trials_average_TFS(1,find(time_dd >= start_ss,1,'First'):find(time_dd <= end_ss,1,'Last'));
[P_s F_s] = pwelch(data_ss,length(data_ss),length(data_ss)/2,data_exported.sampling_frequency,data_exported.sampling_frequency);

subplot(3,2,5)
plot(F_s,sqrt(P_s))
xlabel('\bfFrequency(Hz)')
ylabel('\bfuV')
title('\bfSteady-State Region (Frequency domain)')

subplot(3,2,6)
plot(time_ss,data_ss)
xlabel('\bfTime (ms)')
ylabel('\bfAmplitude (uV)')
title('\bfSteady-State Region (Time domain)')

saveas(gcf,['FFT_TFS_' cell2mat(data_exported.channel_trials(kk)) '.fig'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sampling_frequency = data_exported.sampling_frequency;

message = (['The average and the FFT of ' num2str(track_files ) ' files and ' num2str(size(data_exported.rar_sweeps,1)*2*track_files) ' sweeps have been calculated and saved']);

        msgbox(message,'Files have been averaged and FFT has been calculated and saved','warn');

clear data_exported

data_exported.average_trials = mean_trials_average;
data_exported.average_sub = mean_trials_average_TFS;
%data_exported.average_SE = mean_trials_SE;
data_exported.sampling_frequency = sampling_frequency;
data_exported.time_average = time_dd;
%data_exported.labels = {'Cz'};

save('Grand_Av.mat','data_exported')


