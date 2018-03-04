module ProjectsHelper

	def update_project_assignment				
    if !params[:developers].nil?    	
    	developers_ids = params[:developers].blank? ? [] : params[:developers].reject(&:blank?)    	    	
    	@project.users = current_user.developers.where(:id => developers_ids)           
    end
	end	

	def get_project_list
		@projects = current_user.projects
    @project = Project.new
	end
	
end
