class Admin::LabelsController < ApplicationController
  before_action :admin_user

  def new
    @label = Label.new
  end

  def create
    label_manager = User.find_by(name:"official_label_manager")
    @label = Label.new(label_name:"#{params[:label][:label_name]}", official:true, user_id:label_manager.id)
    if @label.save
      redirect_to admin_users_path, notice: '公式ラベルを作成しました！'
    else
      render :new
    end
  end

  def destroy
  end

end
