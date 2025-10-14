function concatenate_trials_function(Files_Mat_file_directory,Files_Mat_file_selected)

cd(Files_Mat_file_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

conc_trials_rar = [];
conc_trials_compr = [];

conc_trials_envelope = [];
conc_trials_fine_structure = [];

for ii = 3:files_number
    
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)

  matrix_file = mat_files(ii).name;      
  
  load(matrix_file);
  
                
          conc_trials_envelope = [conc_trials_envelope;data_exported.rar_sweeps;data_exported.compr_sweeps];
          conc_trials_fine_structure = [conc_trials_fine_structure;-data_exported.rar_sweeps;data_exported.compr_sweeps];
          
          conc_trials_rar = [conc_trials_rar;data_exported.rar_sweeps];
conc_trials_compr = [conc_trials_compr;data_exported.compr_sweeps];
          
  end
  
      
end

%% Time domain
figure
time_d = 1000*[0:size(conc_trials_envelope,2)-1]/data_exported.sampling_frequency; 

subplot(2,1,1)
plot(time_d,mean(conc_trials_envelope))
xlabel('\bfTime(ms)')
ylabel('\bfAmplitude(uV)')

axis tight
set(gca,'fontweight','bold');

title('\bfEnvelope')

subplot(2,1,2)
plot(time_d,mean(conc_trials_fine_structure))
xlabel('\bfTime(ms)')
ylabel('\bfAmplitude(uV)')

axis tight
set(gca,'fontweight','bold');
title('\bfFine structure')

%% Frequency domain
%{
mean_env = mean(conc_trials_envelope);
temp_ss_env = mean_env(find(time_d <= 68,1,'Last'):find(time_d >= 169,1,'First'));
[Pxx_env Freq_env] = pwelch(temp_ss_env,length(temp_ss_env),length(temp_ss_env)/2,data_exported.sampling_frequency,data_exported.sampling_frequency);

figure
subplot(2,1,1)
plot(Freq_env, sqrt(Pxx_env))

xlabel('\bfTime(ms)')
ylabel('\bfAmplitude(uV)')

axis tight
set(gca,'fontweight','bold');
title('\bfEnvelope')

axis([0 2000 0 (max(sqrt(Pxx_env)) + max(sqrt(Pxx_env))/4)])

mean_fine = mean(conc_trials_fine_structure);
temp_ss_fine = mean_fine(find(time_d <= 68,1,'Last'):find(time_d >= 169,1,'First'));
[Pxx_fine Freq_fine] = pwelch(temp_ss_fine,length(temp_ss_fine),length(temp_ss_fine)/2,data_exported.sampling_frequency,data_exported.sampling_frequency);
subplot(2,1,2)
plot(Freq_fine, sqrt(Pxx_fine))

xlabel('\bfFrequency(Hz)')
ylabel('\bfAmplitude(uV)')

axis tight
set(gca,'fontweight','bold');
title('\bfFine structure')

axis([0 2000 0 (max(sqrt(Pxx_fine)) + max(sqrt(Pxx_fine))/4)])
%}
data_exported.eeg_data = [];
data_exported.rar_trials = conc_trials_rar;
data_exported.compr_trials = conc_trials_compr;
data_exported.sampling_frequency = data_exported.sampling_frequency;
data_exported.average_trials = mean(conc_trials_envelope);
data_exported.average_sub = mean(conc_trials_fine_structure);
data_exported.trials_envelope = conc_trials_envelope;
data_exported.trials_fine_structure = conc_trials_fine_structure;
data_exported.rar_sweeps = [];
data_exported.compr_sweeps = [];
data_exported.average_add = [];
data_exported.add_fourier_power = [];
data_exported.sub_fourier_power = [];
data_exported.events_trigger = [];

    save_eeg = ['Conc_' num2str(size(conc_trials_envelope,1))];
    
save (save_eeg,'data_exported','-v7.3') %-v7.3 is used to save data > 2Gbytes)

message = (['The concatanation of ' num2str(size(conc_trials_envelope,1)) ' trials has been saved']);

        msgbox(message,'Files have been averages and mean has been saved','warn');

