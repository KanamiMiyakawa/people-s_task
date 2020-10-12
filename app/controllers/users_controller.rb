class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :favorites]
  before_action :fobid_login_user, only: [:new]
  before_action :user_different, only: [:show]

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

  def show
  end

  # def edit
  # end
  #
  # def update
  #   if @user.update(user_params)
  #     redirect_to user_path, notice: 'ユーザー情報を更新しました！'
  #   else
  #     render :edit
  #   end
  # end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_different
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to tasks_path, notice: "他のユーザーの情報は見せません"
    end
  end
end
