class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.integer :priority
      t.date :limit
      t.integer :status

      t.timestamps
    end
  end
end
