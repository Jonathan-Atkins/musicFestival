require 'rails_helper'

RSpec.describe ImageGateway, :vcr do
  it 'can successfully call unsplash database' do
    search_word = 'Queen B'
    photos      = ImageGateway.search_photos(search_word).images
    expect(photos).to be_an Array
  end
end