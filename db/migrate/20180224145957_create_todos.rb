class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :task
      t.integer :project_id
      t.integer :project_developer_id

      t.timestamps
    end
  end
end
