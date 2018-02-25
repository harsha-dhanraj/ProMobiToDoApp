class ProjectManagersController < ApplicationController
  # layout 'admin'
  authorize_resource :class => false
  def add_developer    
  	@developers = current_user.developers
    respond_to do |format|
      format.html
    end
  end

  def create_developer
    # Set default password to each developer
    pass = "1234test"
    Developer.create({:first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :password => pass, :password_confirmation => pass, :project_manager_id => current_user.id})    
    @developers = current_user.developers    
    respond_to do |format|
      format.js
    end
  end

  def edit_developer
  	@developer = current_user.developers.find(params[:id])
  end

  def update_developer
  	@developer = current_user.developers.find(params[:id])
  	@error = false
  	attributes = {:first_name => params[:first_name],:last_name => params[:last_name],:email => params[:email]}
  	if @developer.update(attributes)  		
  		@developers = current_user.developers
  	else
  		@error = true
  	end
  end

  def delete_developer
  	@developer = current_user.developers.find(params[:id])
    # Unassign developer from the assigned todos
  	@developer.todos.each do |t|
  		t.developer_id = nil
  		t.save
  	end
  	@developer.destroy
  	@developers = current_user.developers
  	respond_to do |format|
  		format.js
  	end
  end
end
