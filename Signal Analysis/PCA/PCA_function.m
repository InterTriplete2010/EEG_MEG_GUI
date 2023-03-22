function [pca_space,E_Vectors_sorted,E_Values_sorted,perc_eing_val] = PCA_function(pca_data,time_d)

%{
%Step 1: de-mean the data
pca_data_step_1 = pca_data - mean(pca_data')';

%Step 2: calculate the covariance matrix
pca_data_step_2 = cov(pca_data_step_1');

%Step 3: Extract the eingen vectors and values
[E_Vectors,E_Values] = eig(pca_data_step_2');   %Each column represent a different eigen vector


%Step 4: Order the eigenvectors and values in descending order, that is the
%first cell in the array will have the highest eigenvalue
[E_Values_sorted E_Values_sorted_indeces] = sort(diag(E_Values),'descend');
E_Vectors_sorted = E_Vectors(:,E_Values_sorted_indeces);

perc_eing_val = E_Values_sorted./sum(E_Values_sorted);

pca_space = (pca_data')*E_Vectors_sorted;
%}

%Step 1: de-mean the data
pca_data = pca_data';
pca_data_step_1 = pca_data - mean(pca_data);

%Step 2: calculate the covariance matrix
pca_data_step_2 = cov(pca_data_step_1);

%Step 3: Extract the eingen vectors and values
[E_Vectors,E_Values] = eig(pca_data_step_2);   %Each column represent a different eigen vector


%Step 4: Order the eigenvectors and values in descending order, that is the
%first cell in the array will have the highest eigenvalue
[E_Values_sorted,E_Values_sorted_indeces] = sort(diag(E_Values),'descend');
E_Vectors_sorted = E_Vectors(:,E_Values_sorted_indeces);

perc_eing_val = E_Values_sorted./sum(E_Values_sorted);
pca_space = E_Vectors_sorted'*(pca_data - mean(pca_data))'; %Each column has an eingenvector => by trnasposing we have (MxM)x(MxN), where M is the number of sensors and N is the number of samples 

%Plotting the first 6 PCA components, if 6 have been calculated. Otherwise,
%plot the maximum number of componenets calculated

if size(pca_space,2) >= 6
    
    plot_pca = 6
    
else
    
    plot_pca = size(pca_space,2);
    
end

figure
for kk = 1:plot_pca
    
   subplot(plot_pca,1,kk)
   
    plot(time_d,pca_space(kk,:))
    
    title(['PCA#' num2str(kk)])
    
    axis tight
    
end

  xlabel('\bfTime (s)')