class Task < ApplicationRecord
  enum status: { 未着手:0, 着手:1, 完了:2 }

  validates :task_name,  presence: true
  validates :content, presence: true
  validates :priority,  presence: true, inclusion: {in:1..5}
  validates :limit, presence: true
  validates :status,  presence: true

end
