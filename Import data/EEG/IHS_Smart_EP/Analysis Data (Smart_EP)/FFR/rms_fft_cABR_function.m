function rms_fft_cABR_function(IHS_file_directory,lf_buttw_filt,hf_buttw_filt,order_buttw_filt,pre_stim_start,pre_stim_end,post_stim_start,post_stim_end,...
    minimum_threshold_peaks,minimum_distance_peaks,norm_factor,filter_data_FFR,wfft,offt,nfft)

calcuate_transfer_function = 1;

cd(IHS_file_directory)

mat_files = dir;

[files_number] = size(mat_files,1);

%Matrix where to save the peaks
save_picks = cell(2,12);

for ii = 3:files_number
    
    if (strcmp(mat_files(ii).name(end-3:end), '.mat') == 1)
        
        try
            
            matrix_file = mat_files(ii).name;
            
            display(['Current file: ' matrix_file]);
            
            load(matrix_file);
            
            if (calcuate_transfer_function == 1)
                
                [b,a] = butter(order_buttw_filt,[lf_buttw_filt hf_buttw_filt]/(data_exported.sampling_frequency/2));
                
                calcuate_transfer_function = 0;
                
            end
            
            if filter_data_FFR == 1
                
                average_sweeps_filtered = filtfilt(b,a,data_exported.grand_av);
                
            else
                
                average_sweeps_filtered = data_exported.grand_av;
                
            end
            
            av_polarity_1_matrix = [];
            av_polarity_2_matrix = [];
            
            for kk = 1:size(data_exported.odd_even_sweeps,2)
                
                av_polarity_1_matrix = [av_polarity_1_matrix;squeeze(data_exported.odd_even_sweeps(1,kk,:))'];
                av_polarity_2_matrix = [av_polarity_2_matrix;squeeze(data_exported.odd_even_sweeps(2,kk,:))'];
                
            end
            
            %av_polarity_1 = (data_exported.odd_sweeps_1 + data_exported.odd_sweeps_2)/2;
            %av_polarity_2 = (data_exported.even_sweeps_1 + data_exported.even_sweeps_2)/2;
            
            if(size(av_polarity_1_matrix,1) > 1)
                
                av_polarity_1 = mean(av_polarity_1_matrix);
                av_polarity_2 = mean(av_polarity_2_matrix);
                
            else
                
                av_polarity_1 = av_polarity_1_matrix;
                av_polarity_2 = av_polarity_2_matrix;
                
            end
            
            sub_polarity = -(av_polarity_2 - av_polarity_1)/2;
            
            sub_polarity_sweeps_filtered = filtfilt(b,a,sub_polarity);
            
            sub_polarity_interval = sub_polarity_sweeps_filtered(find(data_exported.time >= post_stim_start,1,'First'):find(data_exported.time >= post_stim_end,1,'First'));
            
            %pre_stim_data = average_sweeps_filtered(pre_stim_start*data_exported.sampling_frequency:pre_stim_end*data_exported.sampling_frequency);
            pre_stim_data = average_sweeps_filtered(1:data_exported.time_zero_position);
            post_stim_data = average_sweeps_filtered(find(data_exported.time >= post_stim_start,1,'First'):find(data_exported.time >= post_stim_end,1,'First'));
            
            rms_pre_stim = sqrt(mean(pre_stim_data.^2));
            rms_post_stim = sqrt(mean(post_stim_data.^2));
            
            save_rms(1) = rms_pre_stim;
            save_rms(2) = rms_post_stim;
            
            snr_data = 20*log10(rms_post_stim/rms_pre_stim);
            %rms_post_stim/rms_pre_stim
            figure
            %% Plotting the analysis for the addition
            subplot(3,2,1)
            plot(data_exported.time,average_sweeps_filtered)
            
            xlabel('\bfTime(ms)')
            ylabel('\bfAmplitude(uV)')
            title(['\bfFFR of ' matrix_file(1:end-4) ' with SNR: ' num2str(snr_data)])
            
            line(data_exported.time(data_exported.time_zero_position + 1), [min(average_sweeps_filtered):0.001:max(average_sweeps_filtered)])
            
            set(gca,'fontweight','bold')
            
            axis tight
            
            subplot(3,2,3)
            
            %try
            %[PPx Freq] = pwelch(post_stim_data,length(post_stim_data),length(post_stim_data)/2,data_exported.sampling_frequency,data_exported.sampling_frequency);
            
            %catch
            
            [PPx Freq] = pwelch(post_stim_data,round(wfft*data_exported.sampling_frequency),round(offt*data_exported.sampling_frequency),round(nfft*data_exported.sampling_frequency),data_exported.sampling_frequency);
            
            %end
            
            find_1Kz = find(Freq <= 1000,1,'Last');
            
            plot(Freq(1:find_1Kz),sqrt(PPx(1:find_1Kz)))
            
            xlabel('\bfFrequency(Hz)')
            ylabel('\bfAmplitude(uV)')
            title('\bfAmplitude of FFR')
            
            set(gca,'fontweight','bold')
            
            subplot(3,2,5)
            
            plot(Freq(1:find_1Kz),PPx(1:find_1Kz))
            
            xlabel('\bfFrequency(Hz)')
            ylabel('\bfPSD')
            title('\bfPSD of FFR')
            
            set(gca,'fontweight','bold')
            
            %Saving the info about the average (sum)
            average.onset = data_exported.time_zero_position;
            average.sampling_frequency = data_exported.sampling_frequency;
            average.add_time = average_sweeps_filtered;
            average.add_fourier_power = PPx';
            average.add_fourier_frequency = Freq';
            
            %% Plotting the analysis for the subtraction
            subplot(3,2,2)
            plot(data_exported.time,sub_polarity_sweeps_filtered)
            
            xlabel('\bfTime(ms)')
            ylabel('\bfAmplitude(uV)')
            title('\bfFFR (Fine Structure)')
            
            line(data_exported.time(data_exported.time_zero_position + 1), [min(sub_polarity_sweeps_filtered):0.001:max(sub_polarity_sweeps_filtered)])
            
            set(gca,'fontweight','bold')
            
            axis tight
            
            subplot(3,2,4)
            
            %try
            
            %[PPx Freq] = pwelch(sub_polarity_interval,length(post_stim_data),length(post_stim_data)/2,data_exported.sampling_frequency,data_exported.sampling_frequency);
            
            %catch
            
            [PPx Freq] = pwelch(sub_polarity_interval,round(wfft*data_exported.sampling_frequency),round(offt*data_exported.sampling_frequency),round(nfft*data_exported.sampling_frequency),data_exported.sampling_frequency);
            
            %end
            
            find_1Kz = find(Freq <= 1000,1,'Last');
            
            plot(Freq(1:find_1Kz),sqrt(PPx(1:find_1Kz)))
            
            xlabel('\bfFrequency(Hz)')
            ylabel('\bfAmplitude(uV)')
            title('\bfAmplitude of FFR (Fine Structure)')
            
            set(gca,'fontweight','bold')
            
            subplot(3,2,3)
            hold on
            plot(Freq(1:find_1Kz),sqrt(PPx(1:find_1Kz)),'r')
            hold off
            
            legend('Envelope','Fine Structure')
            
            subplot(3,2,6)
            
            plot(Freq(1:find_1Kz),PPx(1:find_1Kz))
            
            xlabel('\bfFrequency(Hz)')
            ylabel('\bfPSD')
            title('\bfPSD of FFR (Fine Structure)')
            
            set(gca,'fontweight','bold')
            
            subplot(3,2,5)
            hold on
            plot(Freq(1:find_1Kz),PPx(1:find_1Kz),'r')
            hold off
            
            legend('Envelope','Fine Structure')
            
            saveas(gcf,['Time_FFT_' matrix_file(1:end-4) '.fig'])
            %saveas(gcf,['Time_FFT_' matrix_file(1:end-4) '.png'])
            
            figure
            bar(save_rms)
            xlabel('\bfPre-Post')
            ylabel('\bfRMS')
            title(['\bfRMS values pre/post of ' matrix_file(1:end-4)])
            
            set(gca,'xticklabel',{' Pre';'Post'});
            set(gca,'fontweight','bold')
            
            legend(num2str(save_rms))
            
            saveas(gcf,['RMS_' matrix_file(1:end-4) '.fig'])
            %saveas(gcf,['RMS_' matrix_file(1:end-4) '.png'])
            
            %Saving the info about the average (sub)
            average.sub_time = sub_polarity_sweeps_filtered;
            average.sub_fourier_power = PPx';
            average.sub_fourier_frequency = Freq';
            
            average.rms_pre = save_rms(1);
            average.rms_post = save_rms(2);
            
            save_eeg = ['Average_' matrix_file(1:end-4) '_rms_fft.' 'mat'];
            save (save_eeg,'average')
            
            %% Detecting the peaks of the post-stimulus
            minimum_distance_peaks_function = round((minimum_distance_peaks/1000)*data_exported.sampling_frequency);
            
            time_d = data_exported.time(find(data_exported.time >= post_stim_start,1,'First'):find(data_exported.time >= post_stim_end,1,'First'));
            
            %[pks,locs] = findpeaks(post_stim_data,'minpeakheight',minimum_threshold_peaks,'minpeakdistance',find(minimum_distance_peaks >= data_exported.time,1,'First'));
            [pks,locs] = findpeaks(post_stim_data,'minpeakheight',minimum_threshold_peaks,'minpeakdistance',minimum_distance_peaks_function);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Eliminating the fake peaks
            for kk = 1:length(norm_factor)
                
                find_current_peak = find(time_d(locs) <= norm_factor(kk));
                
                temp_peaks(kk) = pks(find_current_peak(end));
                temp_loc(kk) = locs(find_current_peak(end));
                
            end
            
            pks = temp_peaks;
            locs = temp_loc;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            figure
            plot(time_d,post_stim_data); hold on;
            plot(time_d(locs),pks+0.005,'k^','markerfacecolor',[1 0 0]);
            
            xlabel('\bfTime (ms)')
            ylabel('\bfAmplitue(uV)')
            title(['\bfPeaks of file ' matrix_file(1:end-4)])
            
            set(gca,'fontweight','bold')
            
            %axis tight
            
            saveas(gcf,['Peaks_FFR_' matrix_file(1:end-4) '.fig'])
            %saveas(gcf,['RMS_' matrix_file(1:end-4) '.png'])
            
            hold off
            
            try
                
                save_picks_cABR(2,:) = num2cell(time_d(locs));
                save_picks_cABR(1,:) = {'Latency (ms)'};
                
                save_picks_cABR(4,:) = {'Amplitude (uV)'};
                save_picks_cABR(5,:) = num2cell(pks);
                
                xlswrite (['Peaks_File_' matrix_file(1:end-4)],save_picks_cABR)
                
            catch
                
                message = ['No peak has been detected for the file: ' matrix_file(1:end-4) '. Change the threshold to detect the peaks'];
                
                msgbox(message,'No peak detected','warn');
                
            end
            
            clear save_picks_cABR;
            
        catch
            
        end
        
    end
    
end
