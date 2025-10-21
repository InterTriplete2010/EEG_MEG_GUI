function [triggers_number time_duration] = plot_data_COGMO(mat_file_directory_eeg_plot,mat_file_eeg_plot,channels_to_be_plotted,channel_names,...
    plot_all_channel_check,plot_triggers_check,struct_data,plot_av,data_plot,time_s,time_e,time_w,handles,invert_polarity_data);

cd(mat_file_directory_eeg_plot)

%% Checking if the average has to be plotted
if (plot_av ~=1)

    try
    
        if (invert_polarity_data == 0)

    file_uploaded_length = struct_data.data_exported.eeg_data;

        else

           file_uploaded_length = -struct_data.data_exported.eeg_data; 

        end

    catch
        
        file_uploaded_length = [];
        
    end
    
else

    try
    
        if (invert_polarity_data == 0)

    file_uploaded_length = struct_data.data_exported.average_trials;
    
        else

            file_uploaded_length = -struct_data.data_exported.average_trials;

        end

    catch
     
        file_uploaded_length = [];
        
    end
    
end

if isempty (file_uploaded_length)
   
    message = 'The data matrix was empty. Data will not be plotted';

        msgbox(message,'No data plotted','warn');
    
        triggers_number = [];
    time_duration = 'NA';
    
    return;
    
end

[channels samples] = size(file_uploaded_length);
sampling_frequency = struct_data.data_exported.sampling_frequency;

if(time_w == 1)

     time_s_sample = 1;
     time_e_sample = size(struct_data.data_exported.eeg_data,2);

    try
        
        time_d = struct_data.data_exported.time;
        
    catch
        
        time_d = struct_data.data_exported.time_average;
        
    end
    
else

    try
        
        time_s_sample = find(time_s <= struct_data.data_exported.time,1,'First');
        time_e_sample = find(time_e >= struct_data.data_exported.time,1,'Last');
        
    catch
        
        time_s_sample = find(time_s <= struct_data.data_exported.time_average,1,'First');
        time_e_sample = find(time_e >= struct_data.data_exported.time_average,1,'Last');
        
    end
    
    %If the time domain was out of boundary, reset the time boxes to let
    %the user know that this is the time range allowed
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (time_s_sample == 1)
        
        set(handles.Start_TW_Plot,'String',time_s_sample/sampling_frequency - 1/sampling_frequency);
        
    end
    
    if(time_e_sample == size(file_uploaded_length,2))
        
        set(handles.End_TW_Plot,'String',time_e_sample/sampling_frequency - 1/sampling_frequency);
        
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    file_uploaded_length = file_uploaded_length(:,time_s_sample:time_e_sample);
    
    try
        
        time_d = struct_data.data_exported.time(time_s_sample:time_e_sample);
        
    catch
        
        time_d = struct_data.data_exported.time_average(time_s_sample:time_e_sample);
        
    end
    
end

%distance_x_axis_text = -100;

if (plot_all_channel_check ~=1)
    
    if (size(file_uploaded_length,1) > 1)
    
file_uploaded_length_channel = file_uploaded_length(channels_to_be_plotted,:);

    else
       
       file_uploaded_length_channel = file_uploaded_length(:,:); 
        
    end

figure

off_set_plot = 0;

for kk = 1:size(file_uploaded_length_channel,1)
    
    file_uploaded_length_channel_temp = file_uploaded_length_channel(kk,:);

plot(time_d,file_uploaded_length_channel_temp - off_set_plot)

if (kk == 1)
    
prop_axis = get(gca);

end

text(-(prop_axis.XTick(2) - prop_axis.XTick(1))./4,mean(file_uploaded_length_channel(kk,:) - off_set_plot),channel_names(kk),'FontSize',8,'EdgeColor','black','FontWeight','bold','LineStyle','none')

hold on
    
    off_set_plot = off_set_plot + 2*abs(min(file_uploaded_length_channel_temp));

end

hold off

axis tight

else

    channel_names = struct_data.data_exported.labels';
    
%% Plotting all the channels individually    
figure
off_set_plot = 0;

for kk = 1:channels
        
file_uploaded_length_channel = file_uploaded_length(kk,:);
    plot(time_d,file_uploaded_length_channel - off_set_plot)
    
    if (kk == 1)
    
prop_axis = get(gca);

end
    
    text(-(prop_axis.XTick(2) - prop_axis.XTick(1))./4,mean(file_uploaded_length_channel - off_set_plot),channel_names(kk),'FontSize',8,'EdgeColor','black','FontWeight','bold','LineStyle','none')

    hold on
    
    off_set_plot = off_set_plot + 2*abs(min(file_uploaded_length_channel));

end

hold off

axis tight


end

  if data_plot == 1
      
title(['EEG - ' mat_file_eeg_plot],'FontSize',18,'interpreter', 'none');   

  else
      
title(['MEG - ' mat_file_eeg_plot],'FontSize',18, 'interpreter', 'none');   

  end

get_axis = get(gca);

    xlabel('\bfTime (s)','FontSize',18)
    
    
    if data_plot == 1
        
    ylabel('\bfAmplitude(\muV EEG or fT MEG)','Position',[-(prop_axis.XTick(2) - prop_axis.XTick(1))/2.5 mean(mean(get_axis.YTick))],'FontSize',18) 

    else
       
        ylabel('\bfAmplitude(fT)','Position',[-(prop_axis.XTick(2) - prop_axis.XTick(1))/2.5 mean(mean(get_axis.YTick))],'FontSize',18) 

        
    end
    
    if (plot_triggers_check == 1)
try

    events_trigger = (struct_data.data_exported.events_trigger);
    
for lll = 1:length(events_trigger)

    hold on
   
    if (events_trigger(lll) >= time_s_sample && events_trigger(lll) <= time_e_sample)
% "Events_trigger(lll) - 1", because the first sample is "0" seconds
      %line((events_trigger(lll) - 1)/sampling_frequency,[get_axis.YTick(1):get_axis.YTick(end)],'Color','k','LineWidth',12);
plot([(events_trigger(lll) - 1)/sampling_frequency (events_trigger(lll) - 1)/sampling_frequency],[get_axis.YTick(1) get_axis.YTick(end)],'Color','k','LineWidth',1);

    end
end

hold off

catch 
    
     message = 'No trigger detected';
msgbox(message,'No trigger','warn','replace');
    
end
   
    end
    
    set(gca,'fontweight','bold')
    
    if(exist('events_trigger'))
        
    triggers_number = length(get(gca,'Children')) - size(file_uploaded_length,1)*2;
    
    else
       
      triggers_number = 0;  
        
    end
    
    time_duration = samples/sampling_frequency;

