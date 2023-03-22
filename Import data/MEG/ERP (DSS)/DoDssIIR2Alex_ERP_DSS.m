function DoDssIIR2Alex_ERP_DSS(DSS_MEG_file_directory,start_p1_time,end_p1_time,start_N100_time,end_N100_time,start_P200_time,end_P200_time,file_name_peaks_latencies)

%In this version of DoDSS, both autocorrelation matrices are calculated as
%the mean of the autocorrelation matrices in different experiment conditions
%This code has been modified to work on Event-related Potentials (ERPs)

cd(DSS_MEG_file_directory)

dir_files = dir;

[files_number] = size(dir_files,1);

track_subjects = 0;

for ii = 3:files_number
    
    matrix_file = dir_files(ii).name
    
    if (strcmp(matrix_file(1,end-2:end),'mat') == 1)
        
        track_subjects = track_subjects + 1;
        
        selected_file = load(matrix_file);
        
        temp_data = [];
        temp_data_rearrenge = [];
        
        try
            
            temp_data = selected_file.data_exported.single_trials(:,:,:);
            
            data_dss = zeros(size(selected_file.data_exported.single_trials,3),size(selected_file.data_exported.single_trials,1),size(selected_file.data_exported.single_trials,2));
            clean = zeros(size(selected_file.data_exported.single_trials,3),size(selected_file.data_exported.single_trials,1),size(selected_file.data_exported.single_trials,2));
            
            %% Checking which channels have been removed
            temp_chan_active = zeros(1,length(selected_file.data_exported.labels));
            
            for chan_conversion = 1:length(selected_file.data_exported.labels)
                
                temp_chan_active(chan_conversion) = str2double(cell2mat(selected_file.data_exported.labels(chan_conversion,1)));
                
            end
            
            chan_MEG = (1:192);
            
            bad_channels = [];
            
            
            if ~isfield(selected_file.data_exported,'sensors_removed') == 1
                
                chan_removed = setdiff(chan_MEG,temp_chan_active);
                
                for tt = 1:length(chan_removed)
                    
                    
                    
                    selected_file.data_exported.sensors_removed(tt) = {chan_removed(tt)};
                    
                    
                    
                end
                             
                
                selected_file.data_exported.sensors_removed = selected_file.data_exported.sensors_removed';
                               
            end                                  
            
            for kk = 1:length(selected_file.data_exported.sensors_removed)
                
                
                if (str2num(cell2mat(selected_file.data_exported.sensors_removed(kk,:))) < 158)
                      
                    
                    bad_channels = [bad_channels;str2num(cell2mat(selected_file.data_exported.sensors_removed(kk,:)))];
                    
                end
                
            end
            
            
            %% Rearrenging the files for the DSS analysis
            for hh = 1:size(temp_data,2)
                
                temp_data_rearrenge = squeeze(temp_data(:,hh,:))';
                
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
            
            data_dss(:,sumch(1,:)>1e5)=0;    %It is arbitrary
            
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
            
            %% Plotting the scalp map for each DSS to check which one is auditory
            for auditory_DSS = 1:6
                headmap=padN(fromdss(auditory_DSS,:),bad_channels);
                headmap(bad_channels)=0;
                STDheadmap=std(headmap(~isnan(headmap)));
                headmap=headmap./STDheadmap;
                headmap(bad_channels) = NaN;
                
                figure;megtopoplot(headmap);%*sign(headmap(97)));
                
                warning off
                mkdir('Save_Scalp_Maps')
                warning on
                
                cd([DSS_MEG_file_directory '\' 'Save_Scalp_Maps'])
                
                saveas(gcf,['DSS_' matrix_file '_' num2str(auditory_DSS) '.fig'])
                
                fig_tag = gcf;
                close(fig_tag)
                
                cd ..
                
            end
            
            %clear *clean
            %pause
            
            %% Saving the DSS and the rotation matrix of the DSS to be used for future analysis
            warning off
            mkdir('Save_DSS')
            warning on
            
            cd([DSS_MEG_file_directory '\' 'Save_DSS'])
            
            % Saving the DSS
            dss_first_file = fold(unfold(clean(:,:,:))*todss,size(clean,1));   % DSS components
            
            dss_first_file_av = mean(dss_first_file,3);
            
            
            data_exported.average_trials = dss_first_file_av';
            data_exported.dss = dss_first_file;
            data_exported.time_average = selected_file.data_exported.time_average;
            data_exported.sampling_frequency = selected_file.data_exported.sampling_frequency;
            data_exported.rotation_matrix = todss;
            data_exported.labels = selected_file.data_exported.labels;
            data_exported.events_trigger = selected_file.data_exported.events_trigger;
            data_exported.events_type = selected_file.data_exported.events_type;
            save([matrix_file '_DSS.mat'],'data_exported','-v7.3')
            
            %% Extracting amplitude and latency for the P1-N1-P2 complex
            if (track_subjects == 1)
                
                clear save_P50;
                clear save_N100;
                clear save_P200;
                
                save_P1(track_subjects,1) = {'File Name (P1)'};
                save_P1(track_subjects,2) = {'Amplitude (P1)'};
                save_P1(track_subjects,3) = {'Z-score Amplitude (P1)'};
                save_P1(track_subjects,4) = {'Latency (P1)'};
                save_P1(track_subjects,5) = {'Latency Z-Score (P1)'};
                
                save_N100(track_subjects,1) = {'File Name (N100)'};
                save_N100(track_subjects,2) = {'Amplitude (N100)'};
                save_N100(track_subjects,3) = {'Z-score Amplitude (N100)'};
                save_N100(track_subjects,4) = {'Latency (N100)'};
                save_N100(track_subjects,5) = {'Latency Z-Score (N100)'};
                
                save_P200(track_subjects,1) = {'File Name (P2)'};
                save_P200(track_subjects,2) = {'Amplitude (P2)'};
                save_P200(track_subjects,3) = {'Z-score Amplitude (P2)'};
                save_P200(track_subjects,4) = {'Latency (P2)'};
                save_P200(track_subjects,5) = {'Latency Z-Score (P2)'};
                
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
            
        catch
            
        end
        
    end
    
    
end

%% Plotting the data
figure
subplot(2,1,1)
plot(1000*time_plot_DSS,save_data')
title('\bfDSS for the single subject');

ylabel('\bfAmplitude (fT)')
xlabel('\bfTime (ms)')

set(gca,'fontweight','bold')

subplot(2,1,2)
if (size(save_data,1) > 1)
    
plot(1000*time_plot_DSS,mean(save_data))

else
 
    plot(1000*time_plot_DSS,save_data)
    
end

title('\bfGrand average of DSS across all the subjects');

ylabel('\bfAmplitude(fT)')
xlabel('\bfTime (ms)')

set(gca,'fontweight','bold')

saveas(gcf,['DSS_Average_' file_name_peaks_latencies '.fig'])

%% Plotting the z-score
figure
subplot(2,1,1)
plot(1000*time_plot_DSS,mapstd(save_data)')
title('\bfDSS for the single subject');

ylabel('\bfZ-score Amplitude (fT)')
xlabel('\bfTime (ms)')

set(gca,'fontweight','bold')

subplot(2,1,2)
if (size(save_data,1) > 1)
 
plot(1000*time_plot_DSS,zscore(mean(save_data)'))

else
   
 plot(1000*time_plot_DSS,zscore(save_data')')  
    
end

title('\bfGrand average of DSS across all the subjects');

ylabel('\bfZ-score Amplitude (fT)')
xlabel('\bfTime (ms)')

set(gca,'fontweight','bold')

saveas(gcf,['DSS_Average_z_score_' file_name_peaks_latencies '.fig'])

warning off

xlswrite(['DSS_P1_' file_name_peaks_latencies],save_P1(:,[1 2]),1)
xlswrite(['DSS_P1_' file_name_peaks_latencies],save_P1(:,[1 3]),2)
xlswrite(['DSS_P1_' file_name_peaks_latencies],save_P1(:,[1 4]),3)
xlswrite(['DSS_P1_' file_name_peaks_latencies],save_P1(:,[1 5]),4)

xlswrite(['DSS_N100_' file_name_peaks_latencies],save_N100(:,[1 2]),1)
xlswrite(['DSS_N100_' file_name_peaks_latencies],save_N100(:,[1 3]),2)
xlswrite(['DSS_N100_' file_name_peaks_latencies],save_N100(:,[1 4]),3)
xlswrite(['DSS_N100_' file_name_peaks_latencies],save_N100(:,[1 5]),4)

xlswrite(['DSS_P200_' file_name_peaks_latencies],save_P200(:,[1 2]),1)
xlswrite(['DSS_P200_' file_name_peaks_latencies],save_P200(:,[1 3]),2)
xlswrite(['DSS_P200_' file_name_peaks_latencies],save_P200(:,[1 4]),3)
xlswrite(['DSS_P200_' file_name_peaks_latencies],save_P200(:,[1 5]),4)

warning on

message = 'All the DSS and scalp map have been extracted and saved';

msgbox(message,'DSS and scalp map saved','warn','replace');

