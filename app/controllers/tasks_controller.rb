class TasksController < ApplicationController

  def index
    @task= Task.order(created_at: :desc)
  end

  def show
    @task= Task.find(params[:id])
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
