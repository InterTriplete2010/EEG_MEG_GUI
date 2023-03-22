function mouse_coordinate_real_time(Files_Mat_file_directory,Files_Mat_file_selected,scalp_map_EEG_MEG)

cd(Files_Mat_file_directory)

temp_file = load(Files_Mat_file_selected);
av_data = temp_file.data_exported.average_trials;
time_d = 1000*temp_file.data_exported.time_average;

figure
subplot(2,1,1)
plot(time_d,av_data')
xlabel('Time (ms)')

if scalp_map_EEG_MEG == 1
    
ylabel('Amplitude (\muV)')

else
    
    ylabel('Amplitude (fT)')
    
end

axis tight

end_function = 0;

try
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if scalp_map_EEG_MEG == 1
       
        channels_names = temp_file.data_exported.channel_trials;
    
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

while(end_function == 0)
    
%This code is used to terminate the operation    
    key = get(gcf,'CurrentKey');
    
    if(strcmp (key,'return'))
        
        end_function = 1;
        
    end
    
  subplot(2,1,1)
           pos_mouse = get(gca,'CurrentPoint');
        pos_data = pos_mouse(1,1); 
        
        find_pos = find(time_d >= pos_data,1,'First');
            
      if ~isempty(find_pos)
          
          curr_axes = get(gca,'Children');
            if length(curr_axes) > size(av_data,1) + 1
            
            delete(curr_axes(2));
               
            end
        
          subplot(2,1,2)
            topoplot(av_data(:,find_pos),channel_biosemi);
     
            pause(0.03)
               
               subplot(2,1,1)
                    delete(findall(gcf,'Type','hggroup')); %Delete the datatip from the figure
     
          line([time_d(find_pos) time_d(find_pos)],[min(min(av_data)) max(max(av_data))],'Color','k');
          
        end
     
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MEG data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    else
   
labels_MEG = temp_file.data_exported.channel_trials;        
%Converting cell to mat
sensors_scalp_map = zeros(size(labels_MEG,1),1);

for hh = 1:size(labels_MEG,1)
   
    sensors_scalp_map(hh,1) = str2num(cell2mat(labels_MEG(hh)));
    
end

%Find removed channels
channels_MEG = [1:157];
keep_chan_MEG = zeros(size(av_data,1),size(av_data,2));

for yy = 1:length(channels_MEG)
    
    temp_chan = channels_MEG(yy);
    
    for kk = 1:size(sensors_scalp_map,1)
        
if sensors_scalp_map(kk) == temp_chan
    
    keep_chan_MEG(1,yy) = yy;
    keep_chan_MEG(yy,:) = av_data(yy,:);
    
end

    end
    
end

av_data = [];
av_data = keep_chan_MEG;       
        
        while(end_function == 0)
    
%This code is used to terminate the operation    
    key = get(gcf,'CurrentKey');
    
    if(strcmp (key,'return'))
        
        end_function = 1;
        
    end
        
           subplot(2,1,1)
           pos_mouse = get(gca,'CurrentPoint');
        pos_data = pos_mouse(1,1); 
        
        find_pos = find(time_d >= pos_data,1,'First');
            
      if ~isempty(find_pos)
          
          curr_axes = get(gca,'Children');
            if length(curr_axes) > size(av_data,1) + 1
            
            delete(curr_axes(2));
               
            end
          
          subplot(2,1,2)
          megtopoplot(av_data(:,find_pos));
                
          subplot(2,1,1)
          line([time_d(find_pos) time_d(find_pos)],[min(min(av_data)) max(max(av_data))],'Color','k');
                      
            end      
        
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    end

catch
    
   close(gcf)
    
   message = 'The data uploaded is inconsistent with the EEG/MEG selection';

        msgbox(message,'Error','warn');
        
        
    
end
