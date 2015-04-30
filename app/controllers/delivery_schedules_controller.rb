class DeliverySchedulesController < ApplicationController
  def new
    @delivery_schedule = DeliverySchedule.new
  end

  def index
    @delivery_schedules = DeliverySchedule.all
  end

  def create
    @delivery_schedule = DeliverySchedule.new(delivery_schedule_params)
    if @delivery_schedule.save
      redirect_to delivery_schedules_path, notice: 'Delivery schedule added.'
    else
      render :new
    end
  end

  private
    def delivery_schedule_params
      params.require(:delivery_schedule).permit(:date)
    end
end
