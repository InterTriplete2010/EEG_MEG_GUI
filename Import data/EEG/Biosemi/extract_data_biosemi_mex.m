%% This function extracts the eeg data from the Biosemi binary file
%% and convert them into mat format. There are 20 fields, as decsribed in https://www.biosemi.com/faq/file_format.htm
%% The code to extract the data has been written in C++ and is saved in the file named Read_BDF_MEX.cpp. It has been compiled with "MinGW64 Compiler (C++)"
%% Despite the BDF format allows for saving different characteristics for each channel (e.g. different sampling frequencies, etc.)
%% This code has been written under the assumption that all the channels will have the same characteristics (e.g. same sampling frequency, same gain, same filtering, etc.)
%% See these links for a description of the BDF (https://www.biosemi.com/faq/file_format.htm)
%% and EDF (https://edfrw.readthedocs.io/en/latest/specifications.html) format

%Biosemi range: 524 mV (-262,144 to +262,143 µV) (http://psychophysiology.cpmc.columbia.edu/Software/PolyRex/faq.html)

% Description of the BDF Header:	
%1) 8 bytes	Byte 1: "255" (non ascii)	Byte 1: "0" (ASCII)	Identification code

%2) 8 bytes: Bytes 2-8 : "BIOSEMI" (ASCII)	

%3) 80 bytes	User text input (ASCII) Local subject identification

%4) 80 bytes	 User text input (ASCII) Local recording identification

%5) 8 bytes	 dd.mm.yy (ASCII) Startdate of recording

%6) 8 bytes hh.mm.ss (ASCII) Starttime of recording

%7) 8 bytes (ASCII) Number of bytes in header record

%8) 44 bytes	"24BIT" (ASCII) Version of data format.

%9) 8 bytes (ASCII) Number of data records "-1" if unknown

%10) 8 bytes e.g.: "1" (ASCII) Duration of a data record, in seconds

%11) 4 bytes e.g.: "257" or "128" (ASCII) Number of channels (N) in data record

%12) N x 16 bytes e.g.: "Fp1", "Fpz", "Fp2", etc (ASCII) Labels of the channels

%13) N x 80 bytes e.g.: "active electrode", "respiration belt" (ASCII) Transducer type

%14) N x 8 bytes	e.g.: "uV", "Ohm" (ASCII) Physical dimension of channels

%15) N x 8 bytes	e.g.: "-262144" (ASCII)	Physical minimum in units of physical dimension

%16) N x 8 bytes	e.g.: "262143" (ASCII)	Physical maximum in units of physical dimension

%17) N x 8 bytes	e.g.: "-8388608" (ASCII)	e.g.: "-32768" (ASCII)	Digital minimum

%18) N x 8 bytes	e.g.: "8388607" (ASCII)	e.g.: "32767" (ASCII)	Digital maximum

%19) N x 80 bytes	e.g.: "HP:DC; LP:410"	e.g.: "HP:0,16; LP:500"	Prefiltering

%20) N x 8 bytes	For example: "2048" (ASCII) Number of samples in each data record (Sample-rate if Duration of data record = "1")

%21) N x 32 bytes	(ASCII) Reserved

function EEG  = extract_data_biosemi_mex(BDF_file_selected,reference_channel)

EEG = [];

[byte_1,byte_2,byte_3,byte_4,byte_5,byte_6,byte_7,byte_8,data_duration,byte_10,n_chan,labels_chan,byte_13,byte_14,byte_15,...
    byte_16,byte_17,byte_18,byte_19,byte_20,byte_21,res_data,sampl_freq,data_bdf_c2,trig_event,trig_lat,event_status] = Read_BDF_MEX(BDF_file_selected);
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Reorganize the labels of the channels recorded
 EEG.nbchan = double(n_chan);

 temp_chan = [];
 temp_chan = labels_chan';
 
start_count = 0;
flag_count = 1;
count_chars = 1;
kk = 1;

while (kk < EEG.nbchan)
    
      while ~strcmp(temp_chan(count_chars),' ')
        
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

EEG.resolution = res_data;
 
sampl_freq_data = double(sampl_freq)./str2double(byte_10);
EEG.srate = sampl_freq_data;
EEG.pnts = EEG.srate*double(data_duration); 
EEG.data = double(data_bdf_c2);
 
 for kk = 1:length(trig_lat)
 
 EEG.event(kk).type = double(trig_event(kk));
 EEG.event(kk).latency = double(trig_lat(kk));    
 EEG.event(kk).status = {dec2bin(event_status(kk))};
 
 end

%% Rerefencing the data
if (reference_channel == 0)
    
       
    EEG.data = -EEG.data;   %Used for the special module
    
else

    try
        
    EEG.data = EEG.data - repmat(mean(EEG.data(reference_channel,:),1), [size(EEG.data,1) 1]);  %Rereference the data
    
    catch
        
        message = 'Re-referencing was not performed, because the channel(s) chosen were out of boundary';

        msgbox(message,'Incorrect choice of the reference','warn');
        
    end
end

%Removing the trigger channel
EEG.nbchan = EEG.nbchan - 1;

