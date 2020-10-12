class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all.order(created_at: "DESC")
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def admin_user
    redirect_to tasks_path, notice: "管理者ではありません" unless current_user.admin?
  end

end
