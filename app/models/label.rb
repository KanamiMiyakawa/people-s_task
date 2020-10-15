class Label < ApplicationRecord
  before_save :change_id_to_label_manager

  belongs_to :user
  has_many :labellings
  has_many :tasks, through: :labellings

  validates :label_name,  presence: true

  private

  def change_id_to_label_manager
    self.user_id = User.find_by(name:"official_label_manager").id if self.official?
  end
end
