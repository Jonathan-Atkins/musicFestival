class Api::V1::SchedulesController < ApplicationController
  def show
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

  def destroy
    @user = User.find_by(id: params[:user_id])
    @schedule = @user&.schedule
  
    if @schedule && @schedule.id == params[:schedule_id].to_i
      @show = @schedule.shows.find_by(id: params[:show_id])
  
      if @show
        @schedule.shows.delete(@show)
        render json: { message: "Show successfully removed from schedule." }, status: :ok
      else
        render json: { errors: [{ detail: "Show not found in the schedule" }] }, status: :not_found
      end
    else
      render json: { errors: [{ detail: "Schedule not found" }] }, status: :not_found
    end
  end
end
