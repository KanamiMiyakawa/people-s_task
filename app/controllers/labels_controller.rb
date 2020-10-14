class LabelsController < ApplicationController
  before_action :authenticate_user

  def new
    @label = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to user_path(current_user.id), notice: 'ラベルを作成しました'
    else
      render :new
    end
  end

  def destroy
    Label.find(params[:id]).destroy!
    redirect_to user_path(current_user.id), notice: 'ラベルを削除しました！'
  end

  private

  def label_params
    params.require(:label).permit(:label_name)
  end

end
