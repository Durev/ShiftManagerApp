class ShiftsController < ApplicationController
  def index
    @shift = Shift.new
    @shifts = Shift.all
    @workers = Worker.all
  end

  def create
    worker = Worker.find(shift_params[:worker_id])
    @shift = worker.shifts.build(shift_params)
    if @shift.save
      flash[:success] = "Shift successfully added for #{worker.first_name}."
      redirect_to shifts_url
    else
      @shifts = Shift.all
      @workers = Worker.all
      render 'shifts/index'
    end
  end

  def destroy
    Shift.find(params[:id]).destroy
    flash[:success] = "Shift deleted"
    redirect_to shifts_url
  end

  private

    def shift_params
      params.require(:shift).permit(:worker_id, :start_date)
    end
end
