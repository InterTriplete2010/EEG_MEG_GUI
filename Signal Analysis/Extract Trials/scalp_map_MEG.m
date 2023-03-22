function scalp_map_MEG(data_exported_average_trials,tt_mean,channels,standardized_data,name_file_saved,sampl_freq,...
    P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS,labels_MEG,abs_val_peaks)

%Converting cell to mat
sensors_scalp_map = zeros(size(labels_MEG,1),1);

for hh = 1:size(labels_MEG,1)
   
    sensors_scalp_map(hh,1) = str2num(cell2mat(labels_MEG(hh)));
    
end

%Find removed channels
channels_MEG = [1:157];
keep_chan_MEG = zeros(size(data_exported_average_trials,1),size(data_exported_average_trials,2));

for yy = 1:length(channels_MEG)
    
    temp_chan = channels_MEG(yy);
    
    for kk = 1:size(sensors_scalp_map,1)
        
if sensors_scalp_map(kk) == temp_chan
    
    keep_chan_MEG(1,yy) = yy;
    keep_chan_MEG(yy,:) = data_exported_average_trials(yy,:);
    
end

    end
    
end

chan_removed_MEG_analysis = find(mean(keep_chan_MEG') == 0); %Find the channels that have been removed

data_exported_average_trials = [];
data_exported_average_trials = keep_chan_MEG;

time_ms = 1000*tt_mean; %Converting the time scale to "ms"

find_max_P1_N1_P2 = {zeros(4,channels + 1)};
find_max_P1_N1_P2(1,1) = {'Peak'};
find_max_P1_N1_P2(2,1) = {'P1'};
find_max_P1_N1_P2(3,1) = {'N1'};
find_max_P1_N1_P2(4,1) = {'P2'};

find_latency_P1_N1_P2 = {zeros(4,channels + 1)};
find_latency_P1_N1_P2(1,1) = {'Peak'};
find_latency_P1_N1_P2(2,1) = {'P1'};
find_latency_P1_N1_P2(3,1) = {'N1'};
find_latency_P1_N1_P2(4,1) = {'P2'};

find_RMS = {zeros(1,channels + 1)};
find_RMS(1,1) = {'RMS'};
find_RMS(2,1) = {'Value'};

for ll = 1:length(channels_MEG)
    
    find_max_P1_N1_P2(1,ll + 1) = {channels_MEG(ll)};
    find_latency_P1_N1_P2(1,ll + 1) = {channels_MEG(ll)};
    
    find_RMS(1,ll + 1) = {channels_MEG(ll)};
    
end

%% Starting and end points for P1, N1 and P2 
start_P1 = P1_start_window;
end_P1 = P1_end_window;
start_N1 = N1_start_window;
end_N1 = N1_end_window;
start_P2 = P2_start_window;
end_P2 = P2_end_window;

start_RMS_t = Start_RMS;
end_RMS_t = End_RMS;

find_p1_sampl_freq = time_ms(find(time_ms >= start_P1,1,'First')) - 1000/sampl_freq;
find_n1_sampl_freq = time_ms(find(time_ms >= start_N1,1,'First')) - 1000/sampl_freq;
find_p2_sampl_freq = time_ms(find(time_ms >= start_P2,1,'First')) - 1000/sampl_freq;


for kk = 1:length(channels_MEG)
    
    if length(unique([kk,chan_removed_MEG_analysis])) == length([kk,chan_removed_MEG_analysis]) 
        
        if(abs_val_peaks == 1)
        
    temp_P1 = {max(abs(data_exported_average_trials(kk,find(time_ms >= start_P1,1,'First'):find(time_ms <= end_P1,1,'Last'))))};
    temp_N1 = {max(abs(data_exported_average_trials(kk,find(time_ms >= start_N1,1,'First'):find(time_ms <= end_N1,1,'Last'))))};
    temp_P2 = {max(abs(data_exported_average_trials(kk,find(time_ms >= start_P2,1,'First'):find(time_ms <= end_P2,1,'Last'))))};
    
    find_max_P1_N1_P2(2,kk + 1) = {data_exported_average_trials(kk,find(cell2mat(temp_P1) == abs(data_exported_average_trials(kk,find(time_ms >= start_P1,1,'First'):find(time_ms <= end_P1,1,'Last')))) + find(time_ms >= start_P1,1,'First') - 1)};
    find_max_P1_N1_P2(3,kk + 1) = {data_exported_average_trials(kk,find(cell2mat(temp_N1) == abs(data_exported_average_trials(kk,find(time_ms >= start_N1,1,'First'):find(time_ms <= end_N1,1,'Last')))) + find(time_ms >= start_N1,1,'First') - 1)};
    find_max_P1_N1_P2(4,kk + 1) = {data_exported_average_trials(kk,find(cell2mat(temp_P2) == abs(data_exported_average_trials(kk,find(time_ms >= start_P2,1,'First'):find(time_ms <= end_P2,1,'Last')))) + find(time_ms >= start_P2,1,'First') - 1)};
    
    find_latency_P1_N1_P2(2,kk + 1) = {1000*find(data_exported_average_trials(kk,find(time_ms >= start_P1,1,'First'):find(time_ms <= end_P1,1,'Last')) == cell2mat(find_max_P1_N1_P2(2,kk + 1)))/sampl_freq + find_p1_sampl_freq};
    find_latency_P1_N1_P2(3,kk + 1) = {1000*find(data_exported_average_trials(kk,find(time_ms >= start_N1,1,'First'):find(time_ms <= end_N1,1,'Last')) == cell2mat(find_max_P1_N1_P2(3,kk + 1)))/sampl_freq + find_n1_sampl_freq};
    find_latency_P1_N1_P2(4,kk + 1) = {1000*find(data_exported_average_trials(kk,find(time_ms >= start_P2,1,'First'):find(time_ms <= end_P2,1,'Last')) == cell2mat(find_max_P1_N1_P2(4,kk + 1)))/sampl_freq + find_p2_sampl_freq};
    
    
        else
           
    temp_P1 = {max(data_exported_average_trials(kk,find(time_ms >= start_P1,1,'First'):find(time_ms <= end_P1,1,'Last')))};
    temp_N1 = {min(data_exported_average_trials(kk,find(time_ms >= start_N1,1,'First'):find(time_ms <= end_N1,1,'Last')))};
    temp_P2 = {max(data_exported_average_trials(kk,find(time_ms >= start_P2,1,'First'):find(time_ms <= end_P2,1,'Last')))};
    
    find_max_P1_N1_P2(2,kk + 1) = {data_exported_average_trials(kk,find(cell2mat(temp_P1) == data_exported_average_trials(kk,find(time_ms >= start_P1,1,'First'):find(time_ms <= end_P1,1,'Last'))) + find(time_ms >= start_P1,1,'First') - 1)};
    find_max_P1_N1_P2(3,kk + 1) = {data_exported_average_trials(kk,find(cell2mat(temp_N1) == data_exported_average_trials(kk,find(time_ms >= start_N1,1,'First'):find(time_ms <= end_N1,1,'Last'))) + find(time_ms >= start_N1,1,'First') - 1)};
    find_max_P1_N1_P2(4,kk + 1) = {data_exported_average_trials(kk,find(cell2mat(temp_P2) == data_exported_average_trials(kk,find(time_ms >= start_P2,1,'First'):find(time_ms <= end_P2,1,'Last'))) + find(time_ms >= start_P2,1,'First') - 1)};
    
    find_latency_P1_N1_P2(2,kk + 1) = {1000*find(data_exported_average_trials(kk,find(time_ms >= start_P1,1,'First'):find(time_ms <= end_P1,1,'Last')) == cell2mat(find_max_P1_N1_P2(2,kk + 1)))/sampl_freq + find_p1_sampl_freq};
    find_latency_P1_N1_P2(3,kk + 1) = {1000*find(data_exported_average_trials(kk,find(time_ms >= start_N1,1,'First'):find(time_ms <= end_N1,1,'Last')) == cell2mat(find_max_P1_N1_P2(3,kk + 1)))/sampl_freq + find_n1_sampl_freq};
    find_latency_P1_N1_P2(4,kk + 1) = {1000*find(data_exported_average_trials(kk,find(time_ms >= start_P2,1,'First'):find(time_ms <= end_P2,1,'Last')) == cell2mat(find_max_P1_N1_P2(4,kk + 1)))/sampl_freq + find_p2_sampl_freq};
            
        end
    
    find_RMS(2,kk + 1) = {sqrt(mean((data_exported_average_trials(kk,find(time_ms >= start_RMS_t,1,'First'):find(time_ms <= end_RMS_t,1,'Last'))).^2))};
    
    else
        
      find_max_P1_N1_P2(2,kk + 1) = {0};
      find_max_P1_N1_P2(3,kk + 1) = {0};
      find_max_P1_N1_P2(4,kk + 1) = {0};
      
      find_latency_P1_N1_P2(2,kk + 1) = {0};
      find_latency_P1_N1_P2(3,kk + 1) = {0};
      find_latency_P1_N1_P2(4,kk + 1) = {0};
      find_RMS(2,kk + 1) = {0};
       
    end
    
end

% %Saving the amplitude and latency of the peaks
% if (standardized_data == 1)
%     
%     xlswrite (['Peaks_' name_file_saved '_Standardized.xls'],find_max_P1_N1_P2)
%     
%          xlswrite (['Latencies_' name_file_saved '_Standardized.xls'],find_latency_P1_N1_P2)
%          
%             xlswrite (['RMS_' name_file_saved '_Standardized.xls'],find_RMS)
%     
%     
%     else
%     
%        xlswrite (['Peaks_' name_file_saved '_Non_Standardized.xls'],find_max_P1_N1_P2)
%                  
%          xlswrite (['Latencies_' name_file_saved '_Non_Standardized.xls'],find_latency_P1_N1_P2)
%          
%             xlswrite (['RMS_' name_file_saved '_Non_Standardized.xls'],find_RMS)
%              
%     end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
curr_fig_tag = gcf;

%% Plotting the M50
subplot(3,1,1)
megtopoplot(cell2mat(find_max_P1_N1_P2(2,2:end)))

title('\bfM50 (Amplitude)')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_max_P1_N1_P2(2,2:end))) max(cell2mat(find_max_P1_N1_P2(2,2:end)))])
set(gca,'fontweight','bold')

%% Plotting the M100
subplot(3,1,2)
megtopoplot(cell2mat(find_max_P1_N1_P2(3,2:end)))
title('\bfM100 (Amplitude)')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_max_P1_N1_P2(3,2:end))) max(cell2mat(find_max_P1_N1_P2(3,2:end)))])
set(gca,'fontweight','bold')

%% Plotting the M200
subplot(3,1,3)
megtopoplot(cell2mat(find_max_P1_N1_P2(4,2:end)))
title('\bfM200 (Amplitude)')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_max_P1_N1_P2(4,2:end))) max(cell2mat(find_max_P1_N1_P2(4,2:end)))])
set(gca,'fontweight','bold')   

if (standardized_data == 1)
    
    saveas(gcf,['Scalp_Map_Peaks_' name_file_saved '_Standardized.fig'])
    
    else
    
        saveas(gcf,['Scalp_Map_Peaks_' name_file_saved '_Non_Standardized.fig'])
            
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the latencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the M50
figure
subplot(3,1,1)
megtopoplot(cell2mat(find_latency_P1_N1_P2(2,2:end)))

title('\bfP1 (Latency)')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_latency_P1_N1_P2(2,2:end))) max(cell2mat(find_latency_P1_N1_P2(2,2:end)))])
set(gca,'fontweight','bold')

%% Plotting the M100
subplot(3,1,2)
megtopoplot(cell2mat(find_latency_P1_N1_P2(3,2:end)))
title('\bfN1 (Latency)')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_latency_P1_N1_P2(3,2:end))) max(cell2mat(find_latency_P1_N1_P2(3,2:end)))])
set(gca,'fontweight','bold')

%% Plotting the M200
subplot(3,1,3)
megtopoplot(cell2mat(find_latency_P1_N1_P2(4,2:end)))
title('\bfP2 (Latency)')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_latency_P1_N1_P2(4,2:end))) max(cell2mat(find_latency_P1_N1_P2(4,2:end)))])
set(gca,'fontweight','bold') 

if (standardized_data == 1)
    
    saveas(gcf,['Scalp_Map_Latencies_' name_file_saved '_Standardized.fig'])
    
    else
    
        saveas(gcf,['Scalp_Map_Latencies_' name_file_saved '_Non_Standardized.fig'])
            
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the RMS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
megtopoplot(cell2mat(find_RMS(2,2:end)))
title('\bfRMS')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_RMS(2,2:end))) max(cell2mat(find_RMS(2,2:end)))])
set(gca,'fontweight','bold') 

if (standardized_data == 1)
    
    saveas(gcf,['Scalp_Map_RMS_' name_file_saved '_Standardized.fig'])
    
    else
    
        saveas(gcf,['Scalp_Map_RMS_' name_file_saved '_Non_Standardized.fig'])
            
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
