class AddContentToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :content, :string
  end
end
