class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|            
    if user_signed_in?
      if current_user.type == "ProjectManager"
        redirect_to projects_path, :alert => exception.message
      else
        redirect_to developers_path, :alert => exception.message
      end
    end
  end 

  

  protected

  def layout_by_resource
    if user_signed_in?
      if current_user.type == "ProjectManager"        
        'admin'
      else
        'developer'
      end
    end
  end

  def after_sign_up_path_for(resource)
    projects_path
  end  

  def after_sign_in_path_for(resource)
    # vehicles_path # Or :prefix_to_your_route
    if resource.type == "ProjectManager"
      projects_path 
    else
      developers_path
    end
  end

  def after_sign_out_path_for(resource)    
    new_session_path(:user)    
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name, :role])
  end
end
