class RemoveIndexUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, column: :name
  end
end
