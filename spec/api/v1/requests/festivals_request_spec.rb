require 'rails_helper'

RSpec.describe "Festivals API", type: :request do
  before(:each) do
    @festival1 = FactoryBot.create(:festival)
    @festival2 = FactoryBot.create(:festival)

    @stages_festival1 = FactoryBot.create_list(:stage, 3, festival: @festival1)
  
    @stages_festival1.each do |stage|
      FactoryBot.create(:show, stage: stage)  
    end

    @stages_festival2 = FactoryBot.create_list(:stage, 4, festival: @festival2)
    @stages_festival2.each do |stage|
      FactoryBot.create(:show, stage: stage)  
    end

    @show_left_out = FactoryBot.create(:show, stage: FactoryBot.create(:stage, festival: @festival2))

    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)

    @schedule1 = FactoryBot.create(:schedule, user: @user1)

    @schedule2 = FactoryBot.create(:schedule, user: @user2)
    FactoryBot.create(:schedule_show, schedule: @schedule2, show: @stages_festival2.first.shows.first)
  end

  describe "GET /api/v1/festivals/:id/schedules" do
    it "returns all schedules for a festival" do

      get "/api/v1/festivals"

      expect(response).to be_successful
      festivals = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(festivals).to be_an(Array)
      expect(festivals.first).to have_key(:id)
      expect(festivals.first[:type]).to eq("festival")
      expect(festivals.first).to have_key(:attributes)

      fest1 = festivals.find { |f| f[:id].to_i == @festival1.id }
      fest2 = festivals.find { |f| f[:id].to_i == @festival2.id }

      attrs1 = fest1[:attributes]
      attrs2 = fest2[:attributes]

      expect(attrs1[:name]).to eq(@festival1.name)
      expect(attrs1[:attendee_count]).to eq(0)

      expect(attrs2[:name]).to eq(@festival2.name)
      expect(attrs2[:attendee_count]).to eq(1)
    end
  end
end
