class Grouping < ApplicationRecord
  before_destroy :owner_cant_remove

  belongs_to :user
  belongs_to :group

  def owner_cant_remove
    if current_user.id == Group.find(self.group_id).user.id
      throw :abort
    end
  end
end
