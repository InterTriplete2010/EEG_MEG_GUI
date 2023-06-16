%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Flip the bits to convert negative data into decimal values
%This is done for two'complement data. The the last bit of the MSB
%carries information about the sign. 1 = negative; 0 = positive

function bits_flipped = flip_bits(bytes_data)

%Convert data to bits
temp_bin_flip = dec2bin(bytes_data);

%Flip the data
for hh = 1:size(temp_bin_flip,1)
    
    for kk = 1:size(temp_bin_flip,2)
        
            if strcmp(temp_bin_flip(hh,kk),'1')
                
                temp_bin_flip(hh,kk) = '0';
                
            else
                
                temp_bin_flip(hh,kk) = '1';
                
            end
    end
    
end

%Add one to the LSB
bits_flipped = -(bin2dec(temp_bin_flip(3,:))*2^16 + bin2dec(temp_bin_flip(2,:))*2^8 + bin2dec(temp_bin_flip(1,:))*2^0 + 1);
