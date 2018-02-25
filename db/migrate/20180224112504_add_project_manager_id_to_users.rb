class AddProjectManagerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :project_manager_id, :integer
  end
end
