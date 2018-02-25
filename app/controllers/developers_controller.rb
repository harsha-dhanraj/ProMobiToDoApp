class DevelopersController < ApplicationController
	# layout 'developer'
	authorize_resource :class => false
	
  def index
  	@todos = current_user.todos
  end

  def change_status_to_done
  	todo = current_user.todos.find(params[:id])
  	todo.status = "Done"
  	todo.save
    # return updated todos for the current user
  	@todos = current_user.todos
  	respond_to do |format|
  		format.js
  	end
  end
      
  def change_status_to_in_progress
  	todo = current_user.todos.find(params[:id])
  	todo.status = "In Progress"
  	todo.save
    # return updated todos for the current user
  	@todos = current_user.todos
  	respond_to do |format|
  		format.js
  	end
  end
end
