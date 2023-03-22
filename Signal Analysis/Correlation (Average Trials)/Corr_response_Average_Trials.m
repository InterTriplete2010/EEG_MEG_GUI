function Corr_response_Average_Trials(file_I_directory,file_II_directory,start_t_ent_resp,end_t_ent_resp)

clear save_corr;

%% Initializing the variable where to save the auto and cross-correlations
save_corr(1,1) = {'File I'};
save_corr(1,2) = {'File II'};
save_corr(1,3) = {'Corr'};
save_corr(1,4) = {'Corr (Fisher)'};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extract File I
cd(file_I_directory)

  
dir_files = dir;

[files_number] = size(dir_files,1);
track_subjects = 0;

save_file_I = [];

    
for ii = 3:files_number
              
  matrix_file = dir_files(ii).name;      
  
  if (strcmp(matrix_file(1,end-2:end),'mat') == 1) 
  
      track_subjects = track_subjects + 1;
      
      save_corr(track_subjects + 1,1) = {matrix_file};
     
      temp_file_I_struct = load(matrix_file);
      
     first_sample = find(temp_file_I_struct.data_exported.time_average >= start_t_ent_resp/1000,1,'First');
      last_sample = find(temp_file_I_struct.data_exported.time_average <= end_t_ent_resp/1000,1,'Last');
      
      save_file_I = [save_file_I;temp_file_I_struct.data_exported.average_trials(1,first_sample:last_sample)];
             
    
  end
  
  end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extract File II
cd(file_II_directory)

dir_files = dir;

[files_number] = size(dir_files,1);
track_subjects = 0;

save_file_II = [];

for ii = 3:files_number
              
  matrix_file = dir_files(ii).name;      
  
  if (strcmp(matrix_file(1,end-2:end),'mat') == 1) 
  
      track_subjects = track_subjects + 1;
      
      save_corr(track_subjects + 1,2) = {matrix_file};
     
      temp_file_II_struct = load(matrix_file);
     
      first_sample = find(temp_file_II_struct.data_exported.time_average >= start_t_ent_resp/1000,1,'First');
      last_sample = find(temp_file_II_struct.data_exported.time_average <= end_t_ent_resp/1000,1,'Last');
      
      save_file_II = [save_file_II;temp_file_II_struct.data_exported.average_trials(1,first_sample:last_sample)];       
    
  end
  
  end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate the correlation
for hh = 1:size(save_file_I,1)
   
                save_corr(hh + 1,3) = {corr2(abs(save_file_I(hh,:)),abs(save_file_II(hh,:)))};
                
                %Transofrming the r-values with the Fisher transform
                temp_corr_fisher = corr2(abs(save_file_I(hh,:)),abs(save_file_II(hh,:)));  
                temp_fish = {0.5*(log(1+temp_corr_fisher) - log(1-temp_corr_fisher))};
                    save_corr(hh + 1,4) = temp_fish;
                                                
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot the correlations
figure
stem(cell2mat(save_corr(2:end,3)))
xlabel('\bfSubject')
ylabel('\bfCorr value')
title('\bfCorrelation')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlswrite ('Correlation_Selected_Files.xls',save_corr)

message = 'The correlation has been calcuated and saved in an excel file';

        msgbox(message,'Calculations completed','warn');

