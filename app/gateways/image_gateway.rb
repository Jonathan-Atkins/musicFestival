class ImageGateway
  def self.search_photos(search_word, params= {})
    response = conn.get("/search/photos") do |req|
      req.params[:client_id] = Rails.application.credentials.unsplash[:access_key]
      req.params[:query] = search_word
      req.params[:per_page] = 1
    end
    Image.new(parse_data(response))
  end

  def self.conn
    Faraday.new("https://api.unsplash.com")
  end

  def self.parse_data(data)
    json = JSON.parse(data.body, symbolize_names: true)[:results]
  end

  private_class_method :conn, :parse_data
end