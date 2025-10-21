%% This algorithm is based on the following paper:

% A. Schlögla, C. Keinrathb, D. Zimmermannb, R. Schererb, R. Leebb, G. Pfurtscheller
% "A fully automated correction method of EOG artifacts in EEG recordings"
% Clinical Neurophysiology, Volume 118, Issue 1, January 2007, Pages 98–104

function [save_cleaned_eeg] = eye_movement_correction_function_COGMO(eeg_to_be_corrected,eeg_to_be_corrected_data,vertical_eye_selected,...
    horizontal_eye_selected,vertical_eye_selected_weights,horizontal_eye_selected_weights,data_selected_weights);

save_cleaned_eeg = [];

sampl_freq = eeg_to_be_corrected.data_exported.sampling_frequency;

for kk = 1:size(eeg_to_be_corrected_data,1)

%Calculating the weights;
temp_eeg_weights = data_selected_weights(kk,:);
temp_eeg = eeg_to_be_corrected_data(kk,:);

b1 = ((dot((vertical_eye_selected_weights)',(vertical_eye_selected_weights))).^-1)*(dot((vertical_eye_selected_weights)',temp_eeg_weights));
b2 = ((dot((horizontal_eye_selected_weights)',(horizontal_eye_selected_weights))).^-1)*(dot((horizontal_eye_selected_weights)',temp_eeg_weights));

vector_b = [b1 b2];
vector_eyes = [vertical_eye_selected;horizontal_eye_selected];

eye_movement_corrected_eeg = temp_eeg(:,:) - (vector_b*vector_eyes);

save_cleaned_eeg = [save_cleaned_eeg;eye_movement_corrected_eeg];


figure 
subplot(2,1,1)
tt = [0:size(temp_eeg,2)-1]/sampl_freq;

plot(tt,temp_eeg(1,:))
hold on
plot(tt,eye_movement_corrected_eeg,'r')
hold off

title(eeg_to_be_corrected.data_exported.labels(kk),'interpreter', 'none')

legend('Before correction','After correction')

subplot(2,1,2)
[psd_corr freq] = pwelch(temp_eeg(:,:),sampl_freq,sampl_freq/2,sampl_freq,sampl_freq);
plot(freq,10*log10(psd_corr))
hold on
[psd_cleaned freq] = pwelch(eye_movement_corrected_eeg,sampl_freq,sampl_freq/2,sampl_freq,sampl_freq);
plot(freq,10*log10(psd_cleaned),'r')
hold off

legend('Before correction','After correction')

pause(1)
close(gcf)
% fig_prop = get(gcf);
% close(fig_prop.Tag);

%SNR(kk,:) = 10*log10(sum(eye_movement_corrected_eeg.^2)/ sum((eye_movement_corrected_eeg - temp_eeg).^2))

%pause

end

%{
SNR([32,61,62,63,64],:) = [];
figure
bar (abs(SNR))

save_cleaned_eeg([32,61,62,63,64],:) = [];
eeg_to_be_corrected_data([32,61,62,63,64],:) = [];

SNR_all = 10*log10(sum(sum(save_cleaned_eeg.^2))/ sum(sum((save_cleaned_eeg - eeg_to_be_corrected_data).^2)))
%}



