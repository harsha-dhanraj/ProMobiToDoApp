class RegistrationsController < Devise::RegistrationsController

  protected

    def after_update_path_for(resource)
	    if resource.type == "ProjectManager"
	      projects_path 
	    else
	      developers_path
	    end
	  end
end