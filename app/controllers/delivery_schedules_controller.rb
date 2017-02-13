class DeliverySchedulesController < ApplicationController
  before_action :set_schedule, only: [:edit, :update, :destroy]

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

  def edit
  end

  def destroy
    if @delivery_schedule.destroy
      redirect_to delivery_schedules_path, notice: 'Delivery schedule deleted.'
    else
      redirect_to delivery_schedules_path, notice: 'Delivery schedule could not be deleted.'
    end
  end

  def update
    if @delivery_schedule.update(delivery_schedule_params)
      redirect_to delivery_schedules_path, notice: 'Delivery date has been updated.'
    else
      render :edit
    end
  end

  private
  def delivery_schedule_params
    params.require(:delivery_schedule).permit(:date, :pickup_location)
  end

  def set_schedule
    @delivery_schedule = DeliverySchedule.find_by(id: params[:id])
  end
end
