function extract_MMN(standard_stimuli_files,dir_folder_data_standard,deviant_stimuli_files,dir_folder_data_deviant,start_window,end_window,abs_val)

%Extract the files from each group and estimate the MMN
for kk = 1:length(standard_stimuli_files)

    temp_standard_file = [];
    temp_deviant_file = [];

    temp_standard_file = cell2mat(standard_stimuli_files(kk));
    cd(dir_folder_data_standard);
    load_standard = load(temp_standard_file);

    temp_deviant_file = cell2mat(deviant_stimuli_files(kk));
    cd(dir_folder_data_deviant);
    load_deviant = load(temp_deviant_file);

    if (kk == 1)

       find_start = find(load_standard.data_exported.time_average >= start_window./1000,1,'first');
       find_end = find(load_standard.data_exported.time_average <= end_window./1000,1,'last');
       
       if(abs_val == 1)

           mkdir(['MME_Results_Absolute_Value_' num2str(start_window) '_' num2str(end_window)]);

       else

           mkdir(['MME_Results_NO_Absolute_Value_' num2str(start_window) '_' num2str(end_window)]);

       end

    end

    MMN_data = zeros(size(load_standard.data_exported.average_trials,1),size(load_standard.data_exported.average_trials,2));
    MMN_Peak = zeros(1,size(load_standard.data_exported.average_trials,1));
    MMN_Peak_z_score = zeros(1,size(load_standard.data_exported.average_trials,1));
    MMN_Latency = zeros(1,size(load_standard.data_exported.average_trials,1));
    MMN_Latency_z_score = zeros(1,size(load_standard.data_exported.average_trials,1));
    MMN_RMS = zeros(1,size(load_standard.data_exported.average_trials,1));
    MMN_RMS_z_score = zeros(1,size(load_standard.data_exported.average_trials,1));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Standard_Data = zeros(size(load_standard.data_exported.average_trials,1),size(load_standard.data_exported.average_trials,2));
    Deviant_Data = zeros(size(load_standard.data_exported.average_trials,1),size(load_standard.data_exported.average_trials,2));
    Peak_Standard = zeros(1,size(load_standard.data_exported.average_trials,1));
    Peak_Deviant = zeros(1,size(load_standard.data_exported.average_trials,1));
    Standard_Latency = zeros(1,size(load_standard.data_exported.average_trials,1));
    Deviant_Latency = zeros(1,size(load_standard.data_exported.average_trials,1));

    Standard_RMS = zeros(1,size(load_standard.data_exported.average_trials,1));
    Deviant_RMS = zeros(1,size(load_standard.data_exported.average_trials,1));

    Deviant_Data = load_deviant.data_exported.average_trials(:,find_start:find_end)';
    Deviant_Data_Save = load_deviant.data_exported.average_trials;
    Peak_Deviant(1,:) = max(Deviant_Data);
    Standard_Data = load_standard.data_exported.average_trials(:,find_start:find_end)';
    Standard_Data_Save = load_standard.data_exported.average_trials;
    Peak_Standard(1,:) = max(Standard_Data);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if (abs_val == 1)

        MMN_data(:,:) = abs(load_deviant.data_exported.average_trials) - abs(load_standard.data_exported.average_trials);

    else

        MMN_data(:,:) = load_deviant.data_exported.average_trials - load_standard.data_exported.average_trials;

    end

    temp_data_analysis = MMN_data(:,find_start:find_end)';
    MMN_data_zscore = zscore(MMN_data')';
    temp_data_analysis_z_score = MMN_data_zscore(:,find_start:find_end)';
    
    %Extracting the Peak and the RMS value for the selected time window
    MMN_Peak(1,:) = min(temp_data_analysis);
    MMN_Peak_z_score(1,:) = min(temp_data_analysis_z_score);

    for ll = 1:size(temp_data_analysis,2)

        MMN_Latency(1,ll) = load_standard.data_exported.time_average((find(temp_data_analysis(:,ll) == MMN_Peak(ll)) + find_start - 1));
        MMN_Latency_z_score(1,ll) = load_standard.data_exported.time_average((find(temp_data_analysis_z_score(:,ll) == MMN_Peak_z_score(ll)) + find_start - 1));

        Standard_Latency(1,ll) = load_standard.data_exported.time_average((find(Standard_Data(:,ll) == Peak_Standard(ll)) + find_start - 1));
        Deviant_Latency(1,ll) = load_standard.data_exported.time_average((find(Deviant_Data(:,ll) == Peak_Deviant(ll)) + find_start - 1));

    end
    
    MMN_RMS(1,:) = sqrt(mean(temp_data_analysis.^2));
    MMN_RMS_z_score(1,:) = sqrt(mean(temp_data_analysis_z_score.^2));

    Standard_RMS = sqrt(mean(Standard_Data.^2));
    Deviant_RMS = sqrt(mean(Deviant_Data.^2));

    data_exported = [];
    data_exported.eeg_data = MMN_data;
    data_exported.MMN_Peak = MMN_Peak;
    data_exported.MMN_Latency = MMN_Latency;
    data_exported.MMN_RMS = MMN_RMS;
    data_exported.Standard_Data = Standard_Data_Save;
    data_exported.Deviant_Data = Deviant_Data_Save;
    data_exported.Peak_Standard = Peak_Standard;
    data_exported.Peak_Deviant = Peak_Deviant;
    data_exported.Standard_Latency = Standard_Latency;
    data_exported.Deviant_Latency = Deviant_Latency;
    data_exported.Standard_RMS = Standard_RMS;
    data_exported.Deviant_RMS = Deviant_RMS;
    data_exported.eeg_data_z_score = MMN_data_zscore;
    data_exported.MMN_Peak_z_score = MMN_Peak_z_score;
    data_exported.MMN_Latency_z_score = MMN_Latency_z_score;
    data_exported.MMN_RMS_z_score = MMN_RMS_z_score;
    data_exported.sampling_frequency = load_standard.data_exported.sampling_frequency;
    data_exported.time_average = load_standard.data_exported.time_average;
    data_exported.labels = load_standard.data_exported.labels; 
    data_exported.time_analsysis_ms = [start_window end_window];

    if (abs_val == 1)

        cd(['MME_Results_Absolute_Value_' num2str(start_window) '_' num2str(end_window)]);
        save([temp_standard_file(1:end-4) '_' temp_deviant_file(1:end-4) '_Absolute_Value.mat'],'data_exported')

    else

         cd(['MME_Results_NO_Absolute_Value_' num2str(start_window) '_' num2str(end_window)]);
        save([temp_standard_file(1:end-4) '_' temp_deviant_file(1:end-4) '_NO_Absolute_Value.mat'],'data_exported')

    end

    cd ..

end
