function x=pad02D(x,bch)
for ind=1:1:length(bch)
    x=[x(1:1:bch(ind)-1,:); zeros(1,size(x,2)); x(bch(ind):end,:)];
end
for ind=1:1:length(bch)
  
        %try
        
    x=[x(:,1:1:bch(ind)-1) zeros(size(x,1),1) x(:,bch(ind):end)];

        %catch %if bch(ind) is out of boundary, then add the zeros at the end of the matrix 
        
        %x=[x zeros(size(x,1),1)];
    
    %end
end

