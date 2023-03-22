function x=unfold(x)
if isempty(x)
    x=[];
else
    [m,n,p]=size(x);
    if p>1;
        x=reshape(permute(x,[1 3 2]), m*p,n);
    else
        x=x;
    end
end