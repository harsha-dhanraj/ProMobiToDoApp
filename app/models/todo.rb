class Todo < ActiveRecord::Base

	belongs_to :developer, :class_name => "User"

	belongs_to :project

	validates_uniqueness_of :task, :scope => :project_id

	scope :new_todos, -> {where(:status => "New")}

	scope :in_progress_todos, -> {where(:status => "In Progress")}

	scope :done_todos, -> {where(:status => "Done")}

	STATUS = ["New", "Done", "In Progress"]	

	STATUS.each do |status|
	  define_method("#{status.downcase.split(' ').join('_')}?") do 
			self.status == status
  	end
  end	

end
