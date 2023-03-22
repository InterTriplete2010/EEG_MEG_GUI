function GFP_function_Cortical(GFP_Mat_file_directory,GFP_Mat_file_selected)

cd(GFP_Mat_file_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

track_files = 0;

message = ('The GFP is being calculated....');

        msgbox(message,'Calculations in progress.....','warn');


for ii = 3:files_number
    
    try
    
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)

        track_files = track_files + 1;
        
  matrix_file = mat_files(ii).name;      
  
  load(matrix_file);
  
  names_files(track_files,1) = {matrix_file(1:end-4)};
  
  display(['Current file: ' matrix_file(1:end-4)]);
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Calculating the global field power for each subject
  temp_gfp = 0;
  for kk = 1:size(data_exported.average_trials,2) 
  
  temp_gfp(1,kk) =  std(data_exported.average_trials(:,kk));
  temp_power(1,kk) =  mean(data_exported.average_trials(:,kk).^2);

  end
  
  gfp_single_subject(track_files,:) = temp_gfp;
  power_single_subject(track_files,:) = temp_power;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
          
    end
  
    catch
          
    end
      
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

time_gand_av = data_exported.time_average;
sampling_frequency = data_exported.sampling_frequency;
labels = data_exported.labels;

message = (['The GFP of ' num2str(track_files) ' files has been calculated and saved']);

        msgbox(message,'GFP has been calculated and saved','warn');

clear data_exported

data_exported.time_average = time_gand_av;
data_exported.gfp_single_subjects = gfp_single_subject;
data_exported.mean_power_single_subjects = power_single_subject;
data_exported.names = names_files;
data_exported.labels = labels;

save('GFP.mat','data_exported')


