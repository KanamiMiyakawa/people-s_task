class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_limit]
      @tasks = Task.all.order(limit: "DESC")
    elsif params[:title].present? || params[:status].present?
      if params[:title].present? && params[:status].present?
        @tasks = Task.where('task_name LIKE ?',"%#{params[:title]}%").where(status: params[:status])
      elsif params[:title].present?
        @tasks = Task.where('task_name LIKE ?',"%#{params[:title]}%")
      elsif params[:status].present?
        @tasks = Task.where(status: params[:status])
      end
    else
      @tasks = Task.all.order(created_at: "DESC")
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
    @task = Task.new(task_params)
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
end
