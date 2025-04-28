class Stage < ApplicationRecord
  belongs_to :festival
  has_many   :shows, dependent: :destroy

  validates :name,        presence: true
  validates :festival_id, presence: true
end
