%EDF read: read the EEG data saved in EDF format
function EEG  = EDF_Read_Emotiv(EDF_file_selected)

EEG = [];   %Reset the field used to save the info

%Open the EDF file
edf_file = fopen(EDF_file_selected,'r');

%Start reading the data based on the format specified in: https://www.edfplus.info/specs/edf.html

%Step 1 - 8 ascii : version of this data format (0)
EEG.byte_1 = fread(edf_file,8,'*char');

%Step 2 - 80 ascii : local patient identification (mind item 3 of the additional EDF+ specs)
EEG.byte_2 = fread(edf_file,80,'*char');

%Step 3 - 80 ascii : local recording identification (mind item 4 of the additional EDF+ specs)
EEG.byte_3 = fread(edf_file,80,'*char');

%Step 4 - 8 ascii : startdate of recording (dd.mm.yy) (mind item 2 of the additional EDF+ specs)
EEG.byte_4 = fread(edf_file,8,'*char');

%Steo 5 - 8 ascii : starttime of recording (hh.mm.ss)
EEG.byte_5 = fread(edf_file,8,'*char');

%Step 6 - 8 ascii : number of bytes in header record
EEG.byte_6 = fread(edf_file,8,'*char');

%Step 7 - 44 ascii : reserved
EEG.byte_7 = fread(edf_file,44,'*char');

%Step 8 - 8 ascii : number of data records (-1 if unknown, obey item 10 of the additional EDF+ specs)
EEG.byte_8 = fread(edf_file,8,'*char');

%Step 9 - 8 ascii : duration of a data record, in seconds
EEG.byte_9 = fread(edf_file,8,'*char');

%Step 10 - 4 ascii : number of signals (ns) in data record
EEG.byte_10 = str2double(fread(edf_file,4,'*char'));
EEG.nbchan = EEG.byte_10 - 1;

%Step 11 - ns * 16 ascii : ns * label (e.g. EEG Fpz-Cz or Body temp) (mind item 9 of the additional EDF+ specs)
EEG.byte_11 = fread(edf_file,EEG.byte_10*16,'*char');

%Extract the labels of the channels recorded
eeg_labels = [{}];
temp_label = [];

for kk = 1:length(EEG.byte_11)  

            
    if(~strcmp(EEG.byte_11(kk),' '))
        
       temp_label = [temp_label;EEG.byte_11(kk)]; 
 
    
    else
        
        if(~strcmp(EEG.byte_11(kk - 1),' '))
        
               eeg_labels = [eeg_labels;{temp_label}];
        
               temp_label = [];
                  
        end
    
    end
    
end

EEG.labels = eeg_labels;

%Step 12 - ns * 80 ascii : ns * transducer type (e.g. AgAgCl electrode)
EEG.byte_12 = fread(edf_file,EEG.byte_10*80,'*char');

%Step 13 - ns * 8 ascii : ns * physical dimension (e.g. uV or degreeC)
EEG.byte_13 = fread(edf_file,EEG.byte_10*8,'*char');

%Step 14 - ns * 8 ascii : ns * physical minimum (e.g. -500 or 34)
EEG.byte_14 = fread(edf_file,EEG.byte_10*8,'*char');

%Extract the physical minimum
min_physic = zeros(1,EEG.byte_10);
track_var = 1;
temp_label = [];

for kk = 1:length(EEG.byte_14)

            
    if(~strcmp(EEG.byte_14(kk),' '))
        
       temp_label = [temp_label;EEG.byte_14(kk)]; 
 
    
    else
        
        if(~strcmp(EEG.byte_14(kk - 1),' '))
        
               min_physic(track_var) = str2double(temp_label);
        
              track_var = track_var + 1;
              
              temp_label = [];
                  
        end
    
    end
    
end


%Step 15 - ns * 8 ascii : ns * physical maximum (e.g. 500 or 40)
EEG.byte_15 = fread(edf_file,EEG.byte_10*8,'*char');

%Extract the physical maximum
max_physic = zeros(1,EEG.byte_10);
track_var = 1;
temp_label = [];

for kk = 1:length(EEG.byte_15)

            
    if(~strcmp(EEG.byte_15(kk),' '))
        
       temp_label = [temp_label;EEG.byte_15(kk)]; 
 
    
    else
        
        if(~strcmp(EEG.byte_15(kk - 1),' '))
        
               max_physic(track_var) = str2double(temp_label);
        
              track_var = track_var + 1;
              
              temp_label = [];
                  
        end
    
    end
    
end


%Step 16 - ns * 8 ascii : ns * digital minimum (e.g. -2048)
EEG.byte_16 = fread(edf_file,EEG.byte_10*8,'*char');

%Extract the digital minimum
min_dig = zeros(1,EEG.byte_10);
track_var = 1;
temp_label = [];

for kk = 1:length(EEG.byte_16)

            
    if(~strcmp(EEG.byte_16(kk),' '))
        
       temp_label = [temp_label;EEG.byte_16(kk)]; 
 
    
    else
        
        if(~strcmp(EEG.byte_16(kk - 1),' '))
        
               min_dig(track_var) = str2double(temp_label);
        
              track_var = track_var + 1;
              
              temp_label = [];
                  
        end
    
    end
    
end


%Step 17 - ns * 8 ascii : ns * digital maximum (e.g. 2047)
EEG.byte_17 = fread(edf_file,EEG.byte_10*8,'*char');

%Extract the digital maximum
max_dig = zeros(1,EEG.byte_10);
track_var = 1;
temp_label = [];

for kk = 1:length(EEG.byte_17)

            
    if(~strcmp(EEG.byte_17(kk),' '))
        
       temp_label = [temp_label;EEG.byte_17(kk)]; 
 
    
    else
        
        if(~strcmp(EEG.byte_17(kk - 1),' '))
        
               max_dig(track_var) = str2double(temp_label);
        
              track_var = track_var + 1;
              
              temp_label = [];
                  
        end
    
    end
    
end

 
EEG.resolution = (max_physic - min_physic)./(max_dig - min_dig);
offset = max_physic - EEG.resolution.*max_dig; 

%Step 18 - ns * 80 ascii : ns * prefiltering (e.g. HP:0.1Hz LP:75Hz)
EEG.byte_18 = fread(edf_file,EEG.byte_10*80,'*char');

%Step 19 - ns * 8 ascii : ns * nr of samples in each data record
EEG.byte_19 = fread(edf_file,EEG.byte_10*8,'*char');

%Extract the sampling frequency
track_srate = 0;
for kk = 1:length(EEG.byte_19)

    if(strcmp(EEG.byte_19(kk),' '))
       
        track_srate = kk - 1;
        
        break;
        
    end

end

%Sampling frequency
%EEG.srate = str2double(EEG.byte_19(1:track_srate));
EEG.srate = str2double(EEG.byte_19(1:track_srate))./str2double(EEG.byte_9);

%Extract the total number of points
track_srate = 0;
for kk = 1:length(EEG.byte_8)

    if(strcmp(EEG.byte_8(kk),' '))
       
        track_srate = kk - 1;
        
        break;
        
    end

end

EEG.pnts = EEG.srate*str2double(EEG.byte_8(1:track_srate)); 

%Step 20 - ns * 32 ascii : ns * reserved
EEG.byte_20 = fread(edf_file,EEG.byte_10*32,'*char');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Starts reading the data. Move the pointer to the beginning of the first
% sample of each channel. Each sample is made of 16 bits,
% so we are reading in a group of 2 unsigned 8 bit integers

%EEG.byte_10 = number of channels
%(EEG.byte_10+1)*256 => this is the end of the header file
for kk = 1:EEG.nbchan%EEG.byte_10
    
    fseek(edf_file,(EEG.byte_10+1)*256 + (kk - 1)*EEG.srate*2,'bof'); %2 represents the number of bytes/sample
    
    %Since the duration of the data has been set to "1", we are reading 1 seconds of data at a time for each channel =>
    %=> int2str(EEG.srate*2), because each sample is made of 2 bytes. Then skip the data for the remaining
    %N -1 channels ((EEG.byte_10 - 1)*EEG.srate*2), reads the next second of data, etc.
    temp_data = [];
    [temp_data,count_char] = fread(edf_file,[1 EEG.pnts*2],[int2str(EEG.srate*2),'*uint8'],(EEG.byte_10 - 1)*EEG.srate*2);
    
    temp_data_16_bit = reshape(temp_data,2,length(temp_data)/2)'*2.^[0;8]; %+ min_physic(1);   %Data are saved into 16 bits, Little Endian (see the structure of the data in the documentation)
    temp_data_16_bit = temp_data_16_bit - 2^16*(temp_data_16_bit >= 2^15);  %Complement 2 conversion
    
    temp_data_16_bit = temp_data_16_bit.*EEG.resolution(kk); %+ offset(kk);
    
    %temp_data_24_bit = temp_data_24_bit + min_physic(1);
    
    EEG.data(kk,1:EEG.pnts) = temp_data_16_bit;
    
end

%Extract the triggers

%Find the trigger channel
trig_chan_index = -1;
for kk = 1:length(EEG.labels)
   
    if(strcmp(EEG.labels(kk),'MarkerValueInt'))
        
        trig_chan_index = kk;
        break;
    end
    
end

EEG.event.latency = find(EEG.data(trig_chan_index,:) ~= 0);
EEG.event.type = EEG.data(trig_chan_index,EEG.event.latency); 

fclose(edf_file);  %close the binary file