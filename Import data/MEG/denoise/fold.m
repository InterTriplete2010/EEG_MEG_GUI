function x=fold(x,epochsize)
if isempty(x); 
    x=[]; 
else
    if size(x,1)/epochsize>1
        x=permute(reshape(x,[epochsize, size(x,1)/epochsize, size(x,2)]), [1 3 2]);
    else
        x=x;
    end
end