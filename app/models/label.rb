class Label < ApplicationRecord
  belongs_to :user

  validates :label_name,  presence: true
end
