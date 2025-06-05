class WeatherGateway
  def self.fetch_weather(zip_code)
    puts "🌤️ Fetching weather for ZIP: #{zip_code}"
    
    response = conn.get do |req|
      req.params[:zip] = "#{zip_code},us"
      req.params[:appid]    = Rails.application.credentials.dig(:open_weather, :api_key)
      req.params[:units]    = 'imperial'
    end

    Weather.new(parse_data(response))
  end

  def self.conn
    Faraday.new("https://api.openweathermap.org/data/2.5/weather")
  end

  def self.parse_data(data)
    JSON.parse(data.body, symbolize_names: true)
  end

  private_class_method :conn, :parse_data
end