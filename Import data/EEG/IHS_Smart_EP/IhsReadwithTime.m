function [Buffer1, Buffer2, timearrayout, confarray, comments, s_per, DataPointsNum]=IhsReadwithTime(filepath);

  fullfilename=filepath;
  
  ptr1=fopen(fullfilename,'rb');  % warning     1 is one;
       
  if ptr1~=-1
     
      
     
    version=fread(ptr1,8,'char');
    
    frewind(ptr1);
    
    if ~(strcmp( char(version(2:end)' ),'2010-01')  )
      
     
       %------------------For Versions before   04_01_2001-------------------
     
    
       odd=fread(ptr1,1024,'int32');
       even=fread(ptr1,1024,'int32');
       confarray=fread(ptr1,500,'int16');   
       comments=fread(ptr1,100,'char');
     
       DataPointsNum=1024;
      %------------------For Versions before   04_01_2001-------------------    
     
    else
      %------------------For Versions After   04_01_2001-------------------
       Soft_Version=fread(ptr1,10,'char');
       DataPointsNum=fread(ptr1,1,'int32');
       confarray=fread(ptr1,2000,'int16');
       comments.comments1=fread(ptr1,100,'char');
       comments.comments2=fread(ptr1,100,'char');
       comments.comments3=fread(ptr1,100,'char');
       odd=fread(ptr1,DataPointsNum,'int32');
       even=fread(ptr1,DataPointsNum,'int32');    
       %------------------For Versions After   04_01_2001-------------------
    end;  
         
   
    if confarray(3)==1
       handles.control_stimmode='Rarefaction';
    else
       handles.control_stimmode='Condensation';
    end   
       handles.control_intensity=confarray(4);
    
    if confarray(5)==1
       handles.control_ear='Left';
    elseif confarray(5)==2
       handles.control_ear='Right';
    else
       handles.control_ear='Both'; 
    end 
    
    sweep=confarray(6); 
    stimrate=confarray(8);      %+confarray(17)/100
    sampletime=confarray(7)/1000;
    gain=confarray(10)*1000;
    timezeroposition=confarray(112);
    snr=confarray(132)/100;
    stimfrequency=confarray(14)/1000;     
    
    rectime=[];
    for recindex=1:8                %lower loop  
        rectime=[rectime num2str(confarray(120+recindex))];  
    end  
       handles.data_rectime=rectime;
              
    handles.data_bloodfl=confarray(147)/100;
            
    scaler=(20*1000000/(65536*gain*sweep));
        
    Buffer1=(odd*scaler*2)';  %transpose is taken for speed purposes
    Buffer2=(even*scaler*2)';
       
    averaged=(Buffer1+Buffer2)/2; 
    PlusMinus=(Buffer1-Buffer2)/2;
 
    s_per=sampletime;
 
    if (timezeroposition == 0)
    
        timearrayout=((0:DataPointsNum-1)-timezeroposition)* s_per -0.9; 
    %0.9ms is the delay due to the transmission of the signal through the
    %ear-phone. Added only if SEPCAM is used
    
    else
        
        timearrayout=((0:DataPointsNum-1)-timezeroposition)* s_per; 
    
    end
    
    
    fclose (ptr1);
    
  end % for if ptr 
     
     
   
 
     
     
     
     
 
 

     
     
     