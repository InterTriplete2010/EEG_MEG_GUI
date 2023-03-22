function change_axes_COGMO_function(triggers_number,rows_subplot_number,columns_subplot_number,figure_chosen,x_min,x_max,y_min,y_max,change_wav_pos);

figure(figure_chosen)

if rows_subplot_number > 1 | columns_subplot_number > 1

subplot(rows_subplot_number,columns_subplot_number,change_wav_pos)

end

%Parameters used to reset the x and y labels
handle_figure = gca;

children_axis = get(handle_figure,'Children');

if (isempty(children_axis))
   
    close(gcf);
    return;
    
end

try 
    
y_label = get(handle_figure,'YLabel');
y_label_properties = get(y_label);

axis([x_min x_max y_min y_max])
%set(y_label_properties.Parent,'XLim',[0 7])

prop_axis = get(gca);

    set(y_label,'Position',[(x_min -(prop_axis.XTick(2) - prop_axis.XTick(1))/1.5)   mean([y_min y_max])]);
    
    for kk = triggers_number + 1:length(children_axis)
                    
        temp_prop = get(children_axis(kk));
        string_label = temp_prop.String;
        
        set(children_axis(kk),'Position',[(x_min -(prop_axis.XTick(2) - prop_axis.XTick(1))/2)   temp_prop.Position(2)]);
            
    end

catch
         
    return;
         
        end
    