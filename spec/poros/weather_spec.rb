# spec/poros/weather_spec.rb
require 'rails_helper'

RSpec.describe Weather do
  it 'initializes with city, description, temp_min, and temp_max' do
    fake_data = {
      name: "North Las Vegas",
      weather: [{ description: "clear sky" }],
      main: {
        temp_min: 85.0,
        temp_max: 95.0
      }
    }

    weather = Weather.new(fake_data)

    expect(weather.city).to eq("North Las Vegas")
    expect(weather.description).to eq("clear sky")
    expect(weather.temp_min).to eq(85.0)
    expect(weather.temp_max).to eq(95.0)
  end
end
