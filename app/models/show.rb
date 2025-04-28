class Show < ApplicationRecord
  has_many :schedule_shows
  has_many :schedules, through: :schedule_shows
end
