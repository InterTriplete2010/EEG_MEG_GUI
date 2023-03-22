function Corr_Responses(Quiet_directory,Noise_directory,response_analyzed_name_saved,start_t_ent_resp,end_t_ent_resp)

clear save_corr;

%% Initializing the variable where to save the auto and cross-correlations
save_corr(1,1) = {'File Quiet'};
save_corr(1,2) = {'File Noise'};
save_corr(1,3) = {'Auto Corr Quiet'};
save_corr(1,4) = {'Auto Corr Noise'};
save_corr(1,5) = {'Corr'};
save_corr(1,6) = {'Corr (Fisher)'};
save_corr(1,7) = {'RMS Quiet'};
save_corr(1,8) = {'RMS Noise'};
save_corr(1,9) = {'RMS pre-stimulus (Quiet)'};
save_corr(1,10) = {'RMS pre-stimulus (Noise)'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extract Quiet
cd(Quiet_directory)

dir_files = dir;

[files_number] = size(dir_files,1);
track_subjects = 0;

save_quiet = [];
save_quiet_pre = [];

for ii = 3:files_number
              
  matrix_file = dir_files(ii).name;      
  
  if (strcmp(matrix_file(1,end-2:end),'fig') == 1) 
  
      track_subjects = track_subjects + 1;
      
      save_corr(track_subjects + 1,1) = {matrix_file};
      
    open(matrix_file)

  subplot(3,2,1);
  
  fig_I_tag = get(gca,'Children');
  
  temp_data = get(fig_I_tag(end));
  
  try
      
  if (strcmp(response_analyzed_name_saved,'Entire response'))
  
  save_quiet = [save_quiet;temp_data.YData(1,find(temp_data.XData >= start_t_ent_resp,1,'First'):find(temp_data.XData >= end_t_ent_resp,1,'First'))];
  save_quiet_pre = [save_quiet_pre;temp_data.YData(1,1:find(temp_data.XData >= 0,1,'First'))];  
     
  else
     
      save_quiet = [save_quiet;temp_data.YData];
      
  end
  
  close(gcf)
  
  catch
     
      close(gcf)
      
      message = ('The matrix dimension of the files selected must agree. The operation will be aborted and the size of each file will be calculated and saved in a Size_files file');

        msgbox(message,'Operation aborted','warn');
      

        track_files = 0;

        save_sample(1,1) = {'File Name'};
        save_sample(1,2) = {'Size vector'};
        
for zz = 3:files_number
        
    if (strcmp(dir_files(zz).name(end-3:end), '.fig') == 1)

        track_files = track_files + 1;
        
  matrix_file = dir_files(zz).name;      
  
  open(matrix_file)
  
  subplot(3,2,1);
  
  fig_I_tag = get(gca,'Children');
  
  temp_data = get(fig_I_tag(end));
        
  save_sample(track_files + 1,1) = {matrix_file};
        save_sample(track_files + 1,2) = {size(temp_data.YData,2)};
        
        close(gcf)
        
    end
    
end
        
xlswrite ('Size_files',save_sample)

close(gcf)

message = ('The size of each file has been calculated and saved');

        msgbox(message,'Operation completed','warn');

        return;
        
  end

      
  end
  
  end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extract Noise
cd(Noise_directory)

dir_files = dir;

[files_number] = size(dir_files,1);
track_subjects = 0;

save_noise = [];
save_noise_pre = [];

for ii = 3:files_number
              
  matrix_file = dir_files(ii).name;      
  
  if (strcmp(matrix_file(1,end-2:end),'fig') == 1) 
  
            
      track_subjects = track_subjects + 1;
      
      save_corr(track_subjects + 1,2) = {matrix_file};
      
    open(matrix_file)

  subplot(3,2,1);
  
  fig_I_tag = get(gca,'Children');
  
  temp_data = get(fig_I_tag(end));
  
  try
      
  if (strcmp(response_analyzed_name_saved,'Entire response'))
  
  save_noise = [save_noise;temp_data.YData(1,find(temp_data.XData >= start_t_ent_resp,1,'First'):find(temp_data.XData >= end_t_ent_resp,1,'First'))];
  save_noise_pre = [save_noise_pre;temp_data.YData(1,1:find(temp_data.XData >= 0,1,'First'))];
         
  else
     
      save_noise = [save_noise;temp_data.YData];
      
  end
  close(gcf)
  catch
     
      message = ('The matrix dimension of the files selected must agree. The operation will be aborted and the size of each file will be calculated and saved in a Size_files file');

        msgbox(message,'Operation aborted','warn');
      

        track_files = 0;

        save_sample(1,1) = {'File Name'};
        save_sample(1,2) = {'Size vector'};
        
for zz = 3:files_number
        
    if (strcmp(dir_files(zz).name(end-3:end), '.mat') == 1)

        track_files = track_files + 1;
        
  matrix_file = dir_files(zz).name;      
  
  subplot(3,2,1);
  
  fig_I_tag = get(gca,'Children');
  
  temp_data = get(fig_I_tag(end));
        
  save_sample(track_files + 1,1) = {matrix_file};
        save_sample(track_files + 1,2) = {size(temp_data.YData,2)};
            
    end
    
end
        
xlswrite ('Size_files',save_sample)

close(gcf)

message = ('The size of each file has been calculated and saved');

        msgbox(message,'Operation completed','warn');

        return;
        
  end

      
  end
  
  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate the auto and correlation
for hh = 1:size(save_quiet,1)
   
       save_corr(hh + 1,3) =  {mean(xcorr(save_quiet(hh,:),'coeff'))};
           save_corr(hh + 1,4) =  {mean(xcorr(save_noise(hh,:),'coeff'))};
                save_corr(hh + 1,5) = {corr2(save_quiet(hh,:),save_noise(hh,:))};
                
                %Transofrming the r-values with the Fisher transform
                temp_corr_fisher = corr2(save_quiet(hh,:),save_noise(hh,:));  
                temp_fish = {0.5*(log(1+temp_corr_fisher) - log(1-temp_corr_fisher))};
                    save_corr(hh + 1,6) = temp_fish;
                        save_corr(hh + 1,7) = {sqrt(mean(save_quiet(hh,:).^2))};
                            save_corr(hh + 1,8) = {sqrt(mean(save_noise(hh,:).^2))};
                        
  if (strcmp(response_analyzed_name_saved,'Entire response'))
                            
           save_corr(hh + 1,9) = {sqrt(mean(save_quiet_pre(hh,:).^2))};
                        save_corr(hh + 1,10) = {sqrt(mean(save_noise_pre(hh,:).^2))};
                        
  else
      
      save_corr(hh + 1,9) = {'NA'};
                        save_corr(hh + 1,10) = {'NA'};      
         
        end
                        
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot the auto and the correlations
figure
subplot(3,1,1)
stem(cell2mat(save_corr(2:end,3)))
xlabel('\bfSubject')
ylabel('\bfCorr value')
title('\bfAuto Correlation Quiet')

subplot(3,1,2)
stem(cell2mat(save_corr(2:end,4)))
xlabel('\bfSubject')
ylabel('\bfCorr value')
title('\bfAuto Correlation Noise')

subplot(3,1,3)
stem(cell2mat(save_corr(2:end,5)))
xlabel('\bfSubject')
ylabel('\bfCorr value')
title('\bfCorrelation')

figure
subplot(2,1,1)
stem(cell2mat(save_corr(2:end,7)))
xlabel('\bfSubject')
ylabel('\bfRMS')
title('\bfRMS Quiet')

subplot(2,1,2)
stem(cell2mat(save_corr(2:end,8)))
xlabel('\bfSubject')
ylabel('\bfRMS')
title('\bfRMS Noise')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlswrite (cell2mat(response_analyzed_name_saved),save_corr)

message = 'The auto, correlation and RMS values have been calcuated and saved in an excel file';

        msgbox(message,'Calculations completed','warn');

