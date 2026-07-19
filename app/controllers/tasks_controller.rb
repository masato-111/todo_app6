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
    if @task.update(title:params[:task][:title], description:params[:task][:description])
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  
  def new
    @task= Task.new
  end

  def create
    @task= Task.new(title:params[:task][:title], description:params[:task][:description])
    if @task.save 
      redirect_to root_path
    else
      render :new
    end
  end
end
