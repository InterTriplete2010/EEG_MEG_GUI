%This ICA function is based on the notes from Shireen Elhabian and Aky
%Farag, University of Louisville, CVIP Lab (September 2009)
%The non-quadratic function used for ICA is G1 =
%(1/a1)*ln(cosh(a1*ica_data)) with a1 = 1, as reported in the slides

function [W,source_signal] = ICA_Alex_Max_NegEntropy_ToolBox(ica_data,grad_step,max_data_iter,toll_step)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preprocessing the data by centering and whitening => sphering. Sphering removes the first and second order statistics of the data
% both the mean and covariance are set to zero and the variance are equalized
ica_data = ica_data';
mean_data = mean(ica_data);
ica_data = ica_data - repmat(mean_data,[size(ica_data,1),1]);

%Whitening the data to have uncorrelated rows of the signals recorded
var_data = ica_data'*ica_data;
[Eig_Vect,Eig_Val] = eig(var_data);

%See if there are negative eingvalues. If there are, replace them with
%the symbolic, negligible value of 10^-6
neg_eing_val = find(Eig_Val < 0);
Eig_Val(neg_eing_val) = 10^-6;
ica_data = (Eig_Vect*sqrt(inv(Eig_Val))*Eig_Vect'*ica_data')';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initialize the Weight matrix
W = eye(size(ica_data,2),size(ica_data,2));

hs = zeros(max_data_iter,1);

for iter = 1:max_data_iter
    
    display(['iter# :' num2str(iter)])
    
    %Initialize u, which is the estimated source signals
    source_signal = ica_data*W;
    
    %Get estimated maximum entropy signals U = cdf(u)
    U = tanh(source_signal);    %This is the derivative of the function G1 = (1/a1)*ln(cosh(a1*x)) with a1 = 1; G1 is one of the feasable functions used to solve ICA (see slide 36);
    
    %h = log(abs(det(W))) + sum(log(eps + 1 - U(:).^2))/N;
    detW = abs(det(W));
    h = ((1./(size(ica_data,1)))*sum(sum(U)) + 0.5*log(detW));   %See slide 48
    
    g = inv(W') - (2./(size(ica_data,1)))*ica_data'*U;  %This is the gradient of the entropy "h" (see slide 51)
    
    W = W + grad_step*g;  %Here we update W in order to maximize the entropy negentropy (or minimize the mutual imformation, so to have minimal gaussianity), which is our final goal in order to find independent components. "grad_step" is chosen aribtrarly and affects the step of our updated
    
    hs(iter) = h;
    
    if iter > 1
        
        display(['Val diff(entropy): ' num2str(diff(hs(iter-1:iter)))]);
        
    else
        
        display(['Val diff(entropy): ' num2str(hs(iter))]);
        
    end
    
    if iter > 1 && diff(hs(iter-1:iter)) < toll_step
         
        return;
        
    end
    
end


