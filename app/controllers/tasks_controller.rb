class TasksController < ApplicationController
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
