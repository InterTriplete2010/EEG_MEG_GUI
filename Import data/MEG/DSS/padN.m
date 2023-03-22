function x=padN(x,bch)
x=x(:);
bch=sort(bch);
for ind=1:1:length(bch)
    x=[x(1:1:bch(ind)-1); NaN; x(bch(ind):end)];
end

