%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Convert two's complement data to decimal value
function data_converted = convert_2_compl(sign_bits);

%Convert the data into binary format 
temp_bin = dec2bin(sign_bits(3),8);
  
%Check if the sample is negative by reading the Least significant bit.
%If it is negative, flip the bits to get the decimal value
if strcmp(temp_bin(end),'1')
   
  data_converted = flip_bits(sign_bits);
  
else
    
   data_converted = sign_bits*2.^[0;8;16]; 
    
end