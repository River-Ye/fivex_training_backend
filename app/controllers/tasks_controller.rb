class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
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
      redirect_to root_path, notice: "任務成功!"
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: "更新成功!"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: "刪除成功!"
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content)
  end
end