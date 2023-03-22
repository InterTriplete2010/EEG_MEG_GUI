function time_duration = plot_ICA_data(mat_file_directory_eeg_plot,mat_file_eeg_plot,channels_to_be_plotted,channel_names,...
    plot_all_channel_check,struct_data)

cd(mat_file_directory_eeg_plot)

if (size(struct_data.data_exported.eeg_data,1) > size(struct_data.data_exported.eeg_data,2))

    file_uploaded_length = struct_data.data_exported.eeg_data';

else

    file_uploaded_length = struct_data.data_exported.eeg_data;

end

[channels samples] = size(file_uploaded_length);
  
sampling_frequency = struct_data.data_exported.sampling_frequency;


time_d = [0:samples-1]/sampling_frequency;


if (plot_all_channel_check ~=1)
    
    if (size(file_uploaded_length,1) > 1)
    
        for chan_selected = 1:length(channel_names)
    
            file_uploaded_length_channel(chan_selected,:) = file_uploaded_length(str2num(cell2mat(channel_names(chan_selected))),:);

        end

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

text(-(prop_axis.XTick(2) - prop_axis.XTick(1))/4,mean(file_uploaded_length_channel_temp - off_set_plot),channel_names(kk),'FontSize',8,'EdgeColor','black','FontWeight','bold','LineStyle','none')

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
    
    text(-(prop_axis.XTick(2) - prop_axis.XTick(1))/4,mean(file_uploaded_length_channel - off_set_plot),channel_names(kk),'FontSize',8,'EdgeColor','black','FontWeight','bold','LineStyle','none')

    hold on
    
    off_set_plot = off_set_plot + abs(min(file_uploaded_length_channel));

end

hold off

axis tight


end

    
title(['\bfEEG - ' mat_file_eeg_plot],'FontSize',18);   

get_axis = get(gca);

    xlabel('\bfTime (s)','FontSize',18)
    ylabel('\bfAmplitude(uV)','Position',[-(prop_axis.XTick(2) - prop_axis.XTick(1))/1.5 mean(mean(get_axis.YTick))],'FontSize',18) 

        
    set(gca,'fontweight','bold')
    
        
    time_duration = samples/sampling_frequency;
