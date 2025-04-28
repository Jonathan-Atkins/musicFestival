class User < ApplicationRecord
  has_many :schedules
  has_many :shows, through: :schedules
end
