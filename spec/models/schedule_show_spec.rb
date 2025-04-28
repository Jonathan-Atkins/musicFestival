require 'rails_helper'

RSpec.describe ScheduleShow, type: :model do
  describe 'relationships' do
    it { should belong_to(:schedule) }
    it { should belong_to(:show) }
  end

  describe 'validations' do
    it { should validate_presence_of(:schedule_id) }
    it { should validate_presence_of(:show_id) }
  end
end
