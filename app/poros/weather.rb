class Weather
  attr_reader :city, :description, :temp_min, :temp_max

 def initialize(data)
    @city        = data[:name]
    @description = data[:weather].first[:description]
    @temp_min    = data[:main][:temp_min]
    @temp_max    = data[:main][:temp_max]
  end
end