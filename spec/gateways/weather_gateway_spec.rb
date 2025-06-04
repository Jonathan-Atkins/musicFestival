require 'rails_helper'

RSpec.describe WeatherGateway, :vcr do
  it 'can successfully call unsplash database' do
    zip_code = '89032'
    weather  = WeatherGateway.fetch_weather(zip_code)
  end
end