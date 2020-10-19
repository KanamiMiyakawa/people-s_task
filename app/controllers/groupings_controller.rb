class GroupingsController < ApplicationController

  def create
    groupings = current_user.groupings.new(group_id:params[:group_id])
    if groupings.save
      redirect_to groups_path, notice: 'グループに参加しました'
    else
      redirect_to groups_path, notice: 'グループに参加できませんでした'
    end
  end

  def destroy
  end
end
