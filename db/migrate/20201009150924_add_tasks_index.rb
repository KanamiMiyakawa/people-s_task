class AddTasksIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :task_name
    add_index :tasks, :status
  end
end
