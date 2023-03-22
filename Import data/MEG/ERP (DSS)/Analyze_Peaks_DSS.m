function [temp_file sdataP1 ldataP1 sdataN100 ldataN100 sdataP200 ldataP200] = Analyze_Peaks_DSS(data_exported,start_p1_time,end_p1_time,start_N100_time,end_N100_time,start_P200_time,end_P200_time)
 
   temp_file = abs(data_exported.average_trials(1,:));
    
   %% Extracting amplitude and latency for P1
   sdataP1 = max(temp_file(1,find(data_exported.time_average >= start_p1_time,1,'First'):find(data_exported.time_average <= end_p1_time,1,'Last')));
   ldataP1 = 1000*data_exported.time_average(find(temp_file == max(temp_file(1,find(data_exported.time_average >= start_p1_time,1,'First'):find(data_exported.time_average <= end_p1_time,1,'Last')))));
     
   %% Extracting amplitude and latency for N1
   sdataN100 = max(temp_file(1,find(data_exported.time_average >= start_N100_time,1,'First'):find(data_exported.time_average <= end_N100_time,1,'Last')));
   ldataN100 = 1000*data_exported.time_average(find(temp_file == max(temp_file(1,find(data_exported.time_average >= start_N100_time,1,'First'):find(data_exported.time_average <= end_N100_time,1,'Last')))));
   
   %% Extracting amplitude and latency for P2
   sdataP200 = max(temp_file(1,find(data_exported.time_average >= start_P200_time,1,'First'):find(data_exported.time_average <= end_P200_time,1,'Last')));
   ldataP200 = 1000*data_exported.time_average(find(temp_file(1,:) == max(temp_file(1,find(data_exported.time_average >= start_P200_time,1,'First'):find(data_exported.time_average <= end_P200_time,1,'Last')))));
      
      
   
