function freq_comp_function(freq_bins_number,freq_analysis,envelope_tfs,dir_selected);

clear save_trans_sst;

%Initializing the excel file where to save the data
save_trans_sst(1,1) = {'File'};
save_trans_sst(1,2) = {'100'};
save_trans_sst(1,3) = {'200'};
save_trans_sst(1,4) = {'300'};
save_trans_sst(1,5) = {'400'};
save_trans_sst(1,6) = {'500'};
save_trans_sst(1,7) = {'600'};
save_trans_sst(1,8) = {'700'};
save_trans_sst(1,9) = {'800'};
save_trans_sst(1,10) = {'900'};
save_trans_sst(1,11) = {'1000'};
save_trans_sst(1,12) = {'1100'};
save_trans_sst(1,13) = {'1200'};
save_trans_sst(1,14) = {'1300'};
save_trans_sst(1,15) = {'1400'};
save_trans_sst(1,16) = {'1500'};
save_trans_sst(1,17) = {'1600'};

cd(dir_selected)

dir_files = dir;

[files_number] = size(dir_files,1);

track_subjects = 0;

if (envelope_tfs == 1)
    
   tag_figue_1_envelope = 3;
   
else
    
    tag_figue_1_envelope = 4;
    
end

save_freq_resp_av = []; %Matrix used to the save the amplitude of the FFT for a final grand average

for ii = 3:files_number
    matrix_file = dir_files(ii).name;
    
    if (strcmp(matrix_file(1,end-2:end),'fig') == 1) 
    
        track_subjects = track_subjects + 1;
        
  matrix_file = dir_files(ii).name;      
  
  open(matrix_file)

  subplot(3,2,tag_figue_1_envelope);
  
  fig_I_tag = get(gca,'Children');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Checking which wave to analyze: envelope or tfs 
   if (envelope_tfs == 1)
       
prop_fig_I = get(fig_I_tag(2));

   else
    
    prop_fig_I = get(fig_I_tag(1));
    
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
y_data_I = prop_fig_I.YData;
x_data_I = prop_fig_I.XData;

save_freq_resp_av = [save_freq_resp_av;y_data_I];

%Find the frequency components
find_freq = zeros(1,length(freq_analysis));

for nn = 1:length(find_freq)
    
find_freq(1,nn) = find(x_data_I <= freq_analysis(nn),1,'Last');

end

array_freq = zeros(1,length(find_freq));
save_trans_sst(track_subjects + 1,1) = {matrix_file};
for kk = 1:length(find_freq)
   
    if (find_freq(kk) - freq_bins_number/2 < 1 | find_freq(kk) + freq_bins_number/2 > length(y_data_I))
       
        message = 'The frequency bin chosen is too wide or at least one frequency selected is not included in the figures. Please, select a narrower frequency bin and/or different frequency components';
msgbox(message,'Analysis aborted','warn','replace');
        return;
        
    else
    
    array_freq(1,kk) = mean(y_data_I(find_freq(kk) - freq_bins_number/2:find_freq(kk) + freq_bins_number/2));
    save_trans_sst(track_subjects + 1,kk + 1) = {array_freq(1,kk)};
    
    end
    
end

close(gcf)

    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting and saving the grand average
figure
subplot(2,1,1)
plot(x_data_I,mean(save_freq_resp_av),'k')
xlabel('\bfFrequency (Hz)')
ylabel('\bfAmplitude (\muV)')
title('\bfGrand Average')
set(gca,'fontweight','bold')
axis([min(x_data_I) max(x_data_I) 0 max(max(save_freq_resp_av))])

subplot(2,1,2)
plot(x_data_I,save_freq_resp_av(:,:)')
xlabel('\bfFrequency (Hz)')
ylabel('\bfAmplitude (\muV)')
title('\bfSingle waveforms')
set(gca,'fontweight','bold')
axis tight

saveas(gcf,['Grand_Average_' num2str(size(save_freq_resp_av,1)) '_Files.fig']) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Checking if the envelope or the tfs have bas been analyzed and save the data accordingly
if (envelope_tfs == 1)
    
    xlswrite ('Envelope_Freq_Comp',save_trans_sst)
    
else
    
    xlswrite ('TFS_Freq_Comp',save_trans_sst)
    
end