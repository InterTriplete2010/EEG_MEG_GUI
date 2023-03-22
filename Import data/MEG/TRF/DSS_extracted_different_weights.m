function DSS_extracted_different_weights(meg_file_add_directory,meg_file_add,Files_MEG_file_directory)
    
try 
    
cd(meg_file_add_directory)

catch 
   
   message = 'No file for the DSS weight has been selected.';

        msgbox(message,'Operation aborted','warn','replace'); 
    
    return;
    
end

    temp_weight_file = [];
    temp_weight_file = load(meg_file_add);
    temp_weight = [];
    
    try
        
    temp_weight = temp_weight_file.data_exported.rotation_matrix;
    
    catch
       
         message = 'No rotation matrix found in the file uploaded';

        msgbox(message,'Operation terminated','warn','replace');
        
        return;
        
    end
    
    cd(Files_MEG_file_directory)
dir_files = dir;

[files_number] = size(dir_files,1);

    for ii = 3:files_number
      
  matrix_file = dir_files(ii).name      
  
  if (strcmp(matrix_file(1,end-2:end),'mat') == 1) 
  
      try 
          
    temp_MEG = [];
    temp_MEG = load(matrix_file);
    
    temp_MEG_data = [];
    
    if size(temp_MEG.data_exported.eeg_data_aligned,2) == 192 %KIT data
        
    temp_MEG_data = temp_MEG.data_exported.eeg_data_aligned(:,1:157,:);
    
    dss_first_file = fold(unfold(temp_MEG_data)*temp_weight,size(temp_MEG_data(:,1:157,:),1));   % DSS components
    
    else
       
        dss_first_file = fold(unfold(temp_MEG_data)*temp_weight,size(temp_MEG_data,1));   % DSS components
            
    end
    
    data_exported.dss = dss_first_file;      
        data_exported.sampling_frequency = temp_MEG.data_exported.sampling_frequency;
            data_exported.rotation_matrix = temp_weight;
                save(['DSS_' matrix_file],'data_exported')  
 
      catch
          
      end
                
  end
    
  if (ii == files_number)
      
  message = 'All the DSS and scalp map have been extracted and saved';

        msgbox(message,'DSS and scalp map saved','warn','replace');
  
  end
    
    end