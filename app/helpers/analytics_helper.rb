module AnalyticsHelper

	def generate_graph_data
		projects = current_user.projects.includes(:todos)
		@data = [["Status", "Project Count"]]
    @accordian_data = []
    Todo::STATUS.each do |status|
      count = 0
      todos = []
      projects.each do |project|
        count = count + project.todos.inject(0){|sum,i| sum + ((i.status == status) ? 1 : 0)}
        todos << project.todos.where(status: status).flatten
      end
      @data << [status, count]
      @accordian_data << [status, todos.flatten]
    end
	end
  
end
