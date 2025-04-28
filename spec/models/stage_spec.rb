require 'rails_helper'

RSpec.describe Stage, type: :model do
  describe 'associations' do
    it { should belong_to(:festival) }
    it { should have_many(:shows).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:festival_id) }
  end
end
