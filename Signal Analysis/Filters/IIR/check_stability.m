function check_stability(num_transf,den_transf)

%This try-catch is used in case the user doesn't have this specific toolbox
try
    
    transf_function = tf(num_transf,den_transf)
    %[num_tranf,poles_den,gain_transf] = zpkdata(transf_function);
    
catch
    
end

poles_den = roots(den_transf);

figure
compass(poles_den)

if(isempty(find(abs(poles_den)>=1)))
   
    title('\bfAll the poles are inside the unit circle. The filter is stable')

else
    
title('\bfAt least one pole is outside the unit circle. The filter is unstable')    
    
end