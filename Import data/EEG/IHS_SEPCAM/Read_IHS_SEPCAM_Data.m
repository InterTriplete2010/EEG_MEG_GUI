%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IHS Continuous Acquisition Module file and data reading function
% Erdem Yavuz (April 2008); Edited by Alessandro Presacco (December 2008) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [EEG] = Read_IHS_SEPCAM_Data(F_file_selected,F_file_directory,alt_pol_option,interval_trig)

cd([F_file_directory])

path_eeg_selected = [F_file_directory F_file_selected];

try
    
open_eeg_selected = fopen(path_eeg_selected,'rb');  

catch
    
    message = 'The file selected can not be opened';

        msgbox(message,'Error!!!','warn');
       
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Read the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if open_eeg_selected ~=-1
     
     Config_Array.Std_Ihs_EP = fread(open_eeg_selected,1000,'int16'); 
        Config_Array.ContData_Suppl = fread(open_eeg_selected,4000,'int32'); 
            Config_Array.Seq1_Locs=fread(open_eeg_selected,5000,'int32'); 
                Config_Array.Seq1_Align=fread(open_eeg_selected,5000,'int32');
                    Config_Array.Seq2_Locs=fread(open_eeg_selected,5000,'int32');
                        Config_Array.Seq2_Align=fread(open_eeg_selected,5000,'int32');
                            Config_Array.Marker_locc=fread(open_eeg_selected,5000,'int32');
                                Config_Array.Marker_typess=fread(open_eeg_selected,4000,'int32');
                                    Config_Array.Additional_Dloc=fread(open_eeg_selected,12500,'int32');
     
     
     fseek(open_eeg_selected,200000,'bof');  
     
     data_eeg = fread(open_eeg_selected,'int16');
     
     
     
    number_of_channels_recorded_value = Config_Array.ContData_Suppl(1);   %Number of channels recorded;
        Recording_Type = Config_Array.ContData_Suppl(2);             %("0" Raw recording; "1" std average; "2" CLAD; "3" Sequential Stimulation; "4" Complex SequenceAverage); 
            Recording_Phase = Config_Array.ContData_Suppl(3);            % ("1" Rarefaction; "2" Condensation; "3" Alternating);
                DigitalChannel = Config_Array.ContData_Suppl(4);            % ("0" Off; "1" On);  
                    Number_Of_Sequences_Used = Config_Array.ContData_Suppl(5);     
                        Number_Of_Stimuli_Used = Config_Array.ContData_Suppl(6); 
                            Sampletime=Config_Array.ContData_Suppl(7);  %(In us*1000)	
                                Sampletime= (Sampletime/1000/1000); 	
                                    OAEChannel=Config_Array.ContData_Suppl(8);  %(Physcial OAE Channel location)

    if  (Config_Array.ContData_Suppl(9)==1 )                   % OAE recording Type 
     OAE_Acq_Type = 'TOAE';
    else
        if (Config_Array.ContData_Suppl(9)==2 )
      OAE_Acq_Type = 'DPOAE';
        end  
        end
    
    if (OAEChannel>0 )
         OAEChannel_RawChNum = number_of_channels_recorded_value;
      if  (DigitalChannel==1 ) 
         OAEChannel_RawChNum=number_of_channels_recorded_value-1;   
      end    
      
    else
       OAEChannel_RawChNum=-1;                                    %Initilize with no channel assignment
  
    end
    
    
    
    
	Seq1SweepLength = Config_Array.ContData_Suppl(250);	
        Seq1SweepAmount = Config_Array.ContData_Suppl(251);	
            Seq1NumberOfStim = Config_Array.ContData_Suppl(252);	
                Seq1StimRate = Config_Array.ContData_Suppl(253);	%{ StimRate  *   1000   for the sequence}
                    Seq1EarSend = Config_Array.ContData_Suppl(254);	
                        Seq1StimMode = Config_Array.ContData_Suppl(255);	%{ 0-Alternate,2-Conden,1-Rarefaction 3-Complex}
                            Seq1StimsSend = Config_Array.ContData_Suppl(256);	%{ Stimulus numbers will entered as a single numerber eg; Stim1 and Stim4 is represented as 14}
                                Driving_Sequence_Length = Config_Array.ContData_Suppl(257);
                            
    
    %Create StimType structure initilised with zeros
    StimType.Intensity=0;           %Intensity in dBs
    StimType.Type=0;                %Code for stimulus type 1 Click 2 Toneburst					
    StimType.Frequency=0;           %Frequency of Tone Pip or Burst;"0" if click
    StimType.Duration=0;            %Duration of stimulus in points
    StimType.RCalibration=0;        %Calibration value in dBs
    StimType.LCalibration=0;        %Calibration value in dBs
    StimType.HLSPLFlag=0;           %HL=0, SPL=1; Stimulation Modes
    StimType.StimRiseFallTime=0;    %Rise Fall time (numpoints) of Stim.	
    StimType.StimulatorType=0;      %{ Stimulator Type}
    
    Stims=[];
    % Initilize the ChannelAmps Structure with zeros
    for i=1:Number_Of_Stimuli_Used
      Stims=[Stims StimType];
    end
    
    
   % Fill in the Stims Details
   
    for  i=1:number_of_channels_recorded_value 
    
       Stims(i).Intensity=Config_Array.ContData_Suppl(310+((i-1)*15));
       Stims(i).Type=Config_Array.ContData_Suppl(311+((i-1)*15));					
       Stims(i).Frequency=Config_Array.ContData_Suppl(312+((i-1)*15));
       Stims(i).Duration=Config_Array.ContData_Suppl(313+((i-1)*15));
       Stims(i).RCalibration=Config_Array.ContData_Suppl(314+((i-1)*15));
       Stims(i).LCalibration=Config_Array.ContData_Suppl(315+((i-1)*15));
       Stims(i).HLSPLFlag=Config_Array.ContData_Suppl(316+((i-1)*15));
       Stims(i).StimRiseFallTime=Config_Array.ContData_Suppl(317+((i-1)*15));
       Stims(i).StimulatorType=Config_Array.ContData_Suppl(318+((i-1)*15));
    end
    
    
    %Create ChAmpType structure initilised with zeros
    ChAmpType.Gain=0;     %Gain*1000 for the sequence
    ChAmpType.HighPass=0; %High Pass*1000   for the sequence  
    ChAmpType.LowPass=0;  %Low Pass*1000 for the sequence
    ChAmpType.Notch=0;    %Notch Filter on or off 
    
    ChanelAmps=[];
    
    % Initilize the ChannelAmps Structure with zeros
    for i=1:number_of_channels_recorded_value
      ChanelAmps = [ChanelAmps ChAmpType];
    end

    % Fill in the ChanelAmps Details
    for  i=1:number_of_channels_recorded_value 
       ChanelAmps(i).Gain=Config_Array.ContData_Suppl(400+((i-1)*10));
       ChanelAmps(i).HighPass=Config_Array.ContData_Suppl(401+((i-1)*10));
       ChanelAmps(i).LowPass=Config_Array.ContData_Suppl(402+((i-1)*10));
       ChanelAmps(i).Notch=Config_Array.ContData_Suppl(403+((i-1)*10));
    end
    
    if (OAEChannel>0 )
       ChanelAmps(OAEChannel_RawChNum).Gain=Config_Array.ContData_Suppl(400+((OAEChannel_RawChNum-1)*10))/1000;   % OAE amplification DOES NOT have a preaplification of 1000
       ChanelAmps(OAEChannel_RawChNum).HighPass=-1;
       ChanelAmps(OAEChannel_RawChNum).LowPass=-1;
       ChanelAmps(OAEChannel_RawChNum).Notch=Config_Array.ContData_Suppl(403+((OAEChannel_RawChNum-1)*10));        
        
    end   
    
    
    
  end

  try
  
      datalength = floor(length(data_eeg)/number_of_channels_recorded_value);
  
  ChannelData = zeros(number_of_channels_recorded_value,datalength);
  
  catch
    
    message = 'The file seleced is not an EEG file';

        msgbox(message,'Error!!!','warn');
    
end
 
  
  for i=1:number_of_channels_recorded_value
     if ((DigitalChannel==1) &&  (i==number_of_channels_recorded_value))
       ChScaler=1;  
     else
       ChScaler=10* 1e6 /32767/ChanelAmps(i).Gain; 
     end
       
     tempdat=data_eeg(i:number_of_channels_recorded_value:end); 
     ChannelData(i,:)=tempdat*ChScaler;
  end  
  
  timee=(0:datalength-1)*Sampletime;

  

 Samprate= (1000/Sampletime)  ;  % 1000 is because of conversion due from ms to seconds 
 
 averaged=zeros(number_of_channels_recorded_value,Seq1SweepLength);  
 t=(0:Seq1SweepLength-1)*Sampletime;
 t=t-0.9;  % correction for tube length sound travel time (0.9 ms) 
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This part of the program assignes the following values to the variables of
%this function: gain,sampling frequency, samples per sweep; and number of sweeps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
channels_available = 8;
gain_value = zeros(1,channels_available);

for kk = 1:number_of_channels_recorded_value

    gain_value(1,kk) = ChanelAmps(kk).Gain;  %Gain of the amplifier;

end

sweeps_value = floor(size(ChannelData,2)/Seq1SweepLength); %Calculates the number of sweeps;

EEG.data = ChannelData;
EEG.nbchan = number_of_channels_recorded_value;
EEG.pnts = size(ChannelData,2);
EEG.srate = Samprate;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%The value "0" has been added to make sure that if the trigger happens to
%be in location "1", the function is able to detect it. The locs is then 
%reduced by "1" to account for the addition of the "0" 
[pks_temp,locs_temp] = findpeaks(abs([0 ChannelData(end,:)]),'minpeakheight',100,'minpeakdistance',1);

locs_temp = locs_temp - 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

if(mod(length(locs_temp),2) ~= 0)
   
    locs_temp(end) = [];
    
end

locs = locs_temp(1:interval_trig:end);
EEG.triggers = locs;

%% Saving the triggers type
if (alt_pol_option == 1)
    
trig_1 = 1;%{'1'};
trig_2 = 2;%{'2'};

else
   
    trig_1 = 1;%{'1'};
trig_2 = 1;%{'1'};
    
end

for kk = 1:length(EEG.triggers)
    
    if (mod(kk,2) ~= 0)
        
EEG.type(kk) = trig_1;

    else

        EEG.type(kk) = trig_2;

    end
end




