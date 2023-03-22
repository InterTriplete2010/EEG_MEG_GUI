function imagescc(x)
%imagescc - plot image with symmetric scaling

m=max(abs(x(:)));
imagesc(x,[-m-realmin,m+realmin]);
