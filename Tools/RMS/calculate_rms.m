function calculate_rms(EEG_rms_file_selected,rmsfiledata,startT_rms,endT_rms,samples_overlap,electrode_names_rms,sampling_frequency,...
    time_av,real_time_S,real_time_E,window_RMS_analysis,overlap_rms)

clear save_rms;

%Estimating how many time-windows will be analyzed based on the percentage  
%of the overlap
loops_rms = floor((endT_rms - startT_rms)/(window_RMS_analysis*overlap_rms));
%loops_rms = floor((endT_rms - startT_rms)/samples_overlap);

%Initializing the matrix where to save the RMS values
save_rms = {zeros(size(electrode_names_rms,1) + 2,loops_rms + 1)};

for yy = 1:loops_rms + 1
   
   if (yy == 1)
       
       save_rms(1,yy) = {'Name File/Electrodes'};
       save_rms(2,yy) = {EEG_rms_file_selected(1:end-4)};
       
   else
       
       save_rms(1,yy) = {['Region_' num2str(yy - 1)]};
       
   end
    
end

width_square = (window_RMS_analysis/sampling_frequency);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculating the RMS value for each region and plotting the values on the average 
%figure 

for tt = 1:size(electrode_names_rms,1)

    temp_data = rmsfiledata(tt,:);
    
    time_start = startT_rms;
    time_square_S = real_time_S;
    
    try
        
    save_rms(tt + 2,1) = electrode_names_rms(tt);
    
    catch
     
        save_rms(tt + 2,1) = {electrode_names_rms(tt,:)};
            
    end
    
    
    figure
    plot(time_av,temp_data)
    title(cell2mat(electrode_names_rms(tt)))
    hold on
    
    for hh = 1:loops_rms
       
        color_edges = randi(255,1,3)/255;
        
        try
            
        save_rms(tt + 2,hh + 1) = {sqrt(mean(temp_data(:,time_start:time_start + window_RMS_analysis).^2))};
                
        rectangle('Position',[time_square_S,min(temp_data),width_square,max(temp_data)],...
                   'LineWidth',2,'LineStyle','--','EdgeColor',color_edges)
        
 text((time_square_S + width_square/8),min(temp_data) - min(temp_data)/4,{roundn(cell2mat(save_rms(tt + 2,hh + 1)),-3)},'FontSize',10,'Color',color_edges) 
               
     time_start = time_start + samples_overlap;
        time_square_S = time_square_S + width_square*overlap_rms;
        
        catch 
            
        end
    end
    
    try
        
    saveas(gcf,['RMS_' cell2mat(electrode_names_rms(tt)) '_' EEG_rms_file_selected(1:end-4) '.fig'])
    
    catch
     
         saveas(gcf,['RMS_' electrode_names_rms(tt,:) '_' EEG_rms_file_selected(1:end-4) '.fig'])
        
    end
    
    close(gcf)
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Saving the results in an excel file
xlswrite ([EEG_rms_file_selected(1:end-4) '_rms.xlsx'],save_rms)

