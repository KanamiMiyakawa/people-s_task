class Task < ApplicationRecord

  validates :task_name,  presence: true
  validates :content, presence: true
  validates :priority,  presence: true, inclusion: {in:1..5}
  validates :limit, presence: true
  validates :status,  presence: true, inclusion: {in:1..3}

end
