function DSS_EEG(DSS_EEG_file_directory,start_p1_time,end_p1_time,start_N100_time,end_N100_time,start_P200_time,end_P200_time,...
    file_name_peaks_latencies,sweeps_analysis_DSS,filter_DSS_var,hcf,lcf,order_f,phase_filter)

cd(DSS_EEG_file_directory)

dir_files = dir;

[files_number] = size(dir_files,1);

track_subjects = 0;

for ii = 3:files_number
      
  matrix_file = dir_files(ii).name;
  
  
  if (strcmp(matrix_file(1,end-2:end),'mat') == 1) 
  
      display(['File name: ' matrix_file])
  
      track_subjects = track_subjects + 1;
      
    selected_file = load(matrix_file);
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Preparing the sensors for the scalp map
  load('channel_biosemi_64_sensors');   %Loading the position of the channels

%Reading the channel names to check which ones should be removed from the
%scalp map analysis
pos_sensors_keep = [];
channels_names = selected_file.data_exported.labels;

for kk =1:length(channel_biosemi)
    
temp_chan = {channel_biosemi(kk).labels};

    for (pp = 1:size(channels_names,1))
        
         bb = strcmp(temp_chan,channels_names(pp));
        
        if (bb == 1)
            
            pos_sensors_keep = [pos_sensors_keep;kk];
            
        end
        
    end
    
end


%Removing channels from the analysis(i.e. A1, A2, etc.)
channel_biosemi = channel_biosemi(pos_sensors_keep); 
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
 %If the user selected a number of sweeps > #sweeps collected => use the #sweeps collected   
    if sweeps_analysis_DSS > size(selected_file.data_exported.single_trials,2)
        
        temp_data = selected_file.data_exported.single_trials(:,:,:); 
        
    else
    
        temp_data = selected_file.data_exported.single_trials(:,1:sweeps_analysis_DSS,:); 
  
    end
    
 data_dss = zeros(size(temp_data,3),size(temp_data,1),size(temp_data,2)); 
  clean = zeros(size(temp_data,3),size(temp_data,1),size(temp_data,2)); 
  
  
  %% Checking which channels have been removed
  bad_channels = [];
  
%     for kk = 1:length(selected_file.data_exported.sensors_removed)
%   
%   if (str2num(cell2mat(selected_file.data_exported.sensors_removed(kk,:))) < 33)
%       
%       bad_channels = [bad_channels;str2num(cell2mat(selected_file.data_exported.sensors_removed(kk,:)))];
%       
%   end
%     end

%% Rearrenging the files for the DSS analysis
 %[bb aa] = butter(2,[2 8]/(selected_file.data_exported.sampling_frequency/2));
 
 if (filter_DSS_var == 1)

     [bb_filter aa_filter] = butter(order_f,[hcf lcf]./(selected_file.data_exported.sampling_frequency./2));

 end

   for hh = 1:size(temp_data,2)
       
        temp_data_rearrenge = squeeze(temp_data(:,hh,:))';
        
       %data_dss(:,:,hh) = filter(bb,aa,temp_data_rearrenge);
       data_dss(:,:,hh) = temp_data_rearrenge;
       clean(:,:,hh) = temp_data_rearrenge;
        
   end
    
  
    
%prepare data
%and also calculate autocorrelation matrices
% cmat1 is the sphering autocorrelation matrix
% cmat2 is the biased autocorrelation matrix

% Clearing the variables
clear cmat1;
clear cmat2;

    
    sumch=squeeze(sum(abs(data_dss(:,:,:))));
    
        %data_dss(sumch(1,:)>1e3,:,:)=0;    %It is arbitrary
     
        for ll = 1:size(data_dss,3)
            
            data_dss(sumch(1,:)>1e4,:,ll) = 0;
            
            
            if (filter_DSS_var == 1)
                
                if (phase_filter == 1)
                    
                    data_dss(:,:,ll) = filtfilt(bb_filter,aa_filter,data_dss(:,:,ll));
                    
                else
                    
                    data_dss(:,:,ll) = filter(bb_filter,aa_filter,data_dss(:,:,ll));
                    
                end
                
            end
            
        end
        
        
    inducedclean=unfold(data_dss);
    cmat1(:,:)=inducedclean'*inducedclean;
    evokedclean=sum(data_dss,3);
    cmat2(:,:)=evokedclean'*evokedclean*size(clean,3)^2;


% apply DSS using the average over epochs as a bias function
%cmat2=mean(cmat2,3);cmat1=mean(cmat1,3);
keep2=10.^-13;
keep1=[];
[todss,fromdss,ratio,pwr]=dss0(cmat1,cmat2,keep1,keep2);
%todss=pad02D(todss,bad_channels);

%todss = electrodes x components. That means that if todss is 26x17 => 26 electrodes and 17 components
%fromdss = components x electrodes. That means that if fromdss is 17x26 => 17 components and 26 electrodes

%% Saving the DSS and the rotation matrix of the DSS to be used for future analysis
 warning off
 mkdir('Save_DSS')
 warning on
 
 cd([DSS_EEG_file_directory '\' 'Save_DSS'])
 
 % Saving the DSS
 dss_first_file = fold(unfold(clean(:,:,:))*todss,size(clean,1));   % DSS components
 
 dss_first_file_av = mean(dss_first_file,3);
%  data_exported = [];
%     data_exported.dss = dss_first_file;      
%         data_exported.sampling_frequency = selected_file.data_exported.sampling_frequency;
%             data_exported.rotation_matrix = todss;
%                 save(matrix_file,'data_exported')  
 try

     for kk = 1:size(dss_first_file_av,2)

         labels(kk,1) = {['DSS_' num2str(kk)]};

     end

  data_exported.eeg_data = dss_first_file_av';
    data_exported.average_trials = dss_first_file_av';   
        data_exported.dss = dss_first_file;  
            data_exported.time_average = selected_file.data_exported.time_average;
                data_exported.sampling_frequency = selected_file.data_exported.sampling_frequency;
                    data_exported.rotation_matrix = todss;
                        data_exported.fromdss = fromdss;
                            data_exported.labels = labels;
                                data_exported.labels_sensors = selected_file.data_exported.labels;
                                    data_exported.events_trigger = selected_file.data_exported.events_trigger;
                                        data_exported.events_type = selected_file.data_exported.events_type;
                                
 catch
     
 end
                save([matrix_file '_DSS.mat'],'data_exported')     
 
figure
for kk = 1:3
    subplot(3,1,kk)
topoplot(fromdss(kk,:),channel_biosemi);

title(['\bfScalp Map of the DSS#' num2str(kk) ' - ' matrix_file(1:end-4)])

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(fromdss(:,kk)) max(fromdss(:,kk))])
set(gca,'fontweight','bold')

end
                
  %% Extracting amplitude and latency for the P1-N1-P2 complex
 if (track_subjects == 1)

clear save_P50;
clear save_N100;
clear save_P200;

save_P1(track_subjects,1) = {'File Name (P1)'};
save_P1(track_subjects,2) = {'Amplitude (P1)'};
save_P1(track_subjects,3) = {'Z-score Amplitude (P1)'};
save_P1(track_subjects,4) = {'Latency (P1)'};

save_N100(track_subjects,1) = {'File Name (N100)'};
save_N100(track_subjects,2) = {'Amplitude (N100)'};
save_N100(track_subjects,3) = {'Z-score Amplitude (N100)'};
save_N100(track_subjects,4) = {'Latency (N100)'};

save_P200(track_subjects,1) = {'File Name (P2)'};
save_P200(track_subjects,2) = {'Amplitude (P2)'};
save_P200(track_subjects,3) = {'Z-score Amplitude (P2)'};
save_P200(track_subjects,4) = {'Latency (P2)'};

save_data = [];
save_data_z_score = [];

time_plot_DSS = selected_file.data_exported.time_average;

 end

 [data_dss_peaks_latencies sdataP1 ldataP1 sdataN100 ldataN100 sdataP200 ldataP200] = Analyze_Peaks_DSS(data_exported,start_p1_time,end_p1_time,start_N100_time,end_N100_time,start_P200_time,end_P200_time);
 
 %Extracting the parameters for the z-score
 [data_dss_peaks_latencies_z_score sdataP1_zscore ldataP1_zscore sdataN100_zscore ldataN100_zscore sdataP200_zscore ldataP200_zscore] = Analyze_Peaks_DSS_zscore(data_exported,start_p1_time,end_p1_time,start_N100_time,end_N100_time,start_P200_time,end_P200_time);
 
 save_data = [save_data;data_dss_peaks_latencies];
 save_data_z_score = [save_data_z_score;data_dss_peaks_latencies_z_score];
 
 save_P1(track_subjects + 1,1) = {matrix_file}; 
    save_P1 (track_subjects + 1,2) = {sdataP1'}; 
        save_P1(track_subjects + 1,3) = {sdataP1_zscore'};
            save_P1(track_subjects + 1,4) = {ldataP1'}; 
                save_P1(track_subjects + 1,5) = {ldataP1_zscore'};
 
 save_N100(track_subjects + 1,1) = {matrix_file}; 
    save_N100 (track_subjects + 1,2) = {sdataN100'};  
        save_N100(track_subjects + 1,3) = {sdataN100_zscore'}; 
            save_N100(track_subjects + 1,4) = {ldataN100'};  
                save_N100(track_subjects + 1,5) = {ldataN100_zscore'};
            
 save_P200(track_subjects + 1,1) = {matrix_file}; 
    save_P200 (track_subjects + 1,2) = {sdataP200'}; 
        save_P200 (track_subjects + 1,3) = {sdataP200_zscore'}; 
            save_P200(track_subjects + 1,4) = {ldataP200'};
                save_P200(track_subjects + 1,5) = {ldataP200_zscore'};

                         
 data_exported = [];   
 
        cd ..

  end
  
end

%% Plotting the data
figure
subplot(2,1,1)
plot(1000*time_plot_DSS,save_data')
title('\bfDSS for the single subject');

ylabel('\bfAmplitude (\muV)')
xlabel('\bfTime (ms)')  

set(gca,'fontweight','bold')

subplot(2,1,2)
if size(save_data,1) > 1

    plot(1000*time_plot_DSS,mean(save_data))

else
    
    plot(1000*time_plot_DSS,save_data)
    
end

title('\bfGrand average of DSS across all the subjects');
    
ylabel('\bfAmplitude(\muV)')
xlabel('\bfTime (ms)')  

set(gca,'fontweight','bold')

saveas(gcf,['DSS_Average_' file_name_peaks_latencies '.fig'])

%% Plotting the z-score
figure
subplot(2,1,1)
try

plot(1000*time_plot_DSS,mapstd(save_data)')

catch

    plot(1000*time_plot_DSS,zscore(save_data')')

end

title('\bfZ-score of the DSS for the single subject');

ylabel('\bfAmplitude (\muV)')
xlabel('\bfTime (ms)')  

set(gca,'fontweight','bold')

subplot(2,1,2)
if size(save_data,2) > 1
    
    try

plot(1000*time_plot_DSS,mapstd(save_data)')

    catch

        plot(1000*time_plot_DSS,zscore(save_data')')

    end

else
    
    try

   plot(1000*time_plot_DSS,(mapstd(save_data)))

    catch

        plot(1000*time_plot_DSS,zscore(save_data'))

    end
    
end

title('\bfZ-score of the grand average of DSS across all the subjects');
    
ylabel('\bfAmplitude(\muV)')
xlabel('\bfTime (ms)')  

set(gca,'fontweight','bold')

saveas(gcf,['DSS_Average_z_score_' file_name_peaks_latencies '.fig'])

warning off

%{
xlswrite([file_name_peaks_latencies '_DSS_P1.xls'],save_P1(:,[1 2]),1)
xlswrite([file_name_peaks_latencies '_DSS_P1.xls'],save_P1(:,[1 3]),2)
xlswrite([file_name_peaks_latencies '_DSS_P1.xls'],save_P1(:,[1 4]),3)
xlswrite([file_name_peaks_latencies '_DSS_P1.xls'],save_P1(:,[1 5]),4)

xlswrite([file_name_peaks_latencies '_DSS_N100.xls'],save_N100(:,[1 2]),1)
xlswrite([file_name_peaks_latencies '_DSS_N100.xls'],save_N100(:,[1 3]),2)
xlswrite([file_name_peaks_latencies '_DSS_N100.xls'],save_N100(:,[1 4]),3)
xlswrite([file_name_peaks_latencies '_DSS_N100.xls'],save_N100(:,[1 5]),4)

xlswrite([file_name_peaks_latencies '_DSS_P200.xls'],save_P200(:,[1 2]),1)
xlswrite([file_name_peaks_latencies '_DSS_P200.xls'],save_P200(:,[1 3]),2)
xlswrite([file_name_peaks_latencies '_DSS_P200.xls'],save_P200(:,[1 4]),3)
xlswrite([file_name_peaks_latencies '_DSS_P200.xls'],save_P200(:,[1 5]),4)
%}
xlswrite([file_name_peaks_latencies '_DSS_P1.xls'],save_P1(:,1:4),1)
xlswrite([file_name_peaks_latencies '_DSS_N1.xls'],save_N100(:,1:4),1)
xlswrite([file_name_peaks_latencies '_DSS_P2.xls'],save_P200(:,1:4),1)


warning on


message = 'All the DSS and scalp map have been extracted and saved';

        msgbox(message,'DSS and scalp map saved','warn','replace');




