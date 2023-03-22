function DoDssIIR2Alex_Forward_Model(Forder,freqL,freqH,order_DSS1,Freq_Low_DSS1,Freq_High_DSS1,wav_file_directory, ...
    wav_file_selected,mat_file_directory,n_components,wav_file_selected_noise,wav_file_directory_noise,SF_MEG_Data,time_shift_DSS,...
    Subjcet_Number_analysis,decimation_fact,zero_phase_menu,Filter_DSS,Filter_Auditory_Stim)

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
%dec_factor = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for integration_windows = 1:length(time_shift_DSS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initializing the variables to save the results for target and noise stimuli
shift_samples = round(time_shift_DSS(1,integration_windows)*(SF_MEG_Data/dec_factor));
%shift_samples = round(time_shift_DSS(1,integration_windows)*100);

subject_analyzed = [];
save_max_max = [];
save_mean = [];
save_median = [];
save_std = [];
save_corr = [];
save_all_corr_cross_val = zeros(length(n_components),Subjcet_Number_analysis,10);
save_optimal_filter = zeros(length(n_components),shift_samples,Subjcet_Number_analysis);
name_files = {zeros(Subjcet_Number_analysis,1)};

save_max_max_noise = [];
save_mean_noise = [];
save_median_noise = [];
save_std_noise = [];
save_all_corr_cross_val_noise = zeros(length(n_components),Subjcet_Number_analysis,10);
Str_testE_best_matrix = [];
measured_env_best_matrix = [];
pred_env_best_matrix = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Looping through all the subjects
track_subjects = 0;
    
for ii = 3:files_number
      
    waitbar(ii/files_number,h_subjects,sprintf('%f',(files_number - ii + 1)))
    
  matrix_file = dir_files(ii).name;
  display(['Current file: ' matrix_file]);
  
  if (strcmp(matrix_file(1,end-2:end),'mat') == 1) 
  
      track_subjects = track_subjects + 1;
      
    selected_file = load(matrix_file);
    
    try
    
    zzz = selected_file.data_exported.dss;   % DSS components
    
%% Averaging the first "N" components across the "n" trials
DSS1 = zeros(size(zzz,1),length(n_components));

if size(zzz,3) > 1
    
for ttt = 1:size(zzz,3)
   
    temp_DSS1 = squeeze(zzz(:,:,ttt));%*save_std_SDD(1,ttt)*STDheadmap*sign(headmap(97));
    
    DSS1 = DSS1 + temp_DSS1(:,n_components);%*save_std_SDD(1,:);
    
end

DSS1_mean = DSS1/size(zzz,3);   %Averaging across the "N" trials

else
   
    DSS1_mean = zzz(:,n_components);
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the DSS
%{
figure(1000)
time_DSS1 = [0:size(DSS1,1)-1]/SF_MEG_Data;

subplot(2,1,1)
plot(time_DSS1,DSS1)
xlabel('\bfTime (s)')
ylabel('\bfAmplitude (uV)')

title('\bfDSS1')

set(gca,'fontweight','bold')

subplot(2,1,2)
plot(time_DSS1,mean(DSS1'),'k')
xlabel('\bfTime (s)')
ylabel('\bfAmplitude (uV)')

hold on

title('\bfMean DSS1')

set(gca,'fontweight','bold')
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Do this analysis only the first time 
if(track_subjects == 1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Resampling the envelope of the speech stimulus to the same sampling frequency 
%as the MEG data. 
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

x = DSS1_mean;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Filtering the DSS components
x_filt_temp = zeros(size(x,1),size(x,2));

for ggg = 1:length(n_components)
  
 if Filter_DSS == 1  
    
    if zero_phase_menu == 1

        x_filt_temp(:,ggg) = filtfilt(b_DSS1,a_DSS1,x(:,ggg));
        
    else
        
    x_filt_temp(:,ggg) = filter(b_DSS1,a_DSS1,x(:,ggg));
    
    end
    
 else
    
     x_filt_temp(:,ggg) = x(:,ggg);
     
 end
    
end

  
x_filt = x_filt_temp';
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decimating the MEG data
x = zeros(size(x_filt,1),round(size(x_filt,2)/dec_factor)); 

for res_interaction = 1:size(x_filt,1)
    
x(res_interaction,:) = resample(x_filt(res_interaction,:),1,dec_factor); 

end  
  
%x_res_analysis = mapstd(x);
x_res_analysis = zscore(x')';

%{
subplot(2,1,2)
plot(time_DSS1,x_filt,'g')
legend('DSS1','DSS1 Filtered')

hold off

figure

tt_dec = [0:size(x_res_analysis,2)-1]/(SF_MEG_Data/dec_factor);

for hh = 1:size(x_res_analysis,1)
   
    subplot(size(x_res_analysis,1),1,hh)
    plot(tt_dec,x_res_analysis(hh,:))
    
end


subplot(size(x_res_analysis,1),1,1)
title('DSS components')
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Shifting the MEG data back by "time_shift_DSS" ms to compensate for the backward pattern
%of the algorithm. 

%x_res_analysis(:,1:shift_samples) = [];    
%comp_alg = zeros(n_components,shift_samples);
%x_res_analysis = [x_res_analysis comp_alg];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Decoding the speech stimulus for each DSS component
for kk = 1:length(n_components)
    
[temp_h,CR_test_out,Str_testE_best,Str_TrainE,Best_iter,Total_Iter,save_max,measured_env_best,pred_env_best] = svdboostV4_Alex(y_res_analysis(1,1:size(x_res_analysis,2)),x_res_analysis(kk,:),cross_folders-1,...
dec_factor,shift_samples);

h = temp_h/cross_folders;  %Averaging the impulse responses;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculating the noise floor
[save_max_optimal_filter] = optimal_filter_background_noise(y_res_analysis_noise(1,1:size(x_res_analysis,2)),x_res_analysis(kk,:),h,cross_folders - 1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(2000 + integration_windows)
subject_analyzed = [subject_analyzed;track_subjects];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saving the values for target stimulus
save_all_corr_cross_val(kk,track_subjects,:) = save_max(2,:);
save_max_max = [save_max_max;max(save_max(2,:))];
save_mean = [save_mean;mean(save_max(2,:))];   %Save the mean
save_median = [save_median;median(save_max(2,:))];  %Save the median
save_std = [save_std;std(save_max(2,:))];
save_optimal_filter(kk,:,track_subjects) = h;
name_files(track_subjects,1) = {matrix_file};
Str_testE_best_matrix(track_subjects,:) = Str_testE_best';
measured_env_best_matrix(:,:,track_subjects) = measured_env_best;
pred_env_best_matrix(:,:,track_subjects) = pred_env_best;

%Plotting the mean and the median
subplot(2,2,1)
errorbar(subject_analyzed,save_mean,save_std)

text(subject_analyzed,save_mean,num2str(save_mean))
  
title('\bfTarget Stimulus (Mean)')
xlabel('\bfSubject #')
ylabel('\bfr value')
set(gca,'fontweight','bold')

subplot(2,2,2)
errorbar(subject_analyzed,save_median,save_std)

text(subject_analyzed,save_mean,num2str(save_median))
  
title('\bfTarget Stimulus (Median)')
xlabel('\bfSubject #')
ylabel('\bfr value')
set(gca,'fontweight','bold')

%% Saving the mean and the median for noise stimulus
save_all_corr_cross_val_noise(kk,track_subjects,:) = save_max_optimal_filter(2,:);
save_max_max_noise = [save_max_max_noise;max(save_max_optimal_filter(2,:))];
save_mean_noise = [save_mean_noise;mean(save_max_optimal_filter(2,:))];
save_median_noise = [save_median_noise;median(save_max_optimal_filter(2,:))];
save_std_noise = [save_std_noise;std(save_max_optimal_filter(2,:))];

subplot(2,2,3)
errorbar(subject_analyzed,save_mean_noise,save_std_noise)

text(subject_analyzed,save_mean_noise,num2str(save_mean_noise))
  
title('\bfBackground Noise')
xlabel('\bfSubject #')
ylabel('\bfr value')
set(gca,'fontweight','bold')

subplot(2,2,4)
errorbar(subject_analyzed,save_median_noise,save_std_noise)

text(subject_analyzed,save_median_noise,num2str(save_median_noise))
  
title('\bfBackground Noise')
xlabel('\bfSubject #')
ylabel('\bfr value')
set(gca,'fontweight','bold')

end

    catch
       
        track_subjects = track_subjects - 1;
        
    end

  end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saving the results for the target speech stimulus
save_mean_data.cross_val = save_all_corr_cross_val;
%save_mean_data.corr_values = save_corr;
save_mean_data.max = save_max_max;
save_mean_data.mean = save_mean;
save_mean_data.median = save_median;
save_mean_data.std = save_std;
save_mean_data.optimal_filter = save_optimal_filter;
save_mean_data.names = name_files;
save_mean_data.error = Str_testE_best_matrix;
save_mean_data.measured_neural_env = measured_env_best_matrix;
save_mean_data.predicted_neural_env = pred_env_best_matrix;

create_dir = 'Forward_Average_Trials_Quiet';

%Checking if the folder where to save the data should be created
if (exist(create_dir) == 0)
    mkdir(create_dir)
end

cd([mat_file_directory '\' create_dir])

save_corr_target = ['Forward_Av_Quiet_Corr_Target_' wav_file_selected(1,1:end-4) '_' num2str(time_shift_DSS(1,integration_windows)) '.mat'];

save(save_corr_target,'save_mean_data')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Saving the results for the noise floor
save_mean_data_noise.cross_val = save_all_corr_cross_val_noise;
%save_mean_data.corr_values = save_corr;
save_mean_data_noise.max = save_max_max_noise;
save_mean_data_noise.mean = save_mean_noise;
save_mean_data_noise.median = save_median_noise;
save_mean_data_noise.std = save_std_noise;

save_corr_noise = ['Forward_Av_Quiet_Corr_Noise_' wav_file_selected_noise(1,1:end-4) '_' num2str(time_shift_DSS(1,integration_windows)) '.mat'];

save(save_corr_noise,'save_mean_data_noise')

cd(mat_file_directory)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
