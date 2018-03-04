class MyTodosController < ApplicationController
	
  before_action :authenticate_user!
	
  authorize_resource :class => false
  
  before_action :find_todo, :only => [:mark_as_done,:mark_as_in_progress]

  respond_to :js, only: [:mark_as_done, :mark_as_in_progress]

	def index
		@todos = current_user.todos
	end

	def mark_as_done		
		@todo.nil? ? (@error = true) : (@todo.update_attribute :status, "Done")
  end
      
  def mark_as_in_progress  	  	
  	@todo.nil? ? (@error = true) : (@todo.update_attribute :status, "In Progress")
  end


  private

  def find_todo
    @todos = current_user.todos
  	@todo = @todos.find(params[:id]) rescue nil    
  end
end
