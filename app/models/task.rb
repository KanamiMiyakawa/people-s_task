class Task < ApplicationRecord
  enum status: { 未着手:0, 着手:1, 完了:2 }

  validates :task_name,  presence: true
  validates :content, presence: true
  validates :priority,  presence: true, inclusion: {in:1..5}
  validates :limit, presence: true
  validates :status,  presence: true

  scope :title_searched, -> (title){ where('task_name LIKE ?',"%#{title}%") }
  scope :status_searched, -> (status){ where(status: status) }
  scope :limit_sorted, -> { order(limit: "DESC") }
  scope :created_sorted, -> { order(created_at: "DESC") }

end
