class Api::V1::FestivalsController < ApplicationController
  def index
    festivals = Festival.all 
    render json: FestivalSerializer.new(festivals), status: :ok  
  end
end
