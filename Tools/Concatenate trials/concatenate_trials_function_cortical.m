function concatenate_trials_function_cortical(Files_Mat_file_directory,Files_Mat_file_selected)

cd(Files_Mat_file_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

conc_trials_cortical = [];

track_files = 1;
merge_triggers_latency = [{}];
merge_triggers_type = [{}];

for ii = 3:files_number
    
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)

  matrix_file = mat_files(ii).name;      
  
  disp(['File#' num2str(track_files) ' - ' matrix_file(1:end-4)]); 
  
  load(matrix_file);
    
          conc_trials_cortical = [conc_trials_cortical data_exported.single_trials];
          
          %Merge the triggers
          
              merge_triggers_latency = [merge_triggers_latency {data_exported.events_trigger}];
              merge_triggers_type = [merge_triggers_type {data_exported.events_type}];
          
          track_files = track_files + 1;
          
  end
  
      
end


conc_trials_cortical_average = squeeze(mean(conc_trials_cortical,2));
%% Time domain
figure
plot(data_exported.time_average,conc_trials_cortical_average(1,:))
xlabel('\bfTime(ms)')
ylabel('\bfAmplitude(uV)')

axis tight
set(gca,'fontweight','bold');

title('\bfAverage of the first channel of the concatenated trials')


data_exported.average_trials = conc_trials_cortical_average;
data_exported.single_trials = conc_trials_cortical;
data_exported.events_trigger = merge_triggers_latency;
data_exported.events_type = merge_triggers_type;

disp('Saving the files...')

    save_eeg = ['Conc_' num2str(size(conc_trials_cortical,2))];
    
save (save_eeg,'data_exported','-v7.3') %-v7.3 is used to save data > 2Gbytes)

message = (['The concatanation of ' num2str(size(conc_trials_cortical,2)) ' trials has been saved']);

        msgbox(message,'Files have been averages and mean has been saved','warn');