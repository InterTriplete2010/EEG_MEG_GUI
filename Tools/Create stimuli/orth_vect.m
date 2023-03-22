function xR_orth = orth_vect (xL,xR);

xR_orth = zeros(size(xL,1),size(xL,2));

check_orth = zeros(1,size(xL,1));

for kk = 1:size(xL,1)
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %projecting the vector xR into the subspace of xR  
  proj_vector = (dot(xR(kk,:),xL(kk,:))*xL(kk,:))/(norm(xL(kk,:))^2);
    
    xR_orth(kk,:) = xR(kk,:) - proj_vector;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Checking that the vectors are orthogonal
    check_orth(kk) = dot(xR_orth(kk,:),xL(kk,:));
    
end

figure
stem(check_orth)
title('\bfDot product')