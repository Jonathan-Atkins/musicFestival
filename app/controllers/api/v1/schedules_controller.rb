#Shows all of the events a user is attending
class Api::V1::SchedulesController < ApplicationController
  before_action :set_user

  def show
    return render_not_found("User not found") unless @user

    schedule = @user.schedule
    return render_not_found("Schedule not found") unless schedule
    return render_not_found("Schedule does not belong to user") unless schedule.id.to_s == params[:id].to_s #Ownership guard: if the :id in the URL doesn’t match this user’s schedule ID, return 404.

    render json: ScheduleSerializer.new(schedule), status: :ok
  end

  private

  def set_user
    @user = User.find_by(id: params[user_id])
  end

  def render_not_found(detail)
    render json: { errors: [{detail: detail}] }, status: :not_found
  end