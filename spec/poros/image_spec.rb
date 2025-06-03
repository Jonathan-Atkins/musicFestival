require 'rails_helper'

RSpec.describe Image do
  it 'initializes with a list of image URLs' do
    fake_data = [
      { urls: { full: 'https://example.com/image1.jpg' } },
      { urls: { full: 'https://example.com/image2.jpg' } }
    ]

    image = Image.new(fake_data)

    expect(image.images).to eq([
      'https://example.com/image1.jpg',
      'https://example.com/image2.jpg'
    ])
  end

  it 'returns an empty array if given empty data' do
    image = Image.new([])

    expect(image.images).to eq([])
  end
end