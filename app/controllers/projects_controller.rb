class ProjectsController < ApplicationController
  
  include ProjectsHelper

  include ApplicationHelper
  
  before_action :authenticate_user!

  before_action :set_project, only: [:edit, :update, :destroy]

  load_and_authorize_resource

  def index    
    get_project_list

    respond_to do |format|
      format.html
    end
  end  

  def new    
    @projects = current_user.projects
    
    respond_to do |format|
      format.html
    end
  end  

  def edit
    @projects = current_user.projects

    respond_to do |format|      
      format.js
      format.html
    end
  end

  def create
    @project = current_user.projects.new(project_params)    
    update_project_assignment #ProjectsHelper   
    if @project.save
      get_project_list
    else
      prepare_error_message(@project.errors.full_messages)
    end
    
    respond_to do |format|      
      format.js
    end
  end

  def update           
    update_project_assignment
    if @project.update(project_params)
      get_project_list            
    else        
      prepare_error_message(@project.errors.full_messages)
    end    
    
    respond_to do |format|      
      format.js      
    end
  end

  def destroy
    @project.destroy    

    respond_to do |format|      
      format.js
      format.json {render :json => true}
    end
  end

  private
    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :client, todos_attributes: [:id, :task, :project_id, :developer_id, :_destroy])
    end
end
