class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.eager_load(:tasks).order(created_at: "DESC").page(params[:page]).per(15)
    @labels = Label.where(official:true)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'ユーザーを作成しました！'
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks.created_sorted.page(params[:page]).per(10)
    @labels = Label.where(user_id:@user.id)
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
    if @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました！'
    else
      redirect_to admin_users_path, notice: 'official_label_managerは削除できません'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
