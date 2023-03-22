function y=normcol(x,w)
% y=normcol(x,w) - normalize each column so its weighted msq is 1
% 
%   y: normalized data
%
%   x: data to normalize
%   w: weight
% 
% If x is 3D, pages are concatenated vertically before calculating the
% norm.
% 
% Weight should be either a column vector, or a matrix (2D or 3D) of same
% size as data.

if nargin<2; w=[]; end

if ndims(x)==3;
    
    % 3D: unfold, apply normcol on 2D, fold
    [m,n,o]=size(x);
    x=unfold(x);
    if isempty(w);
        % no weight 
        y=normcol(x);
        y=fold(y,m);
    else
        % weight
        if size(w,1)~=m; error('weight matrix should have same ncols as data'); end 
        if ndims(w)==2 && size(w,2)==1; 
            w=repmat(w,[1,m,o]);
        end
        if size(w)~=size(w); error('weight should have same size as data'); end
        w=unfold(w);
        y=normcol(x,w);
        y=fold(y,m);
    end

else
     
    % 2D
    [m,n]=size(x);
    if isempty(w)

        % no weight
        %N=sqrt(sum(x.^2)/m);
        %y=vecmult(x,1./N);
        y=vecmult(x,(sum(x.^2)/m).^-0.5);
        
    else

        % weight
        if size(w,1)~=size(x,1); error('weight matrix should have same ncols as data'); end 
        if ndims(w)==2 && size(w,2)==1; 
            w=repmat(w,1,n);
        end
        if size(w)~=size(w); error('weight should have same size as data'); end
        if size(w,2)==1; w=repmat(w,1,n);end
        %N=sqrt(sum((x.^2).*w)./sum(w));
        %y=vecmult(x,1./N);
        y=vecmult(x, (sum((x.^2).*w)./sum(w)).^-0.5);
        
    end
end