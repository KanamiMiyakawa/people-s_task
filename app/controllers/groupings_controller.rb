class GroupingsController < ApplicationController
  before_action :owner_cant_remove, only: [:destroy]

  def create
    groupings = current_user.groupings.new(group_id:params[:group_id])
    if groupings.save
      redirect_to groups_path, notice: 'グループに参加しました'
    else
      redirect_to groups_path, notice: 'グループに参加できませんでした'
    end
  end

  def destroy
    grouping = Grouping.find(params[:id])
    if grouping.destroy
      redirect_to groups_path, notice: 'グループから離脱しました'
    else
      redirect_to groups_path, notice: 'グループから離脱できませんでした'
    end
  end

  private

  def owner_cant_remove
    if current_user.id == Grouping.find(params[:id]).group.user.id
      redirect_to groups_path, notice: 'オーナーはグループから離脱できません'
    end
  end

end
