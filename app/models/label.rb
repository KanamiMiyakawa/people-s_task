class Label < ApplicationRecord
  before_save :change_id_to_label_manager
  before_destroy :official_check

  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :tasks, through: :labellings

  validates :label_name,  presence: true

  private

  def change_id_to_label_manager
    self.user_id = User.find_by(name:"official_label_manager").id if self.official?
  end

  def official_check
    throw(:abort) if !(User.find_by(id:self.user_id).admin) && self.official
  end
end
