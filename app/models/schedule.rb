class Schedule < ApplicationRecord
  belongs_to :user
  has_many :schedule_shows
  has_many :shows, through: :schedule_shows
end
