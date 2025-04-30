# app/controllers/api/v1/shows_controller.rb
class Api::V1::ShowsController < ApplicationController
  def destroy
    schedule = Schedule.find(params[:schedule_id])
    show = schedule.shows.find(params[:id])
    
    schedule.shows.destroy(show)
    
    render json: { message: "Show removed from schedule." }, status: 200
    
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Show or schedule not found." }, status: 404
  end
end
