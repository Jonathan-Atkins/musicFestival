class FestivalSerializer
  include JSONAPI::Serializer

  attributes :name, :zip_code

  attribute :attendee_count do |festival|
    festival
      .stages
      .flat_map(&:shows)
      .flat_map(&:users)
      .uniq
      .count
  end

  attribute :artists do |festival|
    festival
      .stages
      .flat_map(&:shows)
      .map(&:artist)
      .uniq
  end

  attribute :weather do |festival|
    begin
      weather = WeatherGateway.fetch_weather(festival.zip_code)
      {
        day_outlook: weather.description.split.map(&:capitalize).join(' '),
        temperature_low: "#{weather.temp_min} 🥶",
        temperature_high: "#{weather.temp_max} 🥵"
      }
    rescue => e
      puts "❌ Weather fetch failed for #{festival.name} (#{festival.zip_code}): #{e.class} - #{e.message}"
      {
        day_outlook: "Something went wrong - ,maybe look outside yourself ",
        temperature_low: "N/a",
        temperature_high: "N/a"
      }
    end
  end
end
