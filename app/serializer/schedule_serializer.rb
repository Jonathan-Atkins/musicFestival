# app/serializers/schedule_serializer.rb
class ScheduleSerializer
  include JSONAPI::Serializer
  set_type :schedule

  attributes :user_id

  attribute :shows do |schedule|
    schedule.shows.map do |show|
      {
        id:       show.id,
        artist:   show.artist,
        date:     show.date.to_s,     
        location: show.location,
        time:     show.time.to_s  
      }
    end
  end
end
