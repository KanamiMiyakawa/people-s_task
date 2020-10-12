class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all.order(created_at: "DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = User.last.id
      redirect_to tasks_path, notice: 'ユーザー登録が完了しました！'
    else
      render :new
    end
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
