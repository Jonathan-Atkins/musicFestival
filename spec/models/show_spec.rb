require 'rails_helper'

RSpec.describe Show, type: :model do
  describe 'relationships' do
    it { should belong_to(:stage) }
    it { should have_many(:schedule_shows).dependent(:destroy) }
    it { should have_many(:schedules).through(:schedule_shows) }
    it { should have_many(:users).through(:schedules) }
  end

  describe 'validations' do
    it { should validate_presence_of(:artist) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:time) }
    it { should validate_presence_of(:stage_id) }
  end
end
