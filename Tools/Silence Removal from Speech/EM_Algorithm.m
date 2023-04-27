%%Function for the EM algorithm used for voiced/silence detection

function [mu0,sigma0,p0,mu1,sigma1,p1] = EM_Algorithm(matrix_par,mu0,sigma0,p0,mu1,sigma1,p1,loops_EM_algorithm)

length_data = size(matrix_par,2);

p = [];
p(:,:) = [p0 p1];

den_interaction = (p(1,1).*mvnpdf(matrix_par',mu0',sigma0) + p(1,2).*mvnpdf(matrix_par',mu1',sigma1));

gamma_0 = p(1,1).*mvnpdf(matrix_par',mu0',sigma0)./den_interaction;

mu0 = 0;
for kk = 1:size(matrix_par,2)
    
    mu0 = mu0 + (gamma_0(kk).*matrix_par(:,kk));
    
end
mu0 = mu0./sum(gamma_0);

sigma0 = 0;
for kk = 1:size(matrix_par,2)
    
    sigma0 = sigma0 + (gamma_0(kk).*((matrix_par(:,kk) - mu0)*(matrix_par(:,kk) - mu0)'));
    
end

sigma0 = sigma0./sum(gamma_0);
p(1,1) = sum(gamma_0)./length_data;

gamma_1 = p(1,2).*mvnpdf(matrix_par',mu1',sigma1)./den_interaction;

mu1 = 0;
for kk = 1:size(matrix_par,2)
    
    mu1 = mu1 + (gamma_1(kk).*matrix_par(:,kk));
    
end
mu1 = mu1./sum(gamma_1);

sigma1 = 0;
for kk = 1:size(matrix_par,2)
    
    sigma1 = sigma1 + (gamma_1(kk).*((matrix_par(:,kk) - mu1)*(matrix_par(:,kk) - mu1)'));
    
end

sigma1 = sigma1./sum(gamma_1);
p(1,2) = sum(gamma_1)./length_data;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Start the EM algorithm
for mm = 1:loops_EM_algorithm
    
    den_interaction = p(1,1).*mvnpdf(matrix_par',mu0',sigma0) + p(1,2).*mvnpdf(matrix_par',mu1',sigma1);
    
    gamma_0 = p(1,1).*mvnpdf(matrix_par',mu0',sigma0)./den_interaction; %Expectation
    
    %Maximization
    mu0 = 0;
    for kk = 1:size(matrix_par,2)
        
        mu0 = mu0 + (gamma_0(kk).*matrix_par(:,kk));
        
    end
    mu0 = mu0./sum(gamma_0);
    
    sigma0 = 0;
    for kk = 1:size(matrix_par,2)
        
        sigma0 = sigma0 + (gamma_0(kk).*((matrix_par(:,kk) - mu0)*(matrix_par(:,kk) - mu0)'));
        
    end
    
    sigma0 = sigma0./sum(gamma_0);
    p(1,1) = sum(gamma_0)./length_data;
    
    %Expectation
    gamma_1 = p(1,2).*mvnpdf(matrix_par',mu1',sigma1)./den_interaction;
    
    %Maximization
    mu1 = 0;
    for kk = 1:size(matrix_par,2)
        
        mu1 = mu1 + (gamma_1(kk).*matrix_par(:,kk));
        
    end
    mu1 = mu1./sum(gamma_1);
    
    sigma1 = 0;
    for kk = 1:size(matrix_par,2)
        
        sigma1 = sigma1 + (gamma_1(kk).*((matrix_par(:,kk) - mu1)*(matrix_par(:,kk) - mu1)'));
        
    end
    
    sigma1 = sigma1./sum(gamma_1);
    p(1,2) = sum(gamma_1)./length_data;
    
end

mu0 = mu0';
mu1 = mu1';