class ProjectsController < ApplicationController
  
  include ProjectsHelper
  
  before_action :authenticate_user!

  before_action :set_project, only: [:edit, :update, :destroy]

  load_and_authorize_resource

  def index    
    @projects = current_user.projects
    @project = Project.new

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
    @projects = Project.all

    respond_to do |format|      
      format.js
      format.html
    end
  end

  def create
    @project = current_user.projects.new(project_params)    
    update_project_assignment    
    if @project.save
      @projects = current_user.projects
      @project = Project.new
    else
      @error_message = "Some error occurred. Ensure all fields are correctly filled."
    end
    
    respond_to do |format|      
      format.js
    end
  end

  def update           
    update_project_assignment
    if @project.update(project_params)      
      @projects = current_user.projects
      @project = Project.new          
    else      
      @error_message = "Some error occurred.Ensure all fields are correctly filled and no duplicate tasks are being created"
    end    
    respond_to do |format|      
      format.js
      format.html { redirect_to :back}
    end
  end

  def destroy
    @project.destroy
    @projects = current_user.projects
    @project = Project.new    
    respond_to do |format|      
      format.js
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
