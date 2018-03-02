class RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    if resource.type == "ProjectManager"
      todo_list_developers_path 
    else
      my_todos_path
    end
  end
end