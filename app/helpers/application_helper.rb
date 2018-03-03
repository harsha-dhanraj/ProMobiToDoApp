module ApplicationHelper

	def alert_class_for(flash_type)
    {
      :success => 'alert-success',
      :error => 'alert-danger',
      :alert => 'alert-warning',
      :notice => 'alert-success'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def prepare_error_message(errors)    
    errors = errors.uniq    
    puts "errors => #{errors.inspect}"
    if !errors.empty?
      @message = "<ul>" 
      errors.each do |e|         
        @message += "<li>#{e}</li>" 
      end 
      @message += "</ul>"

      @message = @message.html_safe
    else      
      @message = nil
    end
  end
  
end
