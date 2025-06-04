require 'rails_helper'

RSpec.describe WeatherGateway, :vcr do
  it 'fetches weather data for a given ZIP code' do
    zip_code = '89032'
    weather  = WeatherGateway.fetch_weather(zip_code)

    expect(weather).to be_a(Weather)
    expect(weather.city).to eq('North Las Vegas')
    expect(weather.description).to be_a(String)
    expect(weather.temp_min).to be_a(Numeric)
    expect(weather.temp_max).to be_a(Numeric)
  end
end
