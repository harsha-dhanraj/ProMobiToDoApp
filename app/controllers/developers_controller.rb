class DevelopersController < ApplicationController
	include DevelopersHelper
  before_action :authenticate_user!

	authorize_resource :class => false

  before_action :set_developer, :only => [:edit, :update, :destroy]
	
  def index  	
    @developers = current_user.developers
  end  

  def create        
    @developer = Developer.new(developer_params)    
    @developer.save(:validate => false)
    @developers = current_user.developers 

    respond_to do |format|
      format.js { render :create }
    end
  end

  def edit 
    
  end

  def update           
    old_email = @developer.email     
    if @developer.update(developer_params)
      current_email = @developer.email
      send_confirmation_email_to_developer(old_email,current_email)        
      @developers = current_user.developers      
    else
      puts "Error ocurred"
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy        
    @developer.destroy
    @developers = current_user.developers

    respond_to do |format|
      format.js
    end
  end

  def todo_list
    @projects = current_user.projects.includes(:todos)    
    @status_data = {}
    @project_status_data = {}
    generate_graph_data

    respond_to do |format|
      format.html
    end
  end


  private

    def set_developer
      @developer = current_user.developers.find(params[:id])
    end

    def developer_params
      params.permit(:first_name, :last_name, :email, :project_manager_id)
    end

end
