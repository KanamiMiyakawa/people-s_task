class Task < ApplicationRecord
  enum status: { 未着手:0, 着手:1, 完了:2 }
  enum priority: { 不急:1, 低:2, 中:3, 高:4, 緊急:5}

  validates :task_name,  presence: true
  validates :content, presence: true
  validates :priority,  presence: true
  validates :limit, presence: true
  validates :status,  presence: true

  scope :title_searched, -> (title){ where('task_name LIKE ?',"%#{title}%") }
  scope :status_searched, -> (status){ where(status: status) }
  scope :label_searched, -> (label_id){ where(id: Labelling.where(label_id: label_id).pluck(:task_id)) }

  scope :limit_sorted, -> { order(limit: "DESC") }
  scope :created_sorted, -> { order(created_at: "DESC") }
  scope :priority_sorted, -> { order(priority: "DESC") }

  belongs_to :user
  has_many :labellings
  has_many :labels, through: :labellings

end
