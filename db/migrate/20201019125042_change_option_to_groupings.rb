class ChangeOptionToGroupings < ActiveRecord::Migration[5.2]
  def change
    add_index :groupings, [:user_id, :group_id], unique: true
  end
end
