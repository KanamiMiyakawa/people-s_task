class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env.production?

  protect_from_forgery with: :exception
  include SessionsHelper

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_user
    if current_user == nil
      flash[:alert] = "ログインしてください"
      redirect_to new_session_path
    end
  end

  def fobid_login_user
    if current_user
      redirect_to tasks_path, notice: "すでにログインしています" unless current_user.admin?
    end
  end

  def admin_user
    redirect_to tasks_path, notice: "管理者ではありません" unless current_user.admin?
  end

  def get_available_labels
    @labels = Label.where(official:true).or(Label.where(user_id:current_user.id))
  end
end
