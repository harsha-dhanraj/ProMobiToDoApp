class Todo < ActiveRecord::Base
	belongs_to :developer, :class_name => "User"
	belongs_to :project
	validates_uniqueness_of :task, :scope => :project_id
	validates_presence_of :task, :scope => :project_id
	validates_presence_of :developer_id, :scope => :project_id
	# validate :developer_id_presence


	# def developer_id_presence
	# 	puts "comming hereeeee"
	# 	if self.developer_id.blank?
	# 		errors.add(:base, "developer should be present")
	# 	else
	# 		puts "nooooooooooooooooooo"
	# 	end
	# end
end
