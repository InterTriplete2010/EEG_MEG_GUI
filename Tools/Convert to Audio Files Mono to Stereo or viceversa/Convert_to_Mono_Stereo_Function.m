function [audio_file,Fs,flag_file] = Convert_to_Mono_Stereo_Function(matrix_file)

[y, Fs] = audioread(matrix_file);

%Check if the audio file is mono or stereo
if(size(y,1) < size(y,2))
   
    if(size(y,1) > 1)
       
        audio_file = y(1,:);
        flag_file = 1;
        
    else
        
        audio_file = [y(:,1) y(:,1)];
        flag_file = 2;
        
    end
    
else
    
    if(size(y,2) > 1)
       
        audio_file = y(:,1);
        flag_file = 1;
        
    else
        
        audio_file = [y(:,1) y(:,1)];
        flag_file = 2;
        
    end
    
end