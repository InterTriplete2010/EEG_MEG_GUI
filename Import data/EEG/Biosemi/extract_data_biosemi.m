%% This function extracts the eeg data from the Biosemi binary file
%% and convert them into mat format. There are 20 fields, as decsribed in https://www.biosemi.com/faq/file_format.htm
%% Despite the BDF format allows for saving different characteristics for each channel (e.g. different sampling frequencies, etc.)
%% This code has been written under the assumption that all the channels will have the same characteristics (e.g. same sampling frequency, same gain, same filtering, etc.)
%% See these links for a description of the BDF (https://www.biosemi.com/faq/file_format.htm)
%% and EDF (https://edfrw.readthedocs.io/en/latest/specifications.html) format

%Biosemi range: 524 mV (-262,144 to +262,143 µV) (http://psychophysiology.cpmc.columbia.edu/Software/PolyRex/faq.html)

% Description of the BDF Header:	
%1) 8 bytes	Byte 1: "255" (non ascii)	Byte 1: "0" (ASCII)	Identification code

%1) 8 bytes: Bytes 2-8 : "BIOSEMI" (ASCII)	

%2) 80 bytes	User text input (ASCII) Local subject identification

%3) 80 bytes	 User text input (ASCII) Local recording identification

%4) 8 bytes	 dd.mm.yy (ASCII) Startdate of recording

%5) 8 bytes hh.mm.ss (ASCII) Starttime of recording

%6) 8 bytes (ASCII) Number of bytes in header record

%7) 44 bytes	"24BIT" (ASCII) Version of data format.

%8) 8 bytes (ASCII) Number of data records "-1" if unknown

%9) 8 bytes e.g.: "1" (ASCII) Duration of a data record, in seconds

%10) 4 bytes e.g.: "257" or "128" (ASCII) Number of channels (N) in data record

%11) N x 16 bytes e.g.: "Fp1", "Fpz", "Fp2", etc (ASCII) Labels of the channels

%12) N x 80 bytes e.g.: "active electrode", "respiration belt" (ASCII) Transducer type

%13) N x 8 bytes	e.g.: "uV", "Ohm" (ASCII) Physical dimension of channels

%14) N x 8 bytes	e.g.: "-262144" (ASCII)	Physical minimum in units of physical dimension

%15) N x 8 bytes	e.g.: "262143" (ASCII)	Physical maximum in units of physical dimension

%16) N x 8 bytes	e.g.: "-8388608" (ASCII)	e.g.: "-32768" (ASCII)	Digital minimum

%17) N x 8 bytes	e.g.: "8388607" (ASCII)	e.g.: "32767" (ASCII)	Digital maximum

%18) N x 80 bytes	e.g.: "HP:DC; LP:410"	e.g.: "HP:0,16; LP:500"	Prefiltering

%19) N x 8 bytes	For example: "2048" (ASCII) Number of samples in each data record (Sample-rate if Duration of data record = "1")

%20) N x 32 bytes	(ASCII) Reserved

function EEG  = extract_data_biosemi(BDF_file_selected,reference_channel)

EEG = [];

bdf_file = fopen(BDF_file_selected,'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading the information from the header file

%Step 1
%Read the first 8 bytes (all ASCII but the first byte)
 step_1 = fread(bdf_file,8);
 EEG.byte_1 = {step_1(1),char(step_1(2:end))}; 

%Step 2
%Read 80 bytes (ASCII)
 step_2 = fread(bdf_file,80);
 EEG.byte_2 = {char(step_2)};
 
 %Step 3
%Read 80 bytes (ASCII)
 step_3 = fread(bdf_file,80);
 EEG.byte_3 = {char(step_3)};
 
%Step 4
%Read 8 bytes (ASCII)
 step_4 = fread(bdf_file,8);
 EEG.byte_4 = {char(step_4)};
 
%Step 5
%Read 8 bytes (ASCII)
 step_5 = fread(bdf_file,8);
 EEG.byte_5 = {char(step_5)};
 
 %Step 6
%Read 8 bytes (ASCII)
 step_6 = fread(bdf_file,8);
 EEG.byte_6 = {char(step_6)};
 
 %Step 7
%Read 44 bytes (ASCII)
 step_7 = fread(bdf_file,44);
 EEG.byte_7 = {char(step_7)};
 
 %Step 8
%Read 8 bytes (ASCII)
 step_8 = fread(bdf_file,8);
 EEG.byte_8 = {char(step_8)};
 
 %Step 9
%Read 8 bytes (ASCII)
 step_9 = fread(bdf_file,8);
 EEG.byte_9 = {char(step_9)};
 
 %Step 10
%Read 4 bytes (ASCII)
 step_10 = fread(bdf_file,4);
 EEG.byte_10 = {char(step_10)};
 EEG.nbchan = str2double(cell2mat(EEG.byte_10));
 
 %Step 11
%Read Nchannels*16 bytes (ASCII)
 step_11 = fread(bdf_file,EEG.nbchan*16);
 EEG.byte_11 = {char(step_11)};
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Extract the labels of the channels recorded
 temp_chan = [];
 temp_chan = cell2mat(EEG.byte_11);
 
start_count = 0;
flag_count = 1;
string_labels = string(temp_chan);
count_chars = 1;
kk = 1;

while (kk < EEG.nbchan)
    
      while ~strcmp(string_labels(count_chars),' ')
        
         if flag_count == 1
            
           start_count = count_chars;  
             flag_count = 0;
         end
         
         count_chars = count_chars + 1;
         
      end
     
      if flag_count == 0 & kk < EEG.nbchan  %The last channel is the status channel, which is the trigger, so it doesn't have to be included
               
          count_chars = count_chars - 1;
          
          EEG.chanlocs(kk).labels = {temp_chan(start_count:count_chars)'};
            
          flag_count = 1;
          
          kk = kk + 1;
          
      end
     
      count_chars = count_chars + 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Step 12
%Read Nchannels*80 bytes (ASCII)
 step_12 = fread(bdf_file,EEG.nbchan*80);
 EEG.byte_12 = {char(step_12)};

%Step 13
%Read Nchannels*8 bytes (ASCII)
 step_13 = fread(bdf_file,EEG.nbchan*8);
 EEG.byte_13 = {char(step_13)};
 
 %Step 14
%Read Nchannels*8 bytes (ASCII)
 step_14 = fread(bdf_file,EEG.nbchan*8);
 EEG.byte_14 = {char(step_14)};
 
 %Step 15
%Read Nchannels*8 bytes (ASCII)
 step_15 = fread(bdf_file,EEG.nbchan*8);
 EEG.byte_15 = {char(step_15)};
 
 %Step 16
%Read Nchannels*8 bytes (ASCII)
 step_16 = fread(bdf_file,EEG.nbchan*8);
 EEG.byte_16 = {char(step_16)};
 
 %Step 17
%Read Nchannels*8 bytes (ASCII)
 step_17 = fread(bdf_file,EEG.nbchan*8);
 EEG.byte_17 = {char(step_17)};
 
 max_physic_char = cell2mat(EEG.byte_15);
 
 track_index = [];
 max_physic = zeros(1,EEG.nbchan - 1);
 track_index_array = 1;
 previous_index = 1;
 for ll = 1:size(max_physic_char,1)
     
     if strcmp(max_physic_char(ll),' ')
         
         track_index = [track_index;ll];
         
     end
     
     if length(track_index) == 2 & track_index_array < EEG.nbchan
         
         max_physic(1,track_index_array) = str2double(max_physic_char(previous_index:track_index(1) - 1));
         previous_index = track_index(2) + 1;
         track_index = [];
         track_index_array = track_index_array + 1;
         %break;
         
     end
     
 end
 
 %max_physic = str2double(max_physic_char(1:track_index - 1));
 
 min_physic_char = cell2mat(EEG.byte_14);
 
 track_index = [];
 min_physic = zeros(1,EEG.nbchan - 1);
 track_index_array = 1;
 previous_index = 1;
 for ll = 1:size(min_physic_char,1)
     
     if strcmp(min_physic_char(ll),' ')
         
         track_index = [track_index;ll];
         
     end
     
     if length(track_index) == 1 & track_index_array < EEG.nbchan
         
         min_physic(1,track_index_array) = str2double(min_physic_char(previous_index:track_index - 1));
         previous_index = track_index + 1;
         track_index = [];
         track_index_array = track_index_array + 1;
         %break;
         
     end
     
 end
 
 
 %min_physic = -str2double(min_physic_char(2:track_index - 1));
 
 max_dig_char = cell2mat(EEG.byte_17);
 
 track_index = [];
 max_dig = zeros(1,EEG.nbchan - 1);
 track_index_array = 1;
 previous_index = 1;
 for ll = 1:size(max_dig_char,1)
     
     if strcmp(max_dig_char(ll),' ')
         
         track_index = [track_index;ll];
         
     end
     
     if length(track_index) == 1 & track_index_array < EEG.nbchan 
         
         max_dig(1,track_index_array) = str2double(max_dig_char(previous_index:track_index - 1));
         previous_index = track_index + 1;
         track_index = [];
         track_index_array = track_index_array + 1;
         %break;
         
     end
     
 end
 
 %max_dig = str2double(max_dig_char(1:track_index - 1));
 
 min_dig_char = cell2mat(EEG.byte_16);
 
 track_index = [];
 min_dig = zeros(1,EEG.nbchan - 1);
 track_index_array = 1;
 for ll = 1:size(min_dig_char,1)
     
     if strcmp(min_dig_char(ll),'-')
         
         track_index = [track_index;ll];
         
     end
     
     if length(track_index) == 2 & track_index_array < EEG.nbchan
         
         min_dig(1,track_index_array) = str2double(min_dig_char(track_index(1):track_index(2) - 1));
         track_index(1) = [];
         track_index_array = track_index_array + 1;
         %break;
         
     end
     
 end
 
 %min_dig = -str2double(min_dig_temp((track_index(1) + 1:track_index(2) - 1)));
 
  EEG.resolution = (max_physic - min_physic)./(max_dig - min_dig);
  offset = max_physic - EEG.resolution.*max_dig;
  
 %Step 18
%Read Nchannels*80 bytes (ASCII)
 step_18 = fread(bdf_file,EEG.nbchan*80);
 EEG.byte_18 = {char(step_18)};
 
 %Step 19
%Read Nchannels*8 bytes (ASCII)
 step_19 = fread(bdf_file,EEG.nbchan*8);
 EEG.byte_19 = {char(step_19)};
 sampl_freq_data_char = char(step_19);
 
 track_index = [];
 for ll = 1:size(sampl_freq_data_char,1)
     
     if strcmp(sampl_freq_data_char(ll),' ')
         
         track_index = [track_index;ll];
         
     end
     
     if length(track_index) == 1
         
         break;
         
     end
     
 end
 
 %sampl_freq_data = str2double(sampl_freq_data_char(1:track_index - 1));
 sampl_freq_data = str2double(sampl_freq_data_char(1:track_index - 1))./str2double(EEG.byte_9);
 EEG.srate = sampl_freq_data;
 EEG.pnts = EEG.srate*str2double(cell2mat(EEG.byte_8)); 
 
 %Step 20
%Read Nchannels*32 bytes (ASCII)
 step_20 = fread(bdf_file,EEG.nbchan*32);
 EEG.byte_20 = {char(step_20)};
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Starts reading the data. Move the pointer to the beginning of the first
% sample of each channel. Each sample is made of 24 bits (see Biosemi website),
% so we are reading in a group of 3 unsigned 8 bit integers

%(EEG.nbchan+1)*256 => this is the end of the header file
for kk = 1:EEG.nbchan
   
    fseek(bdf_file,(EEG.nbchan+1)*256 + (kk - 1)*EEG.srate*3,'bof'); %3 represents the number of bytes/sample

    temp_data = [];
     count_char = [];
    
    % Convert into 24 bit number
    if kk == EEG.nbchan %This is the trigger channel
          
         [temp_data,count_char] = fread(bdf_file,[1 EEG.pnts*3],[int2str(EEG.srate*3),'*uint8'],EEG.nbchan*EEG.srate*3 - EEG.srate*3);

%          temp_data_24_bit = bitand(reshape(temp_data,3,length(temp_data)/3)'*2.^[0;8;16],hex2dec('00ffff'));
%  eventVector = bitand(temp_data_24_bit, hex2dec('00ffff'));
trigger_type_lat_first8bits = temp_data(1:3:end); %These are the first 8 bits of the trigger line
trigger_type_lat_second8bits = temp_data(2:3:end); %These are the second 8 bits of the trigger line
trigger_type_lat_third8bits = temp_data(3:3:end);   %These bits are used for the status of the trigger

%Save the trigger type and latencies
track_trig = 1;
for trig_val = 1:length(trigger_type_lat_first8bits)
   
    if trig_val > 1
        
        if (trigger_type_lat_first8bits(trig_val) ~= 0 | trigger_type_lat_second8bits(trig_val) ~= 0) & (diff(trigger_type_lat_first8bits([trig_val - 1 trig_val])) > 0 | diff(trigger_type_lat_second8bits([trig_val - 1 trig_val])) > 0)
            
            EEG.event(track_trig).type = trigger_type_lat_first8bits(trig_val) + trigger_type_lat_second8bits(trig_val)*2^8;
            EEG.event(track_trig).latency = trig_val;
            EEG.event(track_trig).status = {dec2bin(trigger_type_lat_third8bits(trig_val))};
            
            track_trig = track_trig + 1;
            
        end
        
    else
       
    if (trigger_type_lat_first8bits(trig_val) > 0 | trigger_type_lat_second8bits(trig_val) > 0)
                
                EEG.event(track_trig).type = trigger_type_lat_first8bits(trig_val) + trigger_type_lat_second8bits(trig_val)*2^8;
                EEG.event(track_trig).latency = trig_val;
                EEG.event(track_trig).status = {dec2bin(trigger_type_lat_third8bits(trig_val))};
            
                track_trig = track_trig + 1;
                
            end
        end
        
end

    else
        
     %Since the duration of the data has been set to "1", we are reading 1 seconds of data at a time for each channel => 
     %=> int2str(EEG.srate*3), because each sample is made of 3 bytes. Then skip the data for the remaining 
     %N -1 channels ((EEG.nbchan - 1)*EEG.srate*3), reads the next second of data, etc.
     temp_data = [];
         [temp_data,count_char] = fread(bdf_file,[1 EEG.pnts*3],[int2str(EEG.srate*3),'*uint8'],(EEG.nbchan - 1)*EEG.srate*3);

         temp_data_24_bit = reshape(temp_data,3,length(temp_data)/3)'*2.^[0;8;16]; %+ min_physic(1);   %Data are saved into 24 bits, Little Endian (see the structure of the data in the documentation)
      temp_data_24_bit = temp_data_24_bit - 2^24*(temp_data_24_bit >= 2^23);  %Complement 2 conversion 
       temp_data_24_bit = temp_data_24_bit.*EEG.resolution(kk);% + offset(kk);
       
       %temp_data_24_bit = temp_data_24_bit + min_physic(1);
       
       EEG.data(kk,1:EEG.pnts) = temp_data_24_bit;
       
    end
 
   
end

%% Rerefencing the data
if (reference_channel == 0)
    
       
    EEG.data = -EEG.data;   %Used for the special module
    
else

    try
        
        if(~isempty(reference_channel))

    EEG.data = EEG.data - repmat(mean(EEG.data(reference_channel,:),1), [size(EEG.data,1) 1]);  %Rereference the data
    
        end

    catch
        
        message = 'Re-referencing was not performed, because the channel(s) chosen were out of boundary';

        msgbox(message,'Incorrect choice of the reference','warn');
        
    end
end

%Removing the trigger channel
%EEG.data(end,:) = [];
EEG.nbchan = EEG.nbchan - 1;

 fclose(bdf_file);  %close the binary file
