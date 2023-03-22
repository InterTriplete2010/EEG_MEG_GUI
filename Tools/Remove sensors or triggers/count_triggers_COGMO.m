function [matrix_count_triggers] = count_triggers_COGMO(data_type_triggers)

triggers_inspected = 1;

matrix_count_triggers_neuro_scan = zeros(1,length(data_type_triggers));
save_triggers_inspected_neuro_scan = -inf;

matrix_count_triggers_brain_vision = cell(1,1);
save_triggers_inspected_brain_vision = cell(1,1);

%% Eliminating recurrent trigger labels
for kkk = 1:length(data_type_triggers)
   
    temp_trigger = data_type_triggers(kkk);
    track_trigger_name = 0;
  
    try
        
    %% Triggers are in Neuroscan format   
    
   for ttt = 1:length(data_type_triggers)
      
        if (data_type_triggers(ttt) == temp_trigger)
            
            
            track_trigger_name = track_trigger_name + 1;
            matrix_count_triggers_neuro_scan(1,ttt) = track_trigger_name;
         
    end
                
   end
   
   save_triggers_inspected_neuro_scan(triggers_inspected,1) = temp_trigger;
   triggers_inspected = triggers_inspected + 1;
       
 %% Triggers are in BrainVision format    
    catch
     
        if (strcmp (save_triggers_inspected_brain_vision,temp_trigger) ~= 1)
     
              for ttt = 1:length(data_type_triggers)
      
                  
            if (strcmp (data_type_triggers(ttt),temp_trigger))
            
            track_trigger_name = track_trigger_name + 1;
            matrix_count_triggers_brain_vision(1,ttt) = {track_trigger_name};
    
end
    
              end
       
        save_triggers_inspected_brain_vision(triggers_inspected,1) = temp_trigger;
   triggers_inspected = triggers_inspected + 1;
   
        end
   
    end

end   

if (save_triggers_inspected_neuro_scan == -inf)
   
    matrix_count_triggers = matrix_count_triggers_brain_vision;
        
else
    
    matrix_count_triggers = matrix_count_triggers_neuro_scan;
    
    
end


