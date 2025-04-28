class Show < ApplicationRecord
  belongs_to :stage
  has_many   :schedule_shows, dependent: :destroy
  has_many   :schedules, through: :schedule_shows

  validates :artist,    presence: true
  validates :location,  presence: true
  validates :date,      presence: true
  validates :time,      presence: true
  validates :stage_id,  presence: true
end
