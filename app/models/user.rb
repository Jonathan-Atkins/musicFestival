class User < ApplicationRecord
  has_one :schedule, dependent: :destroy
  has_many :shows, through: :schedule
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :birthday,   presence: true
  
  before_validation { self.email = email.to_s.downcase.strip }

  after_create_commit :create_default_schedule

  def self.find_by_email(email)
    find_by(email: email.downcase.strip)
  end

  private

  def create_default_schedule
    create_schedule!(title: "#{self.first_name} List") unless schedule
  end
end