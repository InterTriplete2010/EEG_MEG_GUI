function check_identical_consecutive_triggers(labels_triggers,latency_triggers)

%% Removing the extra trigger, if the numbers of rar and cond triggers are not identical
if (mod(length(labels_triggers),2) ~= 0)
   
    labels_triggers(end) = [];
    
end

%% Checking if two consecutive identical codes have been saved during the recording of the data
save_continuous_trigger_code = [];
save_continuous_trigger_latency = [];

odd_triggers_code = labels_triggers(1:2:end);
even_triggers_code = labels_triggers(2:2:end);

odd_triggers_latency = latency_triggers(1:2:end);
even_triggers_latency = latency_triggers(2:2:end);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Checking that the same number of even and odd triggers have been stored for the analysis
if (length(even_triggers_code) ~= length(odd_triggers_code))
   
    diff_length = length(even_triggers_code) - length(odd_triggers_code);
    
    if (diff_length < 0)
        
        odd_triggers_code(end + abs(diff_length) - 1,:) = [];
        odd_triggers_latency(end + abs(diff_length) - 1,:) = [];
        
    else
        
       even_triggers_code(end + abs(diff_length) - 1,:) = [];
       even_triggers_latency(end + abs(diff_length) - 1,:) = [];
       
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for kk = 1:length(odd_triggers_code)

  if (odd_triggers_code(kk) == even_triggers_code(kk))
      
  save_continuous_trigger_code(1,end + 1) = odd_triggers_code(kk);%[save_continuous_trigger_code;odd_triggers_code(kk)]';
save_continuous_trigger_latency (1,end + 1)= odd_triggers_latency(kk);%[save_continuous_trigger_latency;odd_triggers_latency(kk)]';
      
  end

end

if ~isempty(save_continuous_trigger_code)

message = (['The following trigger(s) need your attention: ' num2str(save_continuous_trigger_code) ' - latency: ' num2str(save_continuous_trigger_latency)]);

else
   
  message = ('No additional bad triggers have been found.'); 
    
end

        msgbox(message,'The file has been inspected','warn');
