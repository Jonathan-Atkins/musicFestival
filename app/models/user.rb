class User < ApplicationRecord
  has_many :schedules
  has_many :shows, through: :schedules

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true
end
