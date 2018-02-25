class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  

  def index
    @projects = current_user.projects.includes(:todos)
    todos = Todo.all
    @status_data = {}
    @project_status_data = {}
    @developers = current_user.developers.includes(:todos)
    # projects = current_user.projects.includes(:todos)
    ["Done","In Progress","New"].each do |status|
      @status_data[status] = {}
      @developers.each do |developer|
        @status_data[status][developer.id] = []
        developer.todos.each do |todo|
          @status_data[status][developer.id] << todo.task if todo.status == status
        end
      end
      @project_status_data[status] = {}
      @projects.each do |project|
        puts "@project_status_data[status]=> #{@project_status_data[status].inspect}"
        @project_status_data[status][project.id] = []
        project.todos.each do |todo|
          @project_status_data[status][project.id] << todo.task if todo.status == status
        end
      end
    end
    
    puts "@status_data => #{@status_data.inspect}"
    puts "@project_status_data => #{@project_status_data.inspect}"

    @user_ids = []
    @status_data.values.each do |v|
      # puts "v => #{v.inspect}"
      @user_ids << v.keys
    end

    @project_ids = []
    @project_status_data.values.each do |v|
      # puts "v => #{v.inspect}"
      @project_ids << v.keys
    end

    @user_ids = @user_ids.flatten.reject(&:blank?).uniq
    @project_ids = @project_ids.flatten.reject(&:blank?).uniq

    puts "User Ids => #{@user_ids.inspect}"

    
    # @status = Todo.all.group_by{|todo| [todo.status, todo.developer.first_name]}
    # @developers = @status.keys.map{|s| s[1]}
    # respond_with(@projects)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_with(@project)
  end

  def new
    @project = Project.new
    @projects = current_user.projects
    # respond_with(@project)
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
    @project.users = current_user.developers.where(:id => params[:developers])
    @project.save
    @projects = current_user.projects
    @project = Project.new
    
    respond_to do |format|      
      format.js
    end
  end

  def update   
    @error = false 
    @message = ""    
    if @project.update(project_params)
      if !params[:developers].nil?
        @project.users = current_user.developers.where(:id => params[:developers])
        @project.save
      end      
    else
      @error = true
      @message = "Some error occurred.Ensure all fields are correctly filled and no duplicate tasks are being created"   
      puts "#{@project.errors.full_messages.inspect}"
    end
    @projects = current_user.projects
    @project = Project.new
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

  def analytics
    projects = current_user.projects.includes(:todos)
    @data = [["Status", "Project Count"]]
    @accordian_data = []
    ["New","Done","In Progress"].each do |status|
      count = 0
      todos = []
      projects.each do |project|
        count = count + project.todos.inject(0){|sum,i| sum + ((i.status == status) ? 1 : 0)}
        todos << project.todos.where(status: status).flatten
      end
      @data << [status, count]
      @accordian_data << [status, todos.flatten]
    end

    puts "DATA => #{@data.inspect}"
    puts "ACCORDIAN DATA => #{@accordian_data.inspect}"
  end

  private
    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :client, todos_attributes: [:id, :task, :project_id, :developer_id, :_destroy])
    end
end
