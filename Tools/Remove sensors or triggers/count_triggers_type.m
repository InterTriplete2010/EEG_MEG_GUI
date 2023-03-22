function [count_trig trigger_code] = count_triggers_type (labels_triggers); 

trigger_code = [];
count_trig = [];
track_triggers = [];

%% Eliminating recurrent trigger labels
for kkk = 1:length(labels_triggers)
   
    temp_trigger = labels_triggers(kkk);
      
    try
        
    %% Triggers are in double format
      if isempty(find(track_triggers == temp_trigger))
          
         trigger_code = [trigger_code;temp_trigger];
          count_trig = [count_trig;length(find(labels_triggers == temp_trigger))];
          
        end
   
          
 %% Triggers are in string format    
    catch
                    
     temp_trigger = str2num(temp_trigger);
     
        if isempty(find(track_triggers == temp_trigger))
          
         trigger_code = [trigger_code;temp_trigger];
          count_trig = [count_trig;length(find(labels_triggers == temp_trigger))];
          
        end
        
    
    end
   

    track_triggers = [track_triggers;temp_trigger];
    
end   


