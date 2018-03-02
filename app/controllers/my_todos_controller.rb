class MyTodosController < ApplicationController
	before_action :authenticate_user!
	authorize_resource :class => false
  before_action :find_todo, :only => [:mark_as_done,:mark_as_in_progress]

	def index
		@todos = current_user.todos
	end

	def mark_as_done		
		@todo.update_attribute :status, "Done"
		@todos = current_user.todos

		respond_to do |format|
			format.js
		end
  end
      
  def mark_as_in_progress  	  	
  	@todo.update_attribute :status, "In Progress"	    	
  	@todos = current_user.todos

  	respond_to do |format|
  		format.js
  	end
  end


  private

  def find_todo
  	@todo = current_user.todos.find(params[:id])
  end
end
