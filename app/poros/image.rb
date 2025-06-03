class Image
  attr_reader :images

  def initialize(data)
    @images = data.map { |image| image[:urls][:full] }
  end
end