class Renamecolumnintodos < ActiveRecord::Migration
  def change
  	rename_column :todos, :project_developer_id, :developer_id
  end
end
