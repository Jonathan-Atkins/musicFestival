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
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_presence_of(:birthday) }
  end

    describe 'callbacks' do
    it 'downcases and trims email before validation' do
      user = FactoryBot.build(:user, email: '  TEST@Example.COM ')
      expect { user.validate }.to change { user.email }.to('test@example.com')
    end

    it 'auto-creates a schedule after create' do
      user = FactoryBot.create(:user)
      expect(user.schedule).to be_present
      expect(user.schedule.title).to include(user.first_name) # optional: asserts naming format
    end
  end
  describe '.find_by_email' do
    it 'returns the user if the email matches exactly' do
      user = FactoryBot.create(:user, email: 'test@example.com')
      found = User.find_by_email('test@example.com')

      expect(found).to eq(user)
    end

    it 'returns the user if the email has different casing and whitespace' do
      user = FactoryBot.create(:user, email: 'test@example.com')
      found = User.find_by_email('  TEST@example.com ')

      expect(found).to eq(user)
    end

    it 'returns nil if no user is found' do
      expect(User.find_by_email('nonexistent@example.com')).to be_nil
    end
  end
end
