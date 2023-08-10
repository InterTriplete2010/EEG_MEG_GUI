%% This function extracts the eeg data from the Brain Vision binary file
% and convert them into mat format

function EEG  = extract_data_brain_vision(VHDR_file_directory, VHDR_file_selected, vhdr_ahdr,bits_eeg)

EEG = [];

cd(VHDR_file_directory)

file_brainvision = fopen(VHDR_file_selected,'r');

%Read line by line and extracting the data, triggers, etc.
temp_line = fgetl(file_brainvision);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
channel_labels = 1;

while ischar(temp_line)
    
    temp_line = fgetl(file_brainvision);
           
    try
        
        %Extract the name of the EEG data file
        if strcmp(temp_line(1:9),'DataFile=')
    
       data_eeg = temp_line(strfind(temp_line, '=') + 1:end); 
        
        end
    
        %Extract the name of the trigger data file
        if strcmp(temp_line(1:11),'MarkerFile=')
    
       data_markers = temp_line(strfind(temp_line, '=') + 1:end); 
        
        end
    
    try
        
        %Extract the number of channels 
%     if strcmp(temp_line(1:19),'NumberOfChannels:')
%     
%        EEG.nbchan = str2double(temp_line(strfind(temp_line, ':') + 1:end)); 
%         
%     end
       
    if strcmp(temp_line(1:16),'NumberOfChannels')
    
       EEG.nbchan = str2double(temp_line(strfind(temp_line, '=') + 1:end)); 
        
    end
    
     %Extract the sampling frequency   
        %if strcmp(temp_line(1:19),'Sampling Rate [Hz]:')
        if strcmp(temp_line(1:16),'SamplingInterval')    

            EEG.srate = (1./str2double(temp_line(strfind(temp_line, '=') + 1:end)))*10^6;
            
        end
        
    catch
        
    end
    
    
        %Extract the channel names
        
        if strcmp(temp_line(1:2),'Ch') & strcmp(temp_line(end-1:end),'µV')
            
            temp_demarkation_points = strfind(temp_line, ',');
            EEG.chanlocs.labels(channel_labels) = {temp_line(strfind(temp_line, '=') + 1:temp_demarkation_points(1) - 1)};
            
            %if channel_labels == 1
               
                %Gain of each channel
                gain(channel_labels) = 1./str2double(temp_line(temp_demarkation_points(2) + 1:temp_demarkation_points(3) - 1));
                
            %end
            
            channel_labels = channel_labels + 1;
            
        end
        
        
    catch
        
    end
end

fclose(file_brainvision);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading the information about the trigger
file_marker = fopen(data_markers,'r');

%Read line by line and extracting the data, triggers, etc.
temp_line = fgetl(file_marker);

track_triggers = 1;

while ischar(temp_line)
    
    temp_line = fgetl(file_marker);
           
    try
        temp_end_new_seg = strfind(temp_line, ',');
        %Extract the first trigger
        if strcmp(temp_line(temp_end_new_seg(1) - 11:temp_end_new_seg(1) - 1),'New Segment')
    
            %EEG.event(track_triggers).latency = 1; 
            temp_demarkation_points = strfind(temp_line, ',');
            EEG.event(track_triggers).latency = str2double(temp_line(temp_demarkation_points(2) + 1:temp_demarkation_points(3) - 1));
       EEG.event(track_triggers).type = 0; 
        
       track_triggers = track_triggers + 1;
       
        end
      
        %Extract the stimulus-locked triggers
        if strcmp(temp_line(1:2),'Mk') & ~strcmp(temp_line(temp_end_new_seg(1) - 11:temp_end_new_seg(1) - 1),'New Segment')
    
            temp_demarkation_points = strfind(temp_line, ',');
            EEG.event(track_triggers).latency = str2double(temp_line(temp_demarkation_points(2) + 1:temp_demarkation_points(3) - 1));
            %EEG.event(track_triggers).type = temp_line(temp_demarkation_points(1) + 1:temp_demarkation_points(2) - 1);
            
            temp_trig = temp_line(temp_demarkation_points(1) + 1:temp_demarkation_points(2) - 1);
            
            if(isempty(str2num(temp_trig)))
                
                EEG.event(track_triggers).type = str2num(temp_trig(2:end));
                
            else
                
                 EEG.event(track_triggers).type = str2num(temp_trig);
                
            end
            
       track_triggers = track_triggers + 1;
        
        end
        
    catch
        
    end
    
end

fclose(file_marker);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading the eeg data

%If the ahdr mode is used, increase the number of channels by one, as
%reported in this link: https://github.com/mne-tools/mne-python/issues/6613
%The additional channel is listed as an "encryption" and should not be
%saved with the data
if(vhdr_ahdr == 2)

    EEG.nbchan = EEG.nbchan + 1;

end

file_marker = fopen(data_eeg,'r');

if (bits_eeg == 1)

    fseek(file_marker, 0, 'eof');   %Move the cursor at the end of the file to subsequently read the total number of samples
    samples_eeg = ftell(file_marker) / (EEG.nbchan * 4);    %Data in BrainVision are 32 bits => the number of points needs to be divided by N-Channels and 4 (4 = bytes)
    fseek(file_marker, 0, 'bof');   %Move the cursor at the beginning of the file to subsequently read the samples as 32 bit float and store them in a matrix of dimension EEG.nbchan x samples_eeg

    eeg_data = fread(file_marker, [EEG.nbchan, samples_eeg], 'float32=>float32');

else

    eeg_data = fread(file_marker,inf,'int16');

end

if(vhdr_ahdr == 1)

    for kk = 1:EEG.nbchan

        EEG.data(kk,:) = eeg_data(kk:EEG.nbchan:end)./gain(kk);

    end

else

    %Read only the channels without encryption
    for kk = 1:EEG.nbchan - 1

        EEG.data(kk,:) = eeg_data(kk:EEG.nbchan:end)./gain(kk);

        if (kk == EEG.nbchan - 1)

            EEG.nbchan = EEG.nbchan - 1;    %Restore the number of channels to its correct value, after reading the data

        end

    end

end

EEG.pnts = size(EEG.data,2);

fclose(file_brainvision);  %close the binary file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%