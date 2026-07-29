class ProfessorsController < ApplicationController
   def index
    @professors= Professor.order(created_at: :desc)
  end

  def show
    @professor= Professor.find(params[:id])
  end

  def edit 
    @professor= Professor.find(params[:id])
  end

  def update
    @professor= Professor.find(params[:id])
    if @professor.update(professor_params)
      redirect_to professor_path(@professor)
    else
      render :edit
    end
  end

  def destroy
    @professor= Professor.find(params[:id])
    @professor.destroy!
     redirect_to professors_path
  end
  
  def new
    @professor= Professor.new
  end

  def create
    @professor= Professor.new(professor_params)
    if @professor.save
      redirect_to professors_path
    else
      render :new
    end
  end

  private
  def professor_params
    params.expect(professor: [:title,:description,:image])
  end
end



