class RenameLimitColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :limit, :task_expired_at
  end
end
