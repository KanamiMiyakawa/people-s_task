class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:index, :show, :new, :edit]
  before_action :task_different_user, only: [:show, :edit, :destroy]

  def index
    if params[:sort_limit]
      @tasks = current_user.tasks.limit_sorted.page(params[:page]).per(10)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.priority_sorted.page(params[:page]).per(10)
    elsif params[:title].present? && params[:status].present?
      @tasks = current_user.tasks.title_searched(params[:title]).status_searched(params[:status]).page(params[:page]).per(10)
    elsif params[:title].present?
      @tasks = current_user.tasks.title_searched(params[:title]).page(params[:page]).per(10)
    elsif params[:status].present?
      @tasks = current_user.tasks.status_searched(params[:status]).page(params[:page]).per(10)
    else
      @tasks = current_user.tasks.created_sorted.page(params[:page]).per(10)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: t('notice.task_created')
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: t('notice.task_updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: t('notice.task_deleted')
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :priority, :limit, :status, :content)
  end

  def task_different_user
    @task = Task.find(params[:id])
    if current_user.id != @task.user_id
      redirect_to tasks_path, notice: "他のユーザーのタスクは見れません"
    end
  end
end
