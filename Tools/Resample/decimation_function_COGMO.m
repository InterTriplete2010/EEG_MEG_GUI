function decimation_function_COGMO(Mat_file_decimation,Mat_directory_decimation,decimation_factor_numerator,decimation_factor_denominator);

cd(Mat_directory_decimation)
file_to_be_decimated = [Mat_directory_decimation '\' Mat_file_decimation];
file_to_be_decimated = load(file_to_be_decimated); 

eeg_data_decimation = file_to_be_decimated.data_exported.eeg_data;

[electrodes samples] = size(eeg_data_decimation);

for tt = 1:electrodes
   
    temp_dec = eeg_data_decimation(tt,:);
    eeg_decimated = resample(temp_dec,decimation_factor_numerator,decimation_factor_denominator);

    if tt == 1
        
        eeg_decimated_electrodes = zeros(electrodes,length(eeg_decimated));
    eeg_decimated_electrodes(tt,:) = eeg_decimated;

    else
    
    eeg_decimated_electrodes(tt,:) = eeg_decimated;
    
    end
    
end

decimation_factor = decimation_factor_denominator/decimation_factor_numerator;
sampling_frequency_decimation = file_to_be_decimated.data_exported.sampling_frequency/decimation_factor;

[rows samples_decimation] = size(eeg_decimated_electrodes);

try
data_exported.eeg_data = eeg_decimated_electrodes; 
data_exported.sampling_frequency = sampling_frequency_decimation;
data_exported.labels = file_to_be_decimated.data_exported.labels;
data_exported.channels = file_to_be_decimated.data_exported.channels;
data_exported.samples = samples_decimation;
data_exported.time = (0:samples_decimation-1)/sampling_frequency_decimation;
data_exported.reference_channel = file_to_be_decimated.data_exported.reference_channel;
data_exported.resolution = file_to_be_decimated.data_exported.resolution;
data_exported.trial_duration = (samples_decimation - 1)/sampling_frequency_decimation;
data_exported.decimation_factor = decimation_factor;
data_exported.chanlocs = file_to_be_decimated.data_exported.chanlocs;

catch
    
end

try
   
    
    
catch
    
end

try
    
data_exported.events_trigger = round((file_to_be_decimated.data_exported.events_trigger)/decimation_factor);
data_exported.events_type = file_to_be_decimated.data_exported.events_type;

catch
    
end

try
        data_exported.sensors_removed = file_to_be_decimated.data_exported.sensors_removed;

catch
    
end

mat_file_decimated_name = Mat_file_decimation;
mat_file_decimated_name(end-3:end) = []; %Removes the ".mat" extension
save_eeg = [mat_file_decimated_name '_Resampled_' num2str(sampling_frequency_decimation) '_Hz.mat'];
save (save_eeg,'data_exported','-v7.3')

message = (['The data have been successfully resampled. The new sampling frequency is: ' num2str(sampling_frequency_decimation)]);

        msgbox(message,'Resampling','warn');

