function add_empty_rows = check_missing_electrodes(name_channels_analyzed,current_labels);
 
%This fucntion checks which electrodes are mising
      track_pos = 0;
for mm = 1:size(name_channels_analyzed,1)
    
    for nn = 1:size(current_labels,1)
    
    add_empty_rows_temp(nn,mm) = {find(strcmp(name_channels_analyzed(mm),current_labels(nn)))};
           
    end
    
    %% Checking if the sensor has not been found
    if (isempty(find(cell2mat(add_empty_rows_temp(:,mm)))))
        
    track_pos = track_pos + 1;
        add_empty_rows(track_pos,1) = mm;
        
    end
    
end

    