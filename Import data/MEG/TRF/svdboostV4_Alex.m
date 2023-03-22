function [temp_h,CR_test_out,Str_testE_best, Str_TrainE, Best_iter, Total_Iter,save_max,measured_env_best,pred_env_best]=svdboostV4_Alex(x,y,cross_val,dec_factor,shift_samples)
% Description: This code is a modification of the previous code created by
% N. Ding 2011 [gahding@umd.edu] and later modified by M. Villafañe Delgado
% [mariselv@umd.edu] and F. Cervantes Constantino 2012 [fcc@umd.edu].
%
% As is:
% A total of 500 interactions will be performed and the optimum filter
% will be that corresponding to the iteration which yields to the absolute
% minimum in the MSE.
% If the current interaction does not improve the estimation for all times,
% the step size will be readjusted by half and the current interaction will
% be performed again.
%
% Arguments:
% x - Response, n_components x time
% y - Stimulus, frequency x time
% h - filter (initialized to zeros), frequency x time
% DeltaH - Step size (0.005 suggested)
% segno - Current validation
%
% Outputs:
% h - Estimated filter
% CR_test_out - Predictive power at best iteration
% Str_testE - Error, test set
% Str_TrainE - Error, training set
% Best_iter - Best iteration number
%
% Last revision: 5/22/2012, M. Villafañe Delgado

temp_h = 0; %Variable used to average the optimal filters for each cross_val

MaxIter = 500;

% Initialize filter and Best Position
hstr=[];
BestPos=0;

x_training = x;
y_training = y;

save_max = zeros(2,cross_val + 1);
%save_h = zeros(cross_val + 1,size(x,1),500/5);

h_waitbar = waitbar(0,'10','Name','Calculation in progress... Interactions left');
test_time_samples = round(length(x)/(cross_val + 1));

% Split data for cross validation
for n_fold = 1:cross_val + 1
    
%Matrices used to save the measured and the predicted speech envelopes
measured_env = [];
pred_env = [];

    
    testing_range = ((n_fold-1)*test_time_samples + 1:(n_fold)*test_time_samples);

x = x_training;
y = y_training;    
    
x_test = x(:,testing_range);
y_test = y(:,testing_range);   
    

x(:,testing_range) = [];
y(:,testing_range) = [];

%h = zeros(size(x,1),500/dec_factor);
h = zeros(size(x,1),shift_samples);
DeltaH = 0.005;
CR_train = [];
CR_test = [];
TrainE = [];
Str_trainE = [];
TestE = [];
Str_testE = [];
Best_iter = [];

% Start interactions
for iter=1:MaxIter
    iter;
    ypred_now=y*0;
    ypred_test=y_test*0;
    
    for ind=1:size(h,1)
        
        ypred_now = ypred_now+filter(h(ind,:),1,x(ind,:));
        ypred_test = ypred_test+filter(h(ind,:),1,x_test(ind,:));
    
    end
    
    % Compute predictive power: Training
    rg=size(h,2):length(y);
    m_y = mean(y(rg));
    m_ypred_now = mean(ypred_now(rg));
    CR_train(iter)=sum((y(rg) - m_y).*(ypred_now(rg) - m_ypred_now))/sqrt(sum((y(rg) - m_y).^2)*sum((ypred_now(rg) - m_ypred_now).^2));
    
    % Compute predictive power: Testing
    rg=size(h,2):length(y_test);
    m_ytest = mean(y_test(rg));
    m_ypred_test = mean(ypred_test(rg));
    
    
    %Equation for the correlation: Numerator is the covariance; denominator is the product of the stdv of the two signals 
    %r = cov(x,y)/sigma(x)*sigma(y)
    CR_test(iter)=sum((y_test(rg) - m_ytest).*(ypred_test(rg) - m_ypred_test))/sqrt(sum((y_test(rg) - m_ytest).^2)*sum((ypred_test(rg) - m_ypred_test).^2));
    
    %Saving the measured and predicted speech envelopes used for testing
    measured_env = [measured_env;y_test(rg)];
    pred_env = [pred_env;ypred_test(rg)];
    
    % Compute Testing and Training errors          - Modified by Marisel,5/17/2012
    TestE(1:size(h,1))=sum((y_test-ypred_test).^2);
    Str_testE(iter)=sum(TestE)/(length(y_test)*size(h,1));
    %     Str_testE(iter)=(TestE);
    
    TrainE(1:size(h,1))=sum((y-ypred_now).^2);
    Str_TrainE(iter)=sum(TrainE)/(length(y)*size(h,1));
    %     Str_TrainE(iter)=(TrainE);
    
    % Stopping rule 1: As previously defined by Nai
    % stop the interaction if all the following requirements are met
    % 1. more than 10 interactions are done
    % 2. The testing error in the latest interaction is higher than that in the
    % previous two interactions
    %     if iter>11 && Str_testE(iter)>Str_testE(iter-1) && Str_testE(iter)>Str_testE(iter-2)
    
    % Stopping rule 2: Run for 500 iterations fixed
    if iter == 500
        
        [dum,Best_iter]=min(Str_testE); %Best_iter=Best_iter+1;
        
        try
        
            h=squeeze(hstr(Best_iter,:,:));
        
        catch
            
            h=h*0;
        
        end
        
        if size(h,2)==1
        
            h=h';
        
        end
        
        break;
    
    end
    
    MinE(1:size(h,1))=sum((y-ypred_now).^2);
    
    for ind1=1:size(h,1)
    
        ind1;
        
        for ind2=1:size(h,2)
        
            ind2;
            ypred=ypred_now+DeltaH*[zeros(1,ind2-1) x(ind1,1:end-ind2+1)];
            e1=sum((y-ypred).^2);
            
            ypred=ypred_now-DeltaH*[zeros(1,ind2-1) x(ind1,1:end-ind2+1)];
            e2=sum((y-ypred).^2);
            
            if e1>e2
            
                e(ind2)=e2;
                IncSignTmp=-1;
            
            else
                
                e(ind2)=e1;
                IncSignTmp=1;
            
            end
            
            if e(ind2)<MinE(ind1)
            
                BestPos(ind1)=ind2;
                IncSign(ind1)=IncSignTmp;
                MinE(ind1)=e(ind2);
            
            end
        end
    end
    
    % If current interaction does not contribute to the estimation of the
    % filter, resize the step size and return to current interaction.
    if sum(abs(BestPos))==0;
        
        DeltaH=DeltaH*0.5;
        disp(['Precision doubled, iteraction # ',num2str(iter),', validation # ',num2str(cross_val),'']);
        disp(DeltaH);
        
        iter = iter - 1;   % Keep in current interaction
        continue;
    
    end
    
    [dum, bestfil]=min(MinE);
    h(bestfil,BestPos(bestfil))=h(bestfil,BestPos(bestfil))+IncSign(bestfil)*DeltaH;
    BestPos=BestPos*0;
    hstr(iter,:,:)=h;
    
    try
        if sum(abs(h-hstr(iter-2,:)))==0
            disp(iter);
            break
        elseif sum(abs(h-hstr(iter-3,:)))==0
            disp(iter);
            break
        end
    end
end

Total_Iter = iter;

try
    
    Best_iter;

catch
    
    Best_iter = iter;

end

try

    CR_test_out = CR_test(Best_iter);     % Keep predictive power as the correlation for the best interaction

catch
    
    CR_test_out = CR_test(iter);

end

if isnan(CR_test_out)

    CR_test_out = 0;

end

temp_h = temp_h + h;

if(Best_iter == 1)
    
    Best_iter = 2;
    
end

save_max(1,n_fold) = CR_train(Best_iter);
save_max(2,n_fold) = CR_test(Best_iter)

if isnan(save_max(2,n_fold))
    
    save_max(2,n_fold) = 0;
    save_max

end



%Save the measured and predicted speech envelopes for the best iteration
measured_env_best(n_fold,:) = measured_env(Best_iter,:);
pred_env_best(n_fold,:) = pred_env(Best_iter,:);
Str_testE_best(n_fold,:) = Str_testE(Best_iter);

%max(CR_train)
%max(CR_test)
%save_max(1,n_fold) = max(CR_train);
%save_max(2,n_fold) = max(CR_test)

%save_h (n_fold,:,:) = h(:,:);

waitbar(n_fold/(cross_val + 1),h_waitbar,sprintf('%f',(cross_val + 1 - n_fold)))
    
end

close (h_waitbar);

return;


