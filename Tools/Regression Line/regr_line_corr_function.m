function regr_line_corr_function(corr_selected);

message = 'Select the figure by left-clicking on it. Then press enter to finalize your selection';

        msgbox(message,'Select the figure','warn');

        message_tag = gcf;
        
children_fig = [];

%% Making sure that the user selects a figure with "Children"
while (isempty(children_fig))
    
%select_fig = waitforbuttonpress; 
pause();
get_fig = get(gcf);

get_name = get_fig.FileName;

    try 
        
if(strcmp(get_name(end-22:end),'Regression_Line_GUI.fig'))


else
    
children_fig = get(gca,'Children');

    end

    catch
        
        children_fig = get(gca,'Children');
    end
    
end

hold on

%% Checking how many sets of data need to be analyzed
for zz = 1:length(children_fig)
    
    temp_child = get(children_fig(zz));
    
    if (isfield(temp_child,'XData') && isfield(temp_child,'YData'))
       
      temp_regr = regress(temp_child.YData',[temp_child.XData' ones(length(temp_child.XData),1)]);   
        temp_pred = temp_regr(1).*sort(temp_child.XData') + temp_regr(2); 
            sort_xdata = sort(temp_child.XData);
                color_data = temp_child.CData;
                
                                                
                     plot(sort_xdata,temp_pred,'Color',color_data)
                                   
      
                switch corr_selected
                
                    case 1
                        
                        [RHO,PVAL] = corr(temp_child.XData',temp_child.YData','type','Pearson');
                        text(sort_xdata(end),temp_pred(end),['r (Pearson) = ' num2str(RHO) ' -  p = ' num2str(PVAL)],'Color',color_data)
                    
                    case 2
                        
                        [RHO,PVAL] = corr(temp_child.XData',temp_child.YData','type','Spearman');              
  text(sort_xdata(end),temp_pred(end),['\rho (Spearman) = ' num2str(RHO) ' - p = ' num2str(PVAL)],'Color',color_data)
                
                end
  
                 
                
    end
    
end

try
    
    close (message_tag)
    
catch
    
end

