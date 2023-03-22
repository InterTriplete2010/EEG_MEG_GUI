function DoDssIIR2Alex_Single_Trial_Forward(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1,wav_file_directory, ...
    wav_file_selected,mat_file_directory,n_components,wav_file_selected_noise,wav_file_directory_noise,SF_MEG_Data,...
    time_shift_DSS,Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

%In this version of DoDSS, both autocorrelation matrices are calculated as
%the mean of the autocorrelation matrices in different experiment
%conditions
%created by Nai 03/09
%calculate the covariance matrix block by block, modified by Nai 06/23/09
%based on the trial rejection code to select channels, modified by Nai 07/03/09

% S------filter design
clear x;
clear y;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%FIR filter to process the Raw MEG data
%b = fir1(Forder,[freqL freqH]/(SF_MEG_Data/2));
%a = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

%IIR filter to process the DSS data
[b_DSS1,a_DSS1] = butter(order_DSS1,[Freq_Low_DSS1 Freq_High_DSS1]/(SF_MEG_Data/2)); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Uploading the directory with the stimulus and extracting the envelope for decoding  
 cd(wav_file_directory)
 
     [y, Fs] = audioread(wav_file_selected); 
 
%Extracting the envelope of the sound wave
y_to_dec = y';

y_hilb = hilbert(y_to_dec);
env_temp = abs(y_hilb);

[b_env,a_env] = butter(order_DSS1,[Freq_Low_DSS1 Freq_High_DSS1]/(Fs/2)); 

if (Filter_Auditory_Stim == 1)
    
if zero_phase_menu == 1

    env = filtfilt(b_env,a_env,env_temp);

else
    
env = filter(b_env,a_env,env_temp);

end

else
   
    env = env_temp;
    
end


tt = [0:length(env)-1]/Fs;

figure
subplot(2,1,1)

plot(tt,y_to_dec,'r')

hold on

plot(tt,env)
plot(tt,-env)

hold off
xlabel('\bfTime (s)')
ylabel('\bfAmplitude (A.U.)')

title(['\bfTarget Stimulus and its Envelope of: ' wav_file_selected(1,1:end-4)])

legend('Target Stimulus','+Envelope','-Envelope')

set(gca,'fontweight','bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Stimulus for the background noise    
 cd(wav_file_directory_noise)
       
     [y_noise, Fs_noise] = audioread(wav_file_selected_noise);

%Extracting the envelope of the sound wave
y_to_dec_noise = y_noise';
y_hilb_noise = hilbert(y_to_dec_noise);
env_noise_temp = abs(y_hilb_noise);
   
if (Filter_Auditory_Stim == 1)

if zero_phase_menu == 1
   
    env_noise = filtfilt(b_env,a_env,env_noise_temp);
    
else
    
env_noise = filter(b_env,a_env,env_noise_temp);

end

else

    env_noise = env_noise_temp;
    
end

tt_noise = [0:length(env_noise)-1]/Fs_noise;

subplot(2,1,2)
plot(tt_noise,y_to_dec_noise,'r')

hold on

plot(tt_noise,env_noise)
plot(tt_noise,-env_noise)

hold off
xlabel('\bfTime (s)')
ylabel('\bfAmplitude (A.U.)')

title(['\bfBackground Noise Stimulus and its Envelope of: ' wav_file_selected_noise(1,1:end-4)])

legend('Target Stimulus','+Envelope','-Envelope')

set(gca,'fontweight','bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd(mat_file_directory)

dir_files = dir;

[files_number] = size(dir_files,1);

h_subjects = waitbar(0,num2str(files_number-2),'Name','Files left to be analyzed');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initializing additional variables for the computation of the speech envelope 
cross_folders = 10;
dec_factor = decimation_fact;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for integration_windows = 1:length(time_shift_DSS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initializing the variables to save the results for target and noise stimuli
shift_samples = round(time_shift_DSS(1,integration_windows)*(SF_MEG_Data/dec_factor));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subject_analyzed = [];

%% Trial I
save_max_max.trial_I = [];
save_mean.trial_I = [];
save_median.trial_I = [];
save_std.trial_I = [];
save_corr.trial_I = [];
save_all_corr_cross_val.trial_I = zeros(length(n_components),Subjcet_Number_analysis,10);
save_optimal_filter.trial_I = zeros(length(n_components),shift_samples,Subjcet_Number_analysis);

save_max_max_noise.trial_I = [];
save_mean_noise.trial_I = [];
save_median_noise.trial_I = [];
save_std_noise.trial_I = [];
save_all_corr_cross_val_noise.trial_I = zeros(length(n_components),Subjcet_Number_analysis,10);

%% Trial II
save_max_max.trial_II = [];
save_mean.trial_II = [];
save_median.trial_II = [];
save_std.trial_II = [];
save_corr.trial_II = [];
save_all_corr_cross_val.trial_II = zeros(length(n_components),Subjcet_Number_analysis,10);
save_optimal_filter.trial_II = zeros(length(n_components),shift_samples,Subjcet_Number_analysis);

save_max_max_noise.trial_II = [];
save_mean_noise.trial_II = [];
save_median_noise.trial_II = [];
save_std_noise.trial_II = [];
save_all_corr_cross_val_noise.trial_II = zeros(length(n_components),Subjcet_Number_analysis,10);

%% Trial III
save_max_max.trial_III = [];
save_mean.trial_III = [];
save_median.trial_III = [];
save_std.trial_III = [];
save_corr.trial_III = [];
save_all_corr_cross_val.trial_III = zeros(length(n_components),Subjcet_Number_analysis,10);
save_optimal_filter.trial_III = zeros(length(n_components),shift_samples,Subjcet_Number_analysis);

save_max_max_noise.trial_III = [];
save_mean_noise.trial_III = [];
save_median_noise.trial_III = [];
save_std_noise.trial_III = [];
save_all_corr_cross_val_noise.trial_III = zeros(length(n_components),Subjcet_Number_analysis,10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Looping through all the subjects
track_subjects = 0;

name_files = {zeros(Subjcet_Number_analysis,1)};

for ii = 3:files_number
      
    waitbar(ii/files_number,h_subjects,sprintf('%f',(files_number - ii + 1)))
    
  matrix_file = dir_files(ii).name;
  display(['Current file: ' matrix_file]);
  
  if (strcmp(matrix_file(1,end-2:end),'mat') == 1) 
  
      track_subjects = track_subjects + 1;
      
    selected_file = load(matrix_file);
    
     name_files(track_subjects,1) = {matrix_file(1:end-4)};
    
    try
    
    zzz = selected_file.data_exported.dss;   % DSS components
    
%% Extracting the first "N" components across for the "n" trials
DSS1 = zeros(size(zzz,1),length(n_components),size(zzz,3));

for ttt = 1:size(zzz,3)
   
    DSS1(:,:,ttt) = zzz(:,n_components,ttt);%*save_std_SDD(1,ttt)*STDheadmap*sign(headmap(97));
    
end

 %Do this analysis only the first time 
if(track_subjects == 1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Resampling the envelope of the speech stimulus to the same sampling frequency 
%as the MEG data.   
y_res = resample(env,round(SF_MEG_Data/dec_factor),Fs);
%y_res_analysis = mapstd(y_res);
y_res_analysis = zscore(y_res')';

y_res_noise = resample(env_noise,round(SF_MEG_Data/dec_factor),Fs);
%y_res_analysis_noise = mapstd(y_res_noise);
y_res_analysis_noise = zscore(y_res_noise')';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Filtering the DSS components for the "n trials"
x_res_analysis = zeros(size(DSS1,2),round(size(DSS1,1)/dec_factor),size(DSS1,3));
for hhhh = 1:size(x_res_analysis,3)
    
    temp_trial = squeeze(DSS1(:,:,hhhh));
    
    for ggg = 1:length(n_components)
  
      if Filter_DSS == 1    
        
        if zero_phase_menu == 1
            
        x_filt_temp = filtfilt(b_DSS1,a_DSS1,temp_trial(:,ggg))';
    
        else
            
            x_filt_temp = filter(b_DSS1,a_DSS1,temp_trial(:,ggg))';
                
        end
        
      else
         
           x_filt_temp = temp_trial(:,ggg)';
          
      end
        
   x_filt_dec = resample(x_filt_temp(:,:),1,dec_factor); 
   
   x_res_analysis(ggg,:,hhhh) = zscore(x_filt_dec')';
   
    end
    
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Shifting the MEG data back by "time_shift_DSS" ms to compensate for the backward pattern
%of the algorithm. 

% for wwww = 1:size(x_res_analysis,3)
%     
%     temp_data = squeeze(x_res_analysis(:,:,wwww));
%         temp_data(:,1:shift_samples) = [];    
%             comp_alg = zeros(n_components,shift_samples);
%                 x_res_analysis(:,:,wwww) = [temp_data comp_alg];
% 
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for mmm = 1:size(x_res_analysis,3)
    
for kk = 1:length(n_components)
    
    x_res_analysis_trial = squeeze(x_res_analysis(:,:,mmm));
    [temp_h,CR_test_out,Str_testE, Str_TrainE, Best_iter, Total_Iter, save_max] = svdboostV4_Alex(y_res_analysis(1,1:size(x_res_analysis_trial,2)),x_res_analysis_trial(kk,:),...
        cross_folders-1,dec_factor,shift_samples);

h = temp_h/cross_folders;  %Averaging the impulse responses;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculating the noise floor
[save_max_optimal_filter] = optimal_filter_background_noise(y_res_analysis_noise(1,1:size(x_res_analysis_trial,2)),x_res_analysis_trial(kk,:),h,cross_folders - 1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subject_analyzed = [subject_analyzed;track_subjects];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saving the values for target stimulus for each trial
switch mmm
    
    case 1
        
save_all_corr_cross_val.trial_I(kk,track_subjects,:) = save_max(2,:);
save_max_max.trial_I = [save_max_max.trial_I;max(save_max(2,:))];
save_mean.trial_I = [save_mean.trial_I;mean(save_max(2,:))];   %Save the mean
save_median.trial_I = [save_median.trial_I;median(save_max(2,:))];  %Save the median
save_std.trial_I = [save_std.trial_I;std(save_max(2,:))];
save_optimal_filter.trial_I(kk,:,track_subjects) = h;

    case 2
   
        save_all_corr_cross_val.trial_II(kk,track_subjects,:) = save_max(2,:);
save_max_max.trial_II = [save_max_max.trial_II;max(save_max(2,:))];
save_mean.trial_II = [save_mean.trial_II;mean(save_max(2,:))];   %Save the mean
save_median.trial_II = [save_median.trial_II;median(save_max(2,:))];  %Save the median
save_std.trial_II = [save_std.trial_II;std(save_max(2,:))];
save_optimal_filter.trial_II(kk,:,track_subjects) = h;
        
    case 3
        
        save_all_corr_cross_val.trial_III(kk,track_subjects,:) = save_max(2,:);
save_max_max.trial_III = [save_max_max.trial_III;max(save_max(2,:))];
save_mean.trial_III = [save_mean.trial_III;mean(save_max(2,:))];   %Save the mean
save_median.trial_III = [save_median.trial_III;median(save_max(2,:))];  %Save the median
save_std.trial_III = [save_std.trial_III;std(save_max(2,:))];
save_optimal_filter.trial_III(kk,:,track_subjects) = h;
        
end


%% Saving the mean and the median for noise stimulus for each trial
switch mmm
    
    case 1
save_all_corr_cross_val_noise.trial_I(kk,track_subjects,:) = save_max_optimal_filter(2,:);
save_max_max_noise.trial_I = [save_max_max_noise.trial_I;max(save_max_optimal_filter(2,:))];
save_mean_noise.trial_I = [save_mean_noise.trial_I;mean(save_max_optimal_filter(2,:))];
save_median_noise.trial_I = [save_median_noise.trial_I;median(save_max_optimal_filter(2,:))];
save_std_noise.trial_I = [save_std_noise.trial_I;std(save_max_optimal_filter(2,:))];

case 2
save_all_corr_cross_val_noise.trial_II(kk,track_subjects,:) = save_max_optimal_filter(2,:);
save_max_max_noise.trial_II = [save_max_max_noise.trial_II;max(save_max_optimal_filter(2,:))];
save_mean_noise.trial_II = [save_mean_noise.trial_II;mean(save_max_optimal_filter(2,:))];
save_median_noise.trial_II = [save_median_noise.trial_III;median(save_max_optimal_filter(2,:))];
save_std_noise.trial_II = [save_std_noise.trial_II;std(save_max_optimal_filter(2,:))];

case 3
save_all_corr_cross_val_noise.trial_III(kk,track_subjects,:) = save_max_optimal_filter(2,:);
save_max_max_noise.trial_III = [save_max_max_noise.trial_III;max(save_max_optimal_filter(2,:))];
save_mean_noise.trial_III = [save_mean_noise.trial_III;mean(save_max_optimal_filter(2,:))];
save_median_noise.trial_III = [save_median_noise.trial_III;median(save_max_optimal_filter(2,:))];
save_std_noise.trial_III = [save_std_noise.trial_III;std(save_max_optimal_filter(2,:))];

end

    end
end

    catch
       
        track_subjects = track_subjects - 1;
        
    end

  end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saving the results for the target speech stimulus for the "n" trials

%% Trial I
save_mean_data.cross_val_I = save_all_corr_cross_val.trial_I;
save_mean_data.max_I = save_max_max.trial_I;
save_mean_data.mean_I = save_mean.trial_I;
save_mean_data.median_I = save_median.trial_I;
save_mean_data.std_I = save_std.trial_I;
save_mean_data.optimal_filter_I = save_optimal_filter.trial_I;
save_mean_data.names = name_files;

%% Trial II
save_mean_data.cross_val_II = save_all_corr_cross_val.trial_II;
save_mean_data.max_II = save_max_max.trial_II;
save_mean_data.mean_II = save_mean.trial_II;
save_mean_data.median_II = save_median.trial_II;
save_mean_data.std_II = save_std.trial_II;
save_mean_data.optimal_filter_II = save_optimal_filter.trial_II;
save_mean_data.names = name_files;

%% Trial III
save_mean_data.cross_val_III = save_all_corr_cross_val.trial_III;
save_mean_data.max_III = save_max_max.trial_III;
save_mean_data.mean_III = save_mean.trial_III;
save_mean_data.median_III = save_median.trial_III;
save_mean_data.std_III = save_std.trial_III;
save_mean_data.optimal_filter_III = save_optimal_filter.trial_III;
save_mean_data.names = name_files;

create_dir = 'Forward_Single_Trials_Quiet';

%Checking if the folder where to save the data should be created
if (exist(create_dir) == 0)
    mkdir(create_dir)
end

cd([mat_file_directory '\' create_dir])

save_corr_target = ['Forward_Model_Trials_' wav_file_selected(1,1:end-4) '_' num2str(time_shift_DSS(1,integration_windows)) '.mat'];

save(save_corr_target,'save_mean_data')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saving the results for the noise floor for the "n" trials

%% Trial I
save_mean_data_noise.cross_val_I = save_all_corr_cross_val_noise.trial_I;
save_mean_data_noise.max_I = save_max_max_noise.trial_I;
save_mean_data_noise.mean_I = save_mean_noise.trial_I;
save_mean_data_noise.median_I = save_median_noise.trial_I;
save_mean_data_noise.std_I = save_std_noise.trial_I;
save_mean_data_noise.names = name_files;

%% Trial II
save_mean_data_noise.cross_val_II = save_all_corr_cross_val_noise.trial_II;
save_mean_data_noise.max_II = save_max_max_noise.trial_II;
save_mean_data_noise.mean_II = save_mean_noise.trial_II;
save_mean_data_noise.median_II = save_median_noise.trial_II;
save_mean_data_noise.std_II = save_std_noise.trial_II;
save_mean_data_noise.names = name_files;

%% Trial III
save_mean_data_noise.cross_val_III = save_all_corr_cross_val_noise.trial_III;
save_mean_data_noise.max_III = save_max_max_noise.trial_III;
save_mean_data_noise.mean_III = save_mean_noise.trial_III;
save_mean_data_noise.median_III = save_median_noise.trial_III;
save_mean_data_noise.std_III = save_std_noise.trial_III;
save_mean_data_noise.names = name_files;

save_corr_noise = ['Forward_Model_Noise_Trials_' wav_file_selected_noise(1,1:end-4) '_' num2str(time_shift_DSS(1,integration_windows)) '.mat'];

save(save_corr_noise,'save_mean_data_noise')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(mat_file_directory)

end
