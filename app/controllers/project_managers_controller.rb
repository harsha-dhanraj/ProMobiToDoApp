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
    rand_password = (('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a).shuffle.first(8).join    
    Developer.create({:first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :password => rand_password, :password_confirmation => rand_password, :project_manager_id => current_user.id})
    @developers = current_user.developers
    puts "developers => #{@developers.inspect}"
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
  	puts "developer found #{@developer.inspect}"
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
