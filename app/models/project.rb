class Project < ActiveRecord::Base
	belongs_to :project_manager	
	has_many :todos
  	accepts_nested_attributes_for :todos, allow_destroy: true, reject_if: proc { |attributes| attributes['developer_id'].blank? }
  	has_and_belongs_to_many :users
end
