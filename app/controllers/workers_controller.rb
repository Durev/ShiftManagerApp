class WorkersController < ApplicationController
  def index
    @worker = Worker.new
    @workers = Worker.all
  end

  def show
    @worker = Worker.find(params[:id])
  end

  def create
    @worker = Worker.new(worker_params)
    if @worker.save
      flash[:success] = "Worker successfully created !"
      redirect_to edit_worker_path(@worker)
    else
      @workers = Worker.all
      render 'index'
    end
  end

  def edit
    @worker = Worker.find(params[:id])
  end

  def update
    @worker = Worker.find(params[:id])
    if @worker.update_attributes(worker_params)
      flash[:success] = "Worker updated !"
      redirect_to edit_worker_path(@worker)
    else
      render 'edit'
    end
  end

  def destroy
    Worker.find(params[:id]).destroy
    flash[:success] = "Worker deleted"
    redirect_to workers_path
  end

  private

    def worker_params
      params.require(:worker).permit(:first_name, :status)
    end
end
