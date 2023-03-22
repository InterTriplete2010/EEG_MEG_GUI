function [save_max_optimal_filter] = optimal_filter_background_noise(x_noise,y_noise,h_optimal,cross_val);

%% Calculating the correlation values with the optimal filter

%% Calculating the correlation values with the optimal filter

x_training = x_noise;
y_training = y_noise;

save_max_optimal_filter = zeros(2,cross_val + 1);
%save_h = zeros(cross_val + 1,size(x,1),500/5);
test_time_samples = round(length(x_noise)/(cross_val + 1));

% Split data for cross validation
for n_fold = 1:cross_val + 1
     
    
    testing_range = [(n_fold-1)*test_time_samples + 1:(n_fold)*test_time_samples];

x = x_training;
y = y_training;    
    
x_test = x(:,testing_range);
y_test = y(:,testing_range);   
    

x(:,testing_range) = [];
y(:,testing_range) = [];

ypred_now_noise = y*0;
    ypred_test_noise = y_test*0;
    
for ind=1:size(h_optimal,1)
    
         ypred_now_noise = ypred_now_noise+filter(h_optimal(ind,:),1,x(ind,:));
        ypred_test_noise = ypred_test_noise+filter(h_optimal(ind,:),1,x_test(ind,:));
end

rg=size(h_optimal,2):length(y);
    m_y = mean(y(rg));
    m_ypred_now_noise = mean(ypred_now_noise(rg));
    CR_train = sum((y(rg) - m_y).*(ypred_now_noise(rg) - m_ypred_now_noise))/sqrt(sum((y(rg) - m_y).^2)*sum((ypred_now_noise(rg) - m_ypred_now_noise).^2));
    
    % Compute predictive power: Testing
    rg=size(h_optimal,2):length(y_test);
    m_ytest = mean(y_test(rg));
    m_ypred_test = mean(ypred_test_noise(rg));
    
    
    %Equation for the correlation: Numerator is the covariance; denominator is the product of the stdv of the two signals 
    %r = cov(x,y)/sigma(x)*sigma(y)
    CR_test = sum((y_test(rg) - m_ytest).*(ypred_test_noise(rg) - m_ypred_test))/sqrt(sum((y_test(rg) - m_ytest).^2)*sum((ypred_test_noise(rg) - m_ypred_test).^2));
    

    save_max_optimal_filter(1,n_fold) = CR_train;
save_max_optimal_filter(2,n_fold) = CR_test;
    
end