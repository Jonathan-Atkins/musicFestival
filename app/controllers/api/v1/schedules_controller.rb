class Api::V1::SchedulesController < ApplicationController
  def show
    require 'pry'; binding.pry
    @user = User.find_by(id: params[:user_id])

    if @user
      @schedule = @user.schedule  

      if @schedule.nil?
        render json: { data: { attributes: { shows: [] } } }  
      else
        render json: ScheduleSerializer.new(@schedule)  
      end
    else
      render json: { errors: [{ detail: "User not found" }] }, status: :not_found
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [{ detail: "User not found" }] }, status: :not_found
  end
end
