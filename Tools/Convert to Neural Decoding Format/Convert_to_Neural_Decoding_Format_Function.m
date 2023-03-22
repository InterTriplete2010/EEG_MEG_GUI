function [data_exported flag_file] = Convert_to_Neural_Decoding_Format_Function(matrix_file,data_chosen);

try
   
data_exported = [];
flag_file = 0; 
    
selected_file = load(matrix_file);

switch data_chosen 
    
    case 1
    
    data_dss = selected_file.data_exported.eeg_data';
    
    case 2
    
temp_data = selected_file.data_exported.single_trials(:,:,:);
data_dss = zeros(size(selected_file.data_exported.single_trials,3),size(selected_file.data_exported.single_trials,1),size(selected_file.data_exported.single_trials,2)); 
  
for hh = 1:size(temp_data,2)
       
        temp_data_rearrenge = squeeze(temp_data(:,hh,:))';
        
       data_dss(:,:,hh) = temp_data_rearrenge;
        
end

    case 3
        
       data_dss = cell2mat(selected_file.data_exported.eeg_data);

end

 clear data_exported;
 data_exported.dss = data_dss;
 data_exported.sampling_frequency = selected_file.data_exported.sampling_frequency;
 flag_file = 1;
 
catch
     
end


