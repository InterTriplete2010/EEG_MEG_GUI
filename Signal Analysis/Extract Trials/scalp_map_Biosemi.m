function scalp_map_Biosemi(data_exported_average_trials,tt_mean,channels,standardized_data,name_file_saved,sampl_freq,...
    P1_start_window,P1_end_window,N1_start_window,N1_end_window,P2_start_window,P2_end_window,Start_RMS,End_RMS,channels_names,abs_val_peaks)

load('channel_biosemi_64_sensors');   %Loading the position of the channels

%Reading the channel names to check which ones should be removed from the
%scalp map analysis
pos_sensors_keep = [];

for kk =1:length(channel_biosemi)
    
temp_chan = {channel_biosemi(kk).labels};

    for (pp = 1:size(channels_names,1))
        
         bb = strcmp(temp_chan,channels_names(pp));
        
        if (bb == 1)
            
            pos_sensors_keep = [pos_sensors_keep;kk];
            
        end
        
    end
    
end


%Removing channels from the analysis(i.e. A1, A2, etc.)
channel_biosemi = channel_biosemi(pos_sensors_keep); 
%data_exported_average_trials = data_exported_average_trials(pos_sensors_keep,:);

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

for ll = 1:length(channel_biosemi)
    
    find_max_P1_N1_P2(1,ll + 1) = {channel_biosemi(ll).labels};
    find_latency_P1_N1_P2(1,ll + 1) = {channel_biosemi(ll).labels};
    
    find_RMS(1,ll + 1) = {channel_biosemi(ll).labels};

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


for kk = 1:length(channel_biosemi)
    
    if (abs_val_peaks == 1)
        
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
    
end

%Saving the amplitude and latency of the peaks
if (standardized_data == 1)
    
    xlswrite (['Peaks_' name_file_saved '_Standardized.xls'],find_max_P1_N1_P2)
    
         xlswrite (['Latencies_' name_file_saved '_Standardized.xls'],find_latency_P1_N1_P2)
         
            xlswrite (['RMS_' name_file_saved '_Standardized.xls'],find_RMS)
    
    
    else
    
       xlswrite (['Peaks_' name_file_saved '_Non_Standardized.xls'],find_max_P1_N1_P2)
                 
         xlswrite (['Latencies_' name_file_saved '_Non_Standardized.xls'],find_latency_P1_N1_P2)
         
            xlswrite (['RMS_' name_file_saved '_Non_Standardized.xls'],find_RMS)
             
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the P1
figure
curr_fig_tag = gcf;
subplot(3,1,1)
topoplot(cell2mat(find_max_P1_N1_P2(2,2:end))',channel_biosemi);

title('\bfP1 (Amplitude)')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_max_P1_N1_P2(2,2:end))) max(cell2mat(find_max_P1_N1_P2(2,2:end)))])
set(gca,'fontweight','bold')

%% Plotting the N1
subplot(3,1,2)
topoplot(cell2mat(find_max_P1_N1_P2(3,2:end))',channel_biosemi);
title('\bfN1 (Amplitude)')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_max_P1_N1_P2(3,2:end))) max(cell2mat(find_max_P1_N1_P2(3,2:end)))])
set(gca,'fontweight','bold')

%% Plotting the P2
subplot(3,1,3)
topoplot(cell2mat(find_max_P1_N1_P2(4,2:end))',channel_biosemi);
title('\bfP2 (Amplitude)')

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
%% Plotting the P1
figure
subplot(3,1,1)
topoplot(cell2mat(find_latency_P1_N1_P2(2,2:end))',channel_biosemi);

title('\bfP1 (Latency)')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_latency_P1_N1_P2(2,2:end))) max(cell2mat(find_latency_P1_N1_P2(2,2:end)))])
set(gca,'fontweight','bold')

%% Plotting the N1
subplot(3,1,2)
topoplot(cell2mat(find_latency_P1_N1_P2(3,2:end))',channel_biosemi);
title('\bfN1 (Latency)')

colorbar
   
   set_colorbar = gca;
set(set_colorbar,'CLim',[min(cell2mat(find_latency_P1_N1_P2(3,2:end))) max(cell2mat(find_latency_P1_N1_P2(3,2:end)))])
set(gca,'fontweight','bold')

%% Plotting the P2
subplot(3,1,3)
topoplot(cell2mat(find_latency_P1_N1_P2(4,2:end))',channel_biosemi);
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
topoplot(cell2mat(find_RMS(2,2:end))',channel_biosemi);
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
