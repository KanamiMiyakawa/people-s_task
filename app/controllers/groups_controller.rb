class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :only_owner, only: [:edit, :update, :destroy]
  before_action :only_member, only: [:show]

  def index
    @groups = Group.all
  end

  def show
    @members = @group.users
    @group_tasks = Task.where(user_id:@members.pluck(:id))
    if params[:sort_limit]
      @group_tasks = Task.where(user_id:@members.pluck(:id)).limit_sorted.page(params[:page]).per(10)
    elsif params[:sort_priority]
      @group_tasks = Task.where(user_id:@members.pluck(:id)).priority_sorted.page(params[:page]).per(10)
    else
      @group_tasks = Task.where(user_id:@members.pluck(:id)).created_sorted.page(params[:page]).per(10)
    end
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      current_user.groupings.create!(group_id:@group.id)
      redirect_to @group, notice: 'グループを作成しました！'
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'グループを削除しました'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:group_name, :group_detail)
  end

  def only_owner
    if current_user.id != @group.user.id
      redirect_to groups_path, notice: 'グループ作成者のみ可能です'
    end
  end

  def only_member
    unless @group.users.include?(current_user)
      redirect_to groups_path, notice: 'グループ参加者のみ可能です'
    end
  end
end
