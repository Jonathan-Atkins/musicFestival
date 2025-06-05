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
      data = WeatherGateway.fetch_weather(festival.zip_code)
      {
        day_outlook: data.description,
        temperature: data.temperature
      }
    rescue => e
      {
        day_outlook: "Unavailable",
        temperature: "?"
      }
    end
  end 
end
