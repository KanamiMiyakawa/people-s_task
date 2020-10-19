class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user, only: [:show]
  before_action :fobid_login_user, only: [:new]
  before_action :user_different, only: [:show]
  before_action :get_available_labels, only: [:show]

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
    @tasks = @user.tasks.created_sorted.page(params[:page]).per(10)
    @task_expired = Task.where(user_id:@user.id).where("task_expired_at<?",Time.zone.today+2).where.not(status:"完了")
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_different
    unless current_user.admin?
      @user = User.find(params[:id])
      if current_user.id != @user.id
        redirect_to tasks_path, notice: "他のユーザーの情報は見れません"
      end
    end
  end
end
