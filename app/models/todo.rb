class Todo < ActiveRecord::Base
	belongs_to :developer, :class_name => "User"
	belongs_to :project
	validates_uniqueness_of :task, :scope => :project_id
	validates_presence_of :task, :scope => :project_id
	validates_presence_of :developer_id, :scope => :project_id
end
