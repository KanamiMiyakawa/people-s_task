class Task < ApplicationRecord

  validates :task_name,  presence: true
  validates :priority,  presence: true, inclusion: {in:1..10}
  validates :status,  presence: true, inclusion: {in:1..3}

end
