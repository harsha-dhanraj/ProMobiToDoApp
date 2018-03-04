class Project < ActiveRecord::Base	

	belongs_to :project_manager	

	has_many :todos, dependent: :destroy

	accepts_nested_attributes_for :todos, allow_destroy: true, reject_if: proc { |attributes| attributes['task'].blank? }

	has_and_belongs_to_many :users

	validates :name, :description, :client, presence: true	

	validates :name, length: { maximum: 150 }

	validates :name, uniqueness: { message: "(Project name) should be uniq" }	

	validates :client, length: { maximum: 150 }

	validates :description, length: { maximum: 300 }

end
