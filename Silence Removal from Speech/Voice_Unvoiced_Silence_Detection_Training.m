%This function evaluate which part of the speech is 1) voiced/unvoiced
%and 3) silence. It is based on the bayesian approach described in the book 
%"Theory and Applications of Digital Speech Processing" by Lawrence Rabiner Ronald Schafer
%(page 595 to page 603) with the addition of the Expectation Maximation (EM) algorithm 

function Voice_Unvoiced_Silence_Detection_Training(wav_file_training,wav_path_training,wav_path_test,...
    max_silence,order_filt,cf_filt,time_w,time_shift,p_silence,p_voiced,threshold_silence_train,loops_EM_algorithm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
training_box = msgbox('Training the algorithm','Training');


%Upload the stimulus used to train the algorithm
cd(wav_path_training)
    
    [time_signal_unfilt, Fs] = audioread(wav_file_training);
     %time_signal_unfilt = time_signal_unfilt + randn(length(time_signal_unfilt),1)/1000;
    
     %If it is a 2-channel signal, use only the first channel
     if (size(time_signal_unfilt,2) > 1)
        
         time_signal_unfilt = time_signal_unfilt(:,1);
         
     end
     
    %Filter the data to remove DC and low frequency background nise
    [bb,aa] = butter(order_filt,cf_filt/(Fs/2),'high');
    time_signal = filter(bb,aa,time_signal_unfilt);
        
        time_frame = round(time_w*Fs);    %Samples in each frame
        time_shift = round(time_shift*Fs);  %shift of samples for each frame
    
        numb_par = 5;   %Number of parameters to be used for then gaussian distribution
        
   matrix_par = zeros(numb_par,floor(length(time_signal)/time_shift));   %Number of frames
   
   start_t = 1;
   end_t = time_frame;
   
   order_lm = 12;   %Order of the linear model
   
   silence_time = [];
   voiced_time = [];
   
   adj_log = 10^-3; %Value used to avoid the logarithm to blow to -inf
   
 %Step I: short-time log energy of the signal
 for kk = 1:size(matrix_par,2)
     
    
     try
    
         if(mean(abs(time_signal_unfilt(start_t:end_t))) < threshold_silence_train)
            
             silence_time = [silence_time;kk];
             
         else
             
             voiced_time = [voiced_time;kk];
             
         end
         
         temp_signal = time_signal(start_t:end_t);
         
         matrix_par(1,kk) = 10*log10(adj_log + (1/time_frame)*sum(temp_signal.^2));
         
         
         %Step II: number of zero crossings per 10 ms interval
         zcd = dsp.ZeroCrossingDetector;
         matrix_par(2,kk) = double(zcd(time_signal(start_t:end_t)));
         
         %Step III: normalized short-time autocorrelation coefficient
         temp_num = 0;
         temp_den = 0;
         for mm = 2:time_frame
             
             temp_num = temp_num + temp_signal(mm)*temp_signal(mm - 1);
             
         end
         
         temp_den = sqrt(sum(temp_signal.^2).*sum(temp_signal(1:end-1).^2)) + adj_log;
         matrix_par(3,kk) = temp_num./temp_den;
         
         %Step IV: first predictor coefficient of a p = 12 linear model
         mb = ar(temp_signal,order_lm,'yw');
         
             
             matrix_par(4,kk) = mb.A(2);
       
         %Step V: normalized log prediction error
         temp_sum = 0;
         temp_r_0 = 0;
         
         for mm = 1:order_lm
             
             temp_r = 0;
             
             for nn = 1:time_frame - order_lm
                 
                 temp_r = temp_r + temp_signal(nn)*temp_signal(nn + mm);
                 
             end
             
             temp_r = temp_r*(1/time_frame);
             
             temp_sum = temp_sum + mb.A(mm + 1)*temp_r;
             
             if (mm == 1)
                 
                 temp_r_0 = temp_r;
                 
             end
             
         end
         
       matrix_par(5,kk) = 10*log10(adj_log + temp_r_0 - temp_sum) - 10*log10(adj_log + temp_r_0);
         
         start_t = start_t + time_shift;
         end_t = end_t + time_shift;
         
     catch
         
         break;
     end
     
 end
 
 if (length(silence_time) < 2)
    
     close (training_box);
     msgbox('The threshold for silence is too low and no points have been found. Consider replacing it with a higher value','Operation aborted','warn')
     
     return;
     
 end
 
   matrix_par(:,kk:end) = [];
 
   matrix_par_silence = matrix_par(:,silence_time);
   
   %Check if NaN have been generated and remove the column(s) associated with them
   for nan_index = 1:size(matrix_par_silence,1)
       
   temp_nan = find(isnan(matrix_par_silence(nan_index,:)) == 1);
   
   matrix_par_silence(:,temp_nan) = [];
   
   end
   
   mean_silence = mean(matrix_par_silence');
   cov_silence = cov(matrix_par_silence');
   
   matrix_par_voiced = matrix_par(:,voiced_time);
   
   %Check if NaN have been generated and remove the column(s) associated with them
   for nan_index = 1:size(matrix_par_silence,1)
       
   temp_nan = find(isnan(matrix_par_voiced(nan_index,:)) == 1);
   
   matrix_par_voiced(:,temp_nan) = [];
   
   end
   
   mean_voiced = mean(matrix_par_voiced');
   cov_voiced = cov(matrix_par_voiced');
   
   try
       
   [mean_silence,cov_silence,p_silence,mean_voiced,cov_voiced,p_voiced] = EM_Algorithm(matrix_par,mean_silence',cov_silence,p_silence,mean_voiced',cov_voiced,p_voiced,loops_EM_algorithm);
   
   catch
       
       close (training_box);
       
     msgbox('The covariance matrix of the training data must be a square, symmetric, positive definite matrix. Consider changing the parameters of the analysis','Operation aborted')
       
     return;
       
   end
   
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   close (training_box);
   
   testing_box = msgbox('Applying the algorithm to the waveforms stored in the selected folder, removing silence and saving the new wave files','Applying the algorithm');
   
   %Now let's upload the wavefile that needs to be adjusted
   cd(wav_path_test)
   
   curr_dir = dir;
   build_filt = 1;
   
   num_chan = 1;
   
   for ll = 3:length(curr_dir)
       
       if(strcmp(curr_dir(ll).name(end-2:end),'wav') == 1)
           
           display(['File being analyzed: ' curr_dir(ll).name]);
           
           test_signal_unfilt = [];
   [test_signal_unfilt, Fs] = audioread(curr_dir(ll).name);
      %test_signal_unfilt = test_signal_unfilt + randn(length(test_signal_unfilt),1)/1000;
      
      %If it is a 2-channel signal, use only the first channel
     if (size(test_signal_unfilt,2) > 1)
        
         test_signal_unfilt = test_signal_unfilt(:,1);
         num_chan = 2;
         
     end
      
    if (build_filt == 1)
        
        [bb,aa] = butter(order_filt,cf_filt/(Fs/2),'high');
        
        build_filt = 0;
        
    end
    
     %Filter the data to remove DC and low frequency background noise
     test_signal = [];
       test_signal = filter(bb,aa,test_signal_unfilt);
    
    start_t = 1;
   end_t = time_frame;
   
   silence_time = [];
   voiced_time = [];
   
%    norm_signal = test_signal./abs(max(test_signal));
%     
%     tt = (0:length(norm_signal) - 1)/Fs;
%    
%    figure
%    plot(tt,norm_signal,'g')
%    hold on
%    title('Green = Normalized Signal; Red = Silence; Blue = Voiced; Black = Equal probability')
%    pause(1)
   
   start_track_time_silence = 0;
   duration_silence = 0;
   flag_silence = 1;
   silence_window = round(max_silence*Fs);
   track_samples_to_remove = 1;
   samples_to_remove = {};
   
 %Step I: short-time log energy of the signal
 for kk = 1:length(test_signal)
     
     test_matrix_par = zeros(numb_par,1);
     
     try
         
         temp_signal = test_signal(start_t:end_t);
         
         test_matrix_par(1,1) = 10*log10(adj_log + (1/time_frame)*sum(temp_signal.^2));
         
         
         %Step II: numer of zero crossings per 10 ms interval
         zcd = dsp.ZeroCrossingDetector;
         test_matrix_par(2,1) = zcd(temp_signal);
         
         %Step III: normalized short-time autocorrelation coefficient
         temp_num = 0;
         temp_den = 0;
         
         for mm = 2:time_frame
             
             temp_num = temp_num + temp_signal(mm)*temp_signal(mm - 1);
             
         end
         
         temp_den = sqrt(sum(temp_signal.^2).*sum(temp_signal(1:end-1).^2)) + adj_log;
         test_matrix_par(3,1) = temp_num./temp_den;
         
         %Step IV: first predictor coefficient of a p = 12 linear model
         mb = ar(temp_signal,order_lm,'yw');
         
         test_matrix_par(4,1) = mb.A(2);
         
         %Step V: normalized log prediction error
         temp_sum = 0;
         temp_r_0 = 0;
         
         for mm = 1:order_lm
             
             temp_r = 0;
             
             for nn = 1:time_frame - order_lm
                 
                 temp_r = temp_r + temp_signal(nn)*temp_signal(nn + mm);
                 
             end
             
             temp_r = temp_r*(1/time_frame);
             
             temp_sum = temp_sum + mb.A(mm + 1)*temp_r;
             
             if (mm == 1)
                 
                 temp_r_0 = temp_r;
                 
             end
             
         end
         
         test_matrix_par(5,1) = 10*log10(adj_log + temp_r_0 - temp_sum) - 10*log10(adj_log + temp_r_0);
         
         
     catch
         
         break;
     end
     
     %Check if NaN have been generated and if it has, assign a default
     %value of 0 => silence      
   if sum(isnan(test_matrix_par > 0))
   
  test_matrix_par(:,:) = 0;
   
   end
     
     try
         
         temp_gauss_silence = mvnpdf(test_matrix_par,mean_silence',cov_silence);
         
     catch %Fix the covariance matrix in case it is not a positive definite matrix due to numerical error
         
         [V,D] = eig(cov_silence);       % Calculate the eigendecomposition of your matrix (A = V*D*V')
         % where "D" is a diagonal matrix holding the eigenvalues of your matrix "A"
         d = diag(D);           % Get the eigenvalues in a vector "d"
         d(d <= 1e-7) = 1e-7;  % Set any eigenvalues that are lower than threshold "TH" ("TH" here being
         % equal to 1e-7) to a fixed non-zero "small" value (here assumed equal to 1e-7)
         D_c = diag(d);        % Built the "corrected" diagonal matrix "D_c"
         temp_cov_silence = real(V*D_c*V');
         
         temp_gauss_silence = mvnpdf(test_matrix_par,mean_silence',temp_cov_silence);
         
     end
     
     try
         
         temp_gauss_voiced = mvnpdf(test_matrix_par,mean_voiced',cov_voiced);
         
     catch
         
         [V,D] = eig(cov_voiced);       % Calculate the eigendecomposition of your matrix (A = V*D*V')
         % where "D" is a diagonal matrix holding the eigenvalues of your matrix "A"
         d = diag(D);           % Get the eigenvalues in a vector "d"
         d(d <= 1e-7) = 1e-7;  % Set any eigenvalues that are lower than threshold "TH" ("TH" here being
         % equal to 1e-7) to a fixed non-zero "small" value (here assumed equal to 1e-7)
         D_c = diag(d);        % Built the "corrected" diagonal matrix "D_c"
         temp_cov_voiced = real(V*D_c*V');
         
         temp_gauss_voiced = mvnpdf(test_matrix_par,mean_voiced',temp_cov_voiced);
         
     end
     
     class_silence = p_silence*temp_gauss_silence;
    class_voiced = p_voiced*temp_gauss_voiced;
    
    %If equal probability, then assign the sample to silence
    if class_silence >= class_voiced
    
%       classes(kk) = {'S'};
%       plot(tt(round(mean(start_t:end_t))),0.5,'ro');
%      
       if(flag_silence == 1)
           
           start_track_time_silence = start_t;
           flag_silence = 0;
           
       end
       
    elseif class_silence < class_voiced
        
%         classes(kk) = {'V'};
%         plot(tt(round(mean(start_t:end_t))),1,'bo');
%        
        if(flag_silence == 0)
            
            duration_silence = end_t - time_shift - start_track_time_silence;
            
            if (duration_silence > silence_window)
               
                interval_time = duration_silence - silence_window;
                temp_median = round(median(start_track_time_silence:end_t - time_shift));
                samples_to_remove(track_samples_to_remove,:) = {(temp_median - round(interval_time/2): temp_median + round(interval_time/2))};
                
                track_samples_to_remove = track_samples_to_remove + 1;
                
            end
            
            start_track_time_silence = 0;
            flag_silence = 1;
            
        end
        
        
    %else
        
%         classes(kk) = {'NC'};
%         plot(tt(round(mean(start_t:end_t))),0,'ko');
%        
    end
     
    %pause(0.01)
     start_t = start_t + time_shift;
         end_t = end_t + time_shift;
         
 end
 
 %If the waveform ends with a silence segment, check if the the last
 %segment needs to be shortened
 end_t = length(test_signal);
 duration_silence = end_t - time_shift - start_track_time_silence;
 if (duration_silence > silence_window & start_track_time_silence ~= 0)
               
                interval_time = duration_silence - silence_window;
                temp_median = round(median(start_track_time_silence:end_t - time_shift));
                samples_to_remove(track_samples_to_remove,:) = {(temp_median - round(interval_time/2): temp_median + round(interval_time/2))};
                
 end
 
 for kk = length(samples_to_remove):-1:1
 
     temp_interval = cell2mat(samples_to_remove(kk));
     test_signal_unfilt(temp_interval,:) = [];
 
 end
 
 figure
 tt = (0:length(test_signal_unfilt)-1)/Fs;
 plot(1000*tt,test_signal_unfilt)
 
 if (num_chan == 2)
     
 audiowrite([curr_dir(ll).name(1:end-4) '_Shortened_Waveform.wav'],[test_signal_unfilt test_signal_unfilt],Fs);
 
 else
     
     audiowrite([curr_dir(ll).name(1:end-4) '_Shortened_Waveform.wav'],test_signal_unfilt,Fs);
     
 end
 
 num_chan = 1;
 
       end
   end
   
   close (testing_box)
 
 msgbox('End of the analysis','End of the analysis')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

