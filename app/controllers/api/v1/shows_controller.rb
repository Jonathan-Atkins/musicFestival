# app/controllers/api/v1/shows_controller.rb
class Api::V1::ShowsController < ApplicationController
  def index
    festival = Festival.find(params[:festival_id])
    shows = Show.joins(:stage).where(stages: { festival_id: festival.id })

    render json: ShowSerializer.new(shows)
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Festival not found." }, status: :not_found
  end
  
  def create
    schedule = Schedule.find(params[:schedule_id])
    show = Show.find(params[:show_id])
  
    if schedule.shows.include?(show)
      render json: { error: "Show already exists in schedule." }, status: :unprocessable_entity
    else
      schedule.shows << show
      render json: { message: "Show added to schedule successfully." }, status: :created
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Schedule or show not found." }, status: :not_found
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
