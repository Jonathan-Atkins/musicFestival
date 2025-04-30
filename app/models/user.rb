# app/models/user.rb
class User < ApplicationRecord
  has_one  :schedule, dependent: :destroy
  has_many :shows, through: :schedule

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username,   presence: true
  validates :birthday,   presence: true

  def self.find_by_email(email)
    find_by(email: email.downcase.strip)
  end
end
