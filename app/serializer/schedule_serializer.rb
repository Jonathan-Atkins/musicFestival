# app/serializers/schedule_serializer.rb
class ScheduleSerializer
  include JSONAPI::Serializer

  attribute :user_id

  attribute :shows do |schedule|
    if schedule.shows.any?
      schedule.shows.map do |show|
        {
          id:       show.id,
          artist:   show.artist,
          location: show.location,
          time:     show.time.to_s
        }
      end
    else
      "You dont have any shows scheduled!"
    end
  end
end
