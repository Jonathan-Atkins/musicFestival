require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { is_expected.to have_one(:schedule).dependent(:destroy) }
    it { is_expected.to have_many(:shows).through(:schedule) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:birthday) }
  end
end
