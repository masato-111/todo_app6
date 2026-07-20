class TasksController < ApplicationController

  def index
    @tasks= Task.order(created_at: :desc)
  end

  def show
    @task= Task.find(params[:id])
  end

  def edit
    @task= Task.find(params[:id])
  end

  def update
    @task= Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def delete
    @task= Task.find(params[:id])
    @task.destroy!
    redirect_to tasks_path
  end

  
  def new
    @task= Task.new
  end

  def create
    @task= Task.new(task_params)
    if @task.save 
      redirect_to root_path
    else
      render :new
    end
  end


  private
    def task_params
      params.expect(task: [:title,:description,:image])
    end
end
