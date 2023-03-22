function index_rej = checking_corr_noise(xL_ramped,xR_ramped)

corr_threshold_upper = 0.9922 + 0.0001;
corr_threshold_lower = 0.9922 - 0.0001;
index_rej = [];
corr_save = [];

for vvv = 1:size(xL_ramped,1)
    
   corr_save = [corr_save;corr2(xL_ramped(vvv,:),xR_ramped(vvv,:))];
   
    if (corr2(xL_ramped(vvv,:),xR_ramped(vvv,:)) < corr_threshold_lower || corr2(xL_ramped(vvv,:),xR_ramped(vvv,:)) > corr_threshold_upper)
        
        index_rej = [index_rej;vvv];
        
    end
    
end