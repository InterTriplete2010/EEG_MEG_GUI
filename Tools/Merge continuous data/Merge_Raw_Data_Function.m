function Merge_Raw_Data_Function(Raw_data_file_directory,new_merged_file_name)

%% Merging the file save in the selected directory
cd(Raw_data_file_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

merge_data = [];
merge_triggers_latency = [];
merge_triggers_type = [];
merge_files_name = [];

track_files = 0;

for ii = 3:files_number
    
    try
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)
        
  matrix_file = mat_files(ii).name;      
  
  display(['File selected' matrix_file(1:end-4)]);
  
  merge_files_name = [merge_files_name;{matrix_file}];
  
  load(matrix_file);
          
          if (track_files == 0)
          
              merge_triggers_latency = [merge_triggers_latency data_exported.events_trigger];
          
          elseif (track_files > 0)
              
              merge_triggers_latency = [merge_triggers_latency (data_exported.events_trigger + size(merge_data,2))];
              
          end
          
          merge_data = [merge_data data_exported.eeg_data];
          merge_triggers_type = [merge_triggers_type data_exported.events_type];
  
    track_files = track_files + 1;
          
    end
  
    catch
        
    end
end

data_exported.eeg_data = merge_data;
data_exported.samples = size(merge_data,2);
data_exported.time = (0:size(merge_data,2)-1)/data_exported.sampling_frequency;
data_exported.trial_duration = size(merge_data,2)/data_exported.sampling_frequency;
data_exported.events_trigger = merge_triggers_latency;
data_exported.events_type = merge_triggers_type;
data_exported.files_merged = merge_files_name;


save([new_merged_file_name '.mat'],'data_exported','-v7.3')

message = (['The following files have been merged into one file: ' cell2mat(merge_files_name(1,1)) ' and ' cell2mat(merge_files_name(2,1))]);

        msgbox(message,'Files have been merged and saved','warn');

