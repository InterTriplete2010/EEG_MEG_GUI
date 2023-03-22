function create_narrow_band_noise (cf_noise,sf_noise,duration_noise,bw_noise,ramping_type_noise,ramping_choices_noise,rftime_noise)

loops_noise = 1000;
xL = zeros(loops_noise,duration_noise*sf_noise);
xR = zeros(loops_noise,duration_noise*sf_noise);

for hh = 1:loops_noise
    
xL_temp = mkgnoise(cf_noise,bw_noise,duration_noise,sf_noise);
xR_temp = mkgnoise(cf_noise,bw_noise,duration_noise,sf_noise);

xL(hh,:) = xL_temp';
xR(hh,:) = xR_temp';

end

%Orthogonalize the vector xR with respect to xL by using Gram-Schmidt
%orthogonalization procedure
xR_orth = orth_vect (xL,xR);

%mixing the orthogonalized vectors
mixing_factor = 0.125;
xR_orth_mixed = (sqrt(1-(mixing_factor.^2)))*xL + mixing_factor*xR_orth;

xL_ramped = zeros(loops_noise,duration_noise*sf_noise);
xR_ramped = zeros(loops_noise,duration_noise*sf_noise);

for jjj = 1:size(xR_orth,1)

if (ramping_type_noise > 1)

ramped_noise_L = AddTemporalRamps(xL(jjj,:),rftime_noise,sf_noise,ramping_type_noise - 2);
ramped_noise_R = AddTemporalRamps(xR_orth_mixed(jjj,:),rftime_noise,sf_noise,ramping_type_noise - 2);

xL_ramped(jjj,:) = ramped_noise_L;
xR_ramped(jjj,:) = ramped_noise_R;

else
    
xL_ramped(jjj,:) = xL_temp';
xR_ramped(jjj,:) = xR_temp';
   

end

end

%rejecting pairs that don't have a correlation in the range of 0.9922+/-0.0001
[index_rej] = checking_corr_noise(xL_ramped,xR_ramped); 

xL_ramped(index_rej,:) = [];
xR_ramped(index_rej,:) = [];

if (isempty(xL_ramped) | isempty(xR_ramped))
   
    return;
    
end

deltaPhi_vect = zeros(size(xL_ramped,1),1);
deltaL_vect = zeros(size(xL_ramped,1),1);

for ll = 1:size(xL_ramped,1)

[deltaPhi deltaL] = Calc_IAPs(xL_ramped(ll,:),xR_ramped(ll,:));

deltaPhi_vect(ll,:) = sqrt(mean(deltaPhi.^2));
deltaL_vect(ll,:) = sqrt(mean(deltaL.^2));

end

%Plot IPD vs ILD
figure
plot(deltaL_vect,deltaPhi_vect,'*')
title('\bfFluctuations of IPD vs fluctuations of ILD')
ylabel('\bfIPD (degrees)')
xlabel('\bfILD (dB)')

t = [0:length(xR_ramped)-1]/sf_noise;

%Plotting the time series and the FFT of xR
figure
subplot(2,1,1)
title('\bfNarrow Band Noise')
plot(t,xR_ramped(1,:))
ylabel('\bfAmplitude')
xlabel('\bfTime(s)')

subplot(2,1,2)
pwelch(xR_ramped(1,:),length(xR_ramped(1,:)),length(xR_ramped(1,:))/2,length(xR_ramped(1,:)),sf_noise)

set(gca,'fontweight','bold')

%Plotting the time series and the FFT of xL
figure
subplot(2,1,1)
title('\bfNarrow Band Noise')
plot(t,xL_ramped(1,:))
ylabel('\bfAmplitude')
xlabel('\bfTime(s)')

subplot(2,1,2)
pwelch(xL_ramped(1,:),length(xL_ramped(1,:)),length(xL_ramped(1,:))/2,length(xL_ramped(1,:)),sf_noise)

set(gca,'fontweight','bold')

%Calculate the Euclidean distance to select the 10 noises with the lowest 
%fluctuations. The reference point is the origin (0,0)
euclidean_distance = zeros(1,size(xR_ramped,1));

for fff = 1:length(euclidean_distance)
   
    euclidean_distance(fff) = sqrt(deltaPhi_vect(fff,:).^2 + deltaL_vect(fff,:).^2);
    
end

[sort_values sort_indeces] = sort(euclidean_distance);

figure
stem(euclidean_distance)
title('\bfEuclidean Distance')

figure
subplot(2,1,1)
plot(t,xL_ramped(sort_indeces(1),:))
title(['\bfLowest fluctuations. RMS: ' num2str(sqrt(mean(xL_ramped(sort_indeces(1),:).^2))) ' - Generated Noise: ' num2str(sort_indeces(1))])
ylabel('\bfAmplitude')
xlabel('\bfTime(s)')

subplot(2,1,2)
plot(t,xL_ramped(sort_indeces(end),:))
title(['\bfHighest fluctuations. RMS: ' num2str(sqrt(mean(xL_ramped(sort_indeces(end),:).^2))) ' - Generated Noise: ' num2str(sort_indeces(end))])
ylabel('\bfAmplitude')
xlabel('\bfTime(s)')

%Keeping only the first best 10 noise pairs
xR_ramped_selected = xR_ramped(sort_indeces(1,1:10),:);
xL_ramped_selected = xL_ramped(sort_indeces(1,1:10),:);

%Creating and saving a 2-channels for each noise generated
for ppp = 1:size(xR_ramped_selected,1) 

xR_ramped_2_channels_Pos = [xR_ramped_selected(ppp,:);xR_ramped_selected(ppp,:)]';
xL_ramped_2_channels_Pos = [xL_ramped_selected(ppp,:);xL_ramped_selected(ppp,:)]';

%Saving the noise with the same polarity
audiowrite(['NB_Noise_R_Pos_' num2str(ppp) '_'  num2str(cf_noise) '_' num2str(bw_noise) '.wav'],xR_ramped_2_channels_Pos,sf_noise)
audiowrite(['NB_Noise_L_Pos_' num2str(ppp) '_' num2str(cf_noise) '_' num2str(bw_noise) '.wav'],xL_ramped_2_channels_Pos,sf_noise)

xR_ramped_2_channels_Pos_Neg = [xR_ramped_selected(ppp,:);-xR_ramped_selected(ppp,:)]';
xL_ramped_2_channels_Pos_Neg = [xL_ramped_selected(ppp,:);-xL_ramped_selected(ppp,:)]';

%Saving the noise with opposite polarities
audiowrite(['NB_Noise_R_Pos_Neg_' num2str(ppp) '_'  num2str(cf_noise) '_' num2str(bw_noise) '.wav'],xR_ramped_2_channels_Pos_Neg,sf_noise)
audiowrite(['NB_Noise_L_Pos_Neg_' num2str(ppp) '_' num2str(cf_noise) '_' num2str(bw_noise) '.wav'],xL_ramped_2_channels_Pos_Neg,sf_noise)

end
