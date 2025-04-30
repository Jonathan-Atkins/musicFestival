class Api::V1::SchedulesController < ApplicationController
  def show
    @user = User.find_by(id: params[:user_id])

    if @user
      if @user.schedule.nil?
        render json: []
      else
        render json: ScheduleSerializer.new(@user.schedule)
      end
    else
      render json: { errors: [{ detail: "User not found" }] }, status: :not_found
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [{ detail: "User not found" }] }, status: :not_found
  end
end
