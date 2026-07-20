class Tasks2Controller < ApplicationController
  def index
    @tasks2= Task.order(created_at: :desc)
  end

  def show
    @task2= Task.find(params[:id])
  end
  
  def new
    @task2= Task.new
  end

  def create
    @task2= Task.new(title:params[:task][:title], description:params[:task][:description])
    if @task2.save
      redirect_to root_path
    else
      render :new
    end
  end
end
