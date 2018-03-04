module DevelopersHelper

  def valid_developer?
    valid = true
    @developer.attributes = developer_params
    @developer.project_manager_id = current_user.id          
    if !@developer.valid?
      puts "#{@developer.errors.full_messages}"
      errors = @developer.errors.full_messages-["Password can't be blank"]
      if !errors.empty?
        prepare_error_message(errors) 
        valid = false
      end
    else
      puts "*************************"
    end
    return valid
  end

	# def send_confirmation_email_to_developer(old_email,current_email)		   
		
	# end

	def generate_data
		@developers = current_user.developers.includes(:todos)
    Todo::STATUS.each do |status|
      @status_data[status] = {}
      @developers.each do |developer|
        @status_data[status][developer.id] = []
        developer.todos.each do |todo|
          @status_data[status][developer.id] << todo.task if todo.status == status
        end
      end
      @project_status_data[status] = {}
      @projects.each do |project|        
        @project_status_data[status][project.id] = []
        project.todos.each do |todo|
          @project_status_data[status][project.id] << todo.task if todo.status == status
        end
      end
    end      

    # Table header fetched from user_ids in view
    @user_ids = []
    @status_data.values.each do |v|      
      @user_ids << v.keys
    end

    # Table header fetched from project_ids in view
    @project_ids = []
    @project_status_data.values.each do |v|      
      @project_ids << v.keys
    end

    @user_ids = @user_ids.flatten.reject(&:blank?).uniq
    @project_ids = @project_ids.flatten.reject(&:blank?).uniq
	end
  
end
