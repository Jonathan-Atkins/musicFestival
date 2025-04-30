# app/models/user.rb
class User < ApplicationRecord
  has_one  :schedule, dependent: :destroy
  has_many :shows, through: :schedule

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,      presence: true, uniqueness: { case_sensitive: false }
  validates :username,   presence: true
end
