%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate untransformed IAPs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [deltaPhi deltaL]=Calc_IAPs(xL,xR)

NSamples=length(xL);

%%% Calculated ILDs
EL=abs(hilbert(xL));
ER=abs(hilbert(xR));

for n = 1:NSamples
    if EL(n) == 0
        EL(n) = 0.0000001;
    end
    if ER(n) == 0
        ER(n) = 0.0000001;
    end
end
deltaL = 20*log10(ER ./ EL);

%%% Calculated IPDs
yL=imag(hilbert(xL));
yR=imag(hilbert(xR));
phiL = atan2(yL,xL);
phiR = atan2(yR,xR);
deltaPhi = 180/pi*(phiR-phiL);

% bound by +/-180
for n = 1:NSamples
   if deltaPhi(n) > 0 
       while deltaPhi(n) > 180
           deltaPhi(n) = deltaPhi(n) - 360;
       end
   else
       while deltaPhi(n) < -180
           deltaPhi(n) = deltaPhi(n) + 360;
       end
   end
end
