class Festival < ApplicationRecord
  has_many :stages

  validates :name, presence: true
  validates :name, uniqueness: true
end
