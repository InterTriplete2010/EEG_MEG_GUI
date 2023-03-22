function move_axes_backward_COGMO_function(triggers_number,seconds_to_move,rows_subplot_number,columns_subplot_number,figure_chosen,change_wav_pos);

figure(figure_chosen)

    
  if rows_subplot_number > 1 | columns_subplot_number > 1

subplot(rows_subplot_number,columns_subplot_number,change_wav_pos)

  end


handle_figure = gca;
figure_properties = get(handle_figure);

children_axis = get(gca,'Children');
y_label = get(handle_figure,'YLabel');
y_label_properties = get(y_label);

new_min_x_backward = figure_properties.XLim(1) - (seconds_to_move);   %Min value of the "x" axis
%new_min_x_backward = figure_properties.XLim(1);   %Min value of the "x" axis
new_max_x_backward = figure_properties.XLim(2) - (seconds_to_move);   %Max value of the "x" axis

current_min_y = figure_properties.YLim(1); 
current_max_y = figure_properties.YLim(2);

axis([new_min_x_backward new_max_x_backward current_min_y current_max_y])

prop_axis = get(gca);

set(y_label,'Position',[(new_min_x_backward -(prop_axis.XTick(2) - prop_axis.XTick(1))/1.8)   mean([current_min_y current_max_y])]);
     
     for kk = triggers_number + 1:length(children_axis)
       
        try
                    
        temp_prop = get(children_axis(kk));
        string_label = temp_prop.String;
        
        set(children_axis(kk),'Position',[(new_min_x_backward -(prop_axis.XTick(2) - prop_axis.XTick(1))/2)   temp_prop.Position(2)]);
        
        catch
            
        end
        
    end
