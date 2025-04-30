# app/controllers/api/v1/schedules_controller.rb
class Api::V1::SchedulesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @schedule = @user.schedule
  
    if @schedule
      render json: ScheduleSerializer.new(@schedule)
    else
      render json: { errors: [{ detail: "Schedule not found" }] }, status: :not_found
    end
  
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [{ detail: "User not found" }] }, status: :not_found
  end
end
