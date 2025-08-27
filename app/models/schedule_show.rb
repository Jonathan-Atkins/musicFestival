class ScheduleShow < ApplicationRecord
  belongs_to :schedule
  belongs_to :show

  validates :schedule_id, presence: true
  validates :show_id, presence: true
  validates :show_id, uniqueness: { scope: :schedule_id }
end
