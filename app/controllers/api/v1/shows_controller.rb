# app/controllers/api/v1/shows_controller.rb
class Api::V1::ShowsController < ApplicationController
  def index
    if params[:festival_id]
      festival = Festival.find(params[:festival_id])
      shows = Show.joins(:stage).where(stages: { festival_id: festival.id })
      render json: ShowSerializer.new(shows)
    elsif params[:schedule_id]
      schedule = Schedule.find(params[:schedule_id])
      shows = schedule.shows
      render json: ShowSerializer.new(shows)
    else
      render json: { error: "Missing context: festival_id or schedule_id required." }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Festival or schedule not found." }, status: :not_found
  end
  
  def create
    user = User.find_by(id: params[:user_id])
    return render json: { error: "User not found" }, status: :not_found unless user

    schedule = Schedule.find_by(id: params[:schedule_id], user_id: user.id)
    return render json: { error: "Schedule not found for this user" }, status: :not_found unless schedule
    
    return render json: { error: "Show ID must be provided" }, status: :bad_request if params[:show_id].blank?
  
    show = Show.find_by(id: params[:show_id])
    return render json: { error: "Show not found" }, status: :not_found unless show
  
    if schedule.shows.include?(show)
      render json: { error: "Show already exists in schedule." }, status: :unprocessable_entity
    else
      schedule.shows << show
      render json: { message: "Show added to schedule successfully." }, status: :created
    end
  end

  def destroy
    schedule = Schedule.find(params[:schedule_id])
    show = schedule.shows.find(params[:id])
    
    schedule.shows.destroy(show)
    
    render json: { message: "Show removed from schedule." }, status: 200
    
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Show or schedule not found." }, status: 404
  end
end
