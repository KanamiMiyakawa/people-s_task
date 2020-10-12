class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.order(created_at: "DESC")
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザー情報を更新しました！'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました！'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def admin_user
    redirect_to tasks_path, notice: "管理者ではありません" unless current_user.admin?
  end

end
