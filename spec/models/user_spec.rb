require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it {is_expected.to have_many :schedules }
    it {is_expected.to have_many :shows }
    end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:username) }
  end
end
