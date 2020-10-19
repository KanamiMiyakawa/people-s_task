class User < ApplicationRecord
  before_validation { email.downcase! }
  before_destroy :label_manager_check_destroy
  before_destroy :admin_count_check
  before_save :label_manager_check_save
  before_update :admin_edit_check

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :groupings, dependent: :destroy
  has_many :joined_groups, through: :groupings, source: :group

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

  def label_manager_check_destroy
    throw(:abort) if self.admin && self.name =="official_label_manager"
  end

  def label_manager_check_save
    if self.name == "official_label_manager" && User.where(admin: true).count == 1
      errors.add :base, 'この名前は使用できません'
      throw :abort
    elsif self.name_was == "official_label_manager"
      errors.add :base, 'この名前は変更できません'
      throw :abort
    end
  end


end
