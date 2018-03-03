class DevelopersController < ApplicationController
	
  include DevelopersHelper
  
  include ApplicationHelper

  before_action :authenticate_user!

	authorize_resource :class => false

  before_action :set_developer, :only => [:edit, :update, :destroy]
	
  def index  	
    @developers = current_user.developers
  end  

  def create        
    @developer = Developer.new(developer_params)    
    @developer.project_manager_id = current_user.id          
    @developer.save(:validate => false) if valid_developer?      
    @developers = current_user.developers

    respond_to do |format|
      format.js { render :create }
    end
  end

  def edit 
    
  end

  def update           
    old_email = @developer.email    
    @developer.attributes = developer_params
    if valid_developer?     
      @developer.update(developer_params)  
      # If email is changed then send again the confirmation email
      @developer.send_confirmation_instructions if old_email != @developer.email    
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy        
    @developer.destroy 

    respond_to do |format|
      format.js
      format.json {render :json => true}
    end
  end

  def todo_list
    @projects = current_user.projects.includes(:todos)    
    @status_data = {}
    @project_status_data = {}
    # Generate data to be displayed in required format
    generate_data #DevelopersHelper

    respond_to do |format|
      format.html
    end
  end


  private

    def set_developer
      @developers = current_user.developers 
      @developer = @developers.find(params[:id])
      
    end

    def developer_params
      params.permit(:first_name, :last_name, :email, :project_manager_id)
    end

end
