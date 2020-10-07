class ChangeOptionToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :content, :string, null: false
    change_column :tasks, :priority, :integer, null: false
    change_column :tasks, :limit, :date, null: false
    change_column :tasks, :status, :integer, null: false
  end
end
