function Pitch_Detector_Analysis(path_pitch,time_start,time_end,loops_FFT,...
    data_type_selected,sensor_selected,handle_GUI,analysis_chosen,CL_level_ac)

cd(path_pitch)

curr_dir = dir;

files_analyzed = msgbox('Analysis in progress','Files are being analyzed');

for ll = 3:length(curr_dir)
    
    if(strcmp(curr_dir(ll).name(end-2:end),'wav') == 1 || strcmp(curr_dir(ll).name(end-2:end),'mat'))
        
        display(['File being analyzed: ' curr_dir(ll).name]);
        
        file_data = [];
        
        try
            
            %Upload the files
            switch data_type_selected
                
                case 1
                    
                    [file_data,Fs] = audioread(curr_dir(ll).name);
                    
                    time_data = 1000*(0:length(file_data)-1)/Fs;
                    
                    first_s = find(time_start <= time_data,1,'First');
                    
                    if isempty(first_s)
                        
                        first_s = 1;
                        set(handle_GUI.Start_T,'String',first_s);
                        
                    end
                    
                    last_s = find(time_end <= time_data,1,'First');
                    
                    if isempty(last_s)
                        
                        last_s = length(time_data);
                        set(handle_GUI.End_T,'String',1000*last_s/Fs);
                        
                    end
                    
                    file_data = file_data(first_s:last_s,sensor_selected)';
                    
                case 2
                    
                    file_data_structure = load(curr_dir(ll).name);
                    
                    try
                        
                        first_s = find(time_start <= file_data_structure.data_exported.time,1,'First');
                        length_time = file_data_structure.data_exported.time;
                        
                    catch
                        
                        first_s = find(time_start <= file_data_structure.data_exported.time_average,1,'Last');
                        length_time = file_data_structure.data_exported.time_average;
                        
                    end
                    
                    if isempty(first_s)
                        
                        first_s = 1;
                        set(handle_GUI.Start_T,'String',first_s);
                        
                    end
                    
                    last_s = find(time_end >= file_data_structure.data_exported.time_average,1,'First');
                    
                    if isempty(last_s)
                        
                        last_s = length_time;
                        set(handle_GUI.End_T,'String',1000*last_s/Fs);
                        
                    end
                    
                    
                    file_data = file_data_structure.data_exported.eeg_data(sensor_selected,first_s:last_s);
                    
                    
                case 3
                    
                    file_data_structure = load(curr_dir(ll).name);
                    
                    try
                        
                        first_s = find(time_start <= file_data_structure.data_exported.time,1,'First');
                        length_time = file_data_structure.data_exported.time;
                        
                    catch
                        
                        first_s = find(time_start <= file_data_structure.data_exported.time_average,1,'Last');
                        length_time = file_data_structure.data_exported.time_average;
                        
                    end
                    
                    if isempty(first_s)
                        
                        first_s = 1;
                        set(handle_GUI.Start_T,'String',first_s);
                        
                    end
                    
                    last_s = find(time_end >= file_data_structure.data_exported.time_average,1,'First');
                    
                    if isempty(last_s)
                        
                        last_s = length_time;
                        set(handle_GUI.End_T,'String',1000*last_s/Fs);
                        
                    end
                    
                    file_data = file_data_structure.data_exported.average_trials(sensor_selected,sensor_selected,first_s:last_s);
                    
                case 4
                    
                    file_data_structure = load(curr_dir(ll).name);
                    
                    try
                        
                        first_s = find(time_start <= file_data_structure.data_exported.time,1,'First');
                        length_time = file_data_structure.data_exported.time;
                        
                    catch
                        
                        first_s = find(time_start <= file_data_structure.data_exported.time_average,1,'Last');
                        length_time = file_data_structure.data_exported.time_average;
                        
                    end
                    
                    if isempty(first_s)
                        
                        first_s = 1;
                        set(handle_GUI.Start_T,'String',first_s);
                        
                    end
                    
                    last_s = find(time_end >= file_data_structure.data_exported.time_average,1,'First');
                    
                    if isempty(last_s)
                        
                        last_s = length_time;
                        set(handle_GUI.End_T,'String',1000*last_s/Fs);
                        
                    end
                    
                    file_data = file_data_structure.data_exported.average_add(sensor_selected,sensor_selected,first_s:last_s);
                    
                case 5
                    
                    file_data_structure = load(curr_dir(ll).name);
                    
                    try
                        
                        first_s = find(time_start <= file_data_structure.data_exported.time,1,'First');
                        length_time = file_data_structure.data_exported.time;
                        
                    catch
                        
                        first_s = find(time_start <= file_data_structure.data_exported.time_average,1,'Last');
                        length_time = file_data_structure.data_exported.time_average;
                        
                    end
                    
                    if isempty(first_s)
                        
                        first_s = 1;
                        set(handle_GUI.Start_T,'String',first_s);
                        
                    end
                    
                    last_s = find(time_end >= file_data_structure.data_exported.time_average,1,'First');
                    
                    if isempty(last_s)
                        
                        last_s = length_time;
                        set(handle_GUI.End_T,'String',1000*last_s/Fs);
                        
                    end
                    
                    file_data = file_data_structure.data_exported.average_sub(sensor_selected,sensor_selected,first_s:last_s);
                    
            end
            
        catch
            
            msgbox('Wrong choice of the type of data to be analyzed','Analysis aborted')
            
            return;
            
        end
        
        switch analysis_chosen
            
            %Auto-correlation Analysis
            case 1
                
                ff1 = (0:length(file_data) - 1)*(Fs/length(file_data));
                
                CL = max(file_data)*CL_level_ac/100;
                
                temp_file_data_ac = [];
                
                temp_file_data_ac = file_data;
                
                temp_file_data_ac(file_data > CL) = 1;
                temp_file_data_ac(file_data < -CL) = -1;
                temp_file_data_ac(file_data < CL & file_data > -CL) = 0;
                
                curr_fig = figure;
                subplot(3,1,1)
                temp_fft = 20*log10(abs(fft(file_data)));
                plot(ff1(1:floor(length(file_data)/2)),temp_fft(1:floor(length(temp_fft)/2)));
                
                title('FFT of the original file')
                xlabel('\bfFrequency (Hz)')
                ylabel('\bfAmplitude (AU)')
                
                
                tt = 1000*(0:length(file_data)-1)/Fs;
                
                subplot(3,1,2)
                plot(tt,file_data)
                
                hold on
                plot(tt,temp_file_data_ac,'r')
                
                title('Auto-Correlation')
                xlabel('\bfTime (ms)')
                ylabel('\bfAmplitude (AU)')
                
                legend('Unclipped','Clipped')
                
                hold off
                
                subplot(3,1,3)
                [auto_corr, lags] = xcorr(temp_file_data_ac,'coeff');
                     
                    plot(1000*lags/Fs,auto_corr)
                               
                title('Auto-Correlation')
                xlabel('\bfLag (ms)')
                ylabel('\bfAmplitude (AU)')
                
                try
                    
                    saveas(gcf,['Pitch_' curr_dir(ll).name(1:end-4) '_' cell2mat(sensor_selected) '_Auto_Corr_Analysis.fig'])
                    
                catch
                    
                    saveas(gcf,['Pitch_' curr_dir(ll).name(1:end-4) '_' num2str(sensor_selected) '_Auto_Corr_Analysis.fig'])
                    
                end
                
                close(curr_fig)
                
                %Cepstrum Analysis
            case 2
                
                file_data_cepstrum = [];
                
                file_data_cepstrum = cceps(file_data'.*hamming(length(file_data)));
                
                ff1 = (0:length(file_data) - 1)*(Fs/length(file_data));
                
                curr_fig = figure;
                subplot(2,1,1)
                temp_fft = 20*log10(abs(fft(file_data)));
                plot(ff1(1:floor(length(file_data)/2)),temp_fft(1:floor(length(temp_fft)/2)));
                
                title('FFT of the original file')
                xlabel('\bfFrequency (Hz)')
                ylabel('\bfAmplitude (AU)')
                
                
                subplot(2,1,2)
                tt = 1000*(0:length(file_data_cepstrum)-1)/Fs;
                plot(tt,file_data_cepstrum)
                
                
                title('Complex Cepstrum')
                xlabel('\bfQuefrency (ms)')
                ylabel('\bfAmplitude (AU)')
                
                try
                    
                    saveas(gcf,['Pitch_' curr_dir(ll).name(1:end-4) '_' cell2mat(sensor_selected) '_Cepstrum_Analysis.fig'])
                    
                catch
                    
                    saveas(gcf,['Pitch_' curr_dir(ll).name(1:end-4) '_' num2str(sensor_selected) '_Cepstrum_Analysis.fig'])
                    
                end
                
                close(curr_fig)
                
                %Spectral Domain Analysis
            case 3
                
                %% Now caluclate the DFT manually
                tt = (0:length(file_data) - 1)/Fs;
                N = length(tt); %Number of samples
                Nf = N;   %number of frequencies
                
                mat_fft_1 = zeros(Nf,N); %matrix with the sin/cos values
                dft_val_1 = zeros(1,Nf); %Frequencies to be analyzed.
                
                for kk = 1:loops_FFT
                    %The first loop is for the frequency (it goes from DC to N*T)
                    for sample_k = 0:length(dft_val_1) - 1
                        
                        %The DFT assumes the signal to be periodic => the fundamental frequency is 1/N*T, where N is the number
                        %of samples (1000 in our case) and T is the sampling period, which has to be equivalent to the number of samples to have periodicity.
                        
                        W1 = -kk*(1i)*2*pi*sample_k/(Nf);
                        
                        %The second loop is the for the samples. This loop populates the matrix
                        %with the cos/sin values
                        for samples_n = 0:Nf-1
                            
                            mat_fft_1(sample_k + 1,samples_n + 1) = exp(W1*samples_n);
                            
                        end
                        
                    end
                    
                    dft_val_1 = dft_val_1 + (log10(abs(mat_fft_1*file_data')./(Nf/2)))';
                    
                end
                
                ff1 = (0:length(file_data) - 1)*(Fs/length(file_data));
                
                curr_fig = figure;
                subplot(2,1,1)
                temp_fft = 20*log10(abs(fft(file_data)));
                plot(ff1(1:floor(length(file_data)/2)),temp_fft(1:floor(length(temp_fft)/2)));
                
                title('FFT of the original file with Spectral Analysis')
                xlabel('\bfFrequency (Hz)')
                ylabel('\bfAmplitude (AU)')
                
                %Harmonic product spectrum calculate for r = 1 to 20.
                pp = 2*dft_val_1;
                
                subplot(2,1,2)
                plot(ff1(1:floor(length(pp)/2)),pp(1:floor(length(pp)/2)))
                
                hold on
                
                pos_max = find(pp(1:floor(length(pp)/2)) == max(pp(1:floor(length(pp)/2))));
                
                plot(ff1(pos_max),max(pp(1:floor(length(pp)/2))),'ro');
                %text(ff1(pos_max),max(pp(1:floor(length(pp)/2))),'Pitch','Color','r','fontsize',10);
                
                hold off
                
                title(['FFT of the Pitch with Spectral Analysis - The estimated Pitch is: ' num2str(ff1(pos_max)) ' Hz'])
                xlabel('\bfFrequency (Hz)')
                ylabel('\bfAmplitude (AU)')
                
                legend('FFT','Pitch')
                
                try
                    
                    saveas(gcf,['Pitch_' curr_dir(ll).name(1:end-4) '_' cell2mat(sensor_selected) '_Spectral_Analysis.fig'])
                    
                catch
                    
                    saveas(gcf,['Pitch_' curr_dir(ll).name(1:end-4) '_' num2str(sensor_selected) '_Spectral_Analysis.fig'])
                    
                end
                
                close(curr_fig)
                
        end
        
    end
    
end

close(files_analyzed)
msgbox('All files have been analyzed','End of the computation')
