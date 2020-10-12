class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :favorites]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to tasks_path, notice: 'ユーザー登録が完了しました！'
      #redirect_to new_session_path(@user.id), notice: 'ユーザー登録が完了しました！'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'ユーザー情報を更新しました！'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
