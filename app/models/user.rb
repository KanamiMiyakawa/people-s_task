class User < ApplicationRecord
  before_validation { email.downcase! }
  before_destroy :admin_count_check
  before_update :admin_edit_check

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :tasks, dependent: :destroy

  private

  def admin_count_check
    throw(:abort) if self.admin && User.where(admin: true).count == 1
  end

  def admin_edit_check
    if self.admin_was && self.admin_changed? && User.where(admin: true).count == 1
      errors.add :base, '最後の管理ユーザーです'
      throw :abort
    end
  end

end
