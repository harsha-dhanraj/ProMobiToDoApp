class TodoObserver < ActiveRecord::Observer
  def after_update(todo)                      	
  	if todo.developer_id_was != todo.developer_id
  		if todo.status_was != "Done"  			  	
    		DeveloperMailer.nofify_of_todo_assignment(todo).deliver    		
    		old_developer = Developer.find(todo.developer_id_was)
    		DeveloperMailer.nofify_of_todo_unassignment(old_developer,todo).deliver if old_developer != todo.developer
    	end    	
    end    
  end

  def after_create(todo)                      	
    DeveloperMailer.nofify_of_todo_assignment(todo).deliver if !todo.developer_id.blank?        
  end
end