class Admin::LabelsController < ApplicationController
  before_action :admin_user

  def new
    @label = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to admin_users_path, notice: '公式ラベルを作成しました！'
    else
      render :new
    end
  end

  def destroy
    Label.find(params[:id]).destroy!
    redirect_to admin_users_path, notice: 'ラベルを削除しました！'
  end

  private

  def label_params
    params.require(:label).permit(:label_name, :official)
  end
end
