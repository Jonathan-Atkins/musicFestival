require 'faker'

REAL_ZIP_CODES = ['90210', '10001', '60601'] # Beverly Hills, Manhattan, Chicago

festivals = []
stages_by_festival = []
shows_by_festival = []

3.times do |f|
  fest_name = "#{Faker::Music.genre} Fest #{f + 1}"
  fest = Festival.find_or_initialize_by(name: fest_name)
  fest.zip_code = REAL_ZIP_CODES[f]
  fest.save!
  festivals << fest

  stages = []
  3.times do |s|
    stage = Stage.find_or_create_by!(name: "#{fest_name} - Stage #{s + 1}", festival: fest)
    stages << stage
  end
  stages_by_festival << stages

  shows = []
  stages.each do |stage|
    3.times do
      show = Show.find_or_create_by!(
        artist:   Faker::Music.band,
        location: stage.name,
        date:     Date.today + rand(1..60),
        time:     Time.parse("#{rand(14..22)}:00"),
        stage:    stage
      )
      shows << show
    end
  end
  shows_by_festival << shows
end

users = []
schedules = []

45.times do |n|
  user = User.find_or_create_by!(email: "user#{n + 1}@example.com") do |u|
    u.first_name = Faker::Name.first_name
    u.last_name  = Faker::Name.last_name
    u.birthday   = Date.new(1990, 1, (n % 28) + 1)
    u.username   = "user#{n + 1}"
  end
  users << user

  schedule = Schedule.find_or_create_by!(
    title: "#{user.username}'s Schedule",
    user:  user,
    date:  Date.today
  )
  schedules << schedule
end

# — Assign attendees to each show's schedule
3.times do |f_index|
  festival_shows = shows_by_festival[f_index]
  user_offset = f_index * 15
  attendee_count = (f_index == 2) ? 14 : 15
  group = schedules.slice(user_offset, attendee_count)

  # Step 1: Ensure each user is assigned to at least one show
  group.each_with_index do |schedule, idx|
    show = festival_shows[idx % festival_shows.length]
    ScheduleShow.find_or_create_by!(schedule: schedule, show: show)
  end

  # Step 2: Fill each show to exactly 5 attendees
  festival_shows.each do |show|
    existing_ids = ScheduleShow.where(show: show).pluck(:schedule_id)
    needed = 5 - existing_ids.size
    available = group.reject { |sch| existing_ids.include?(sch.id) }

    available.sample(needed).each do |schedule|
      ScheduleShow.find_or_create_by!(schedule: schedule, show: show)
    end
  end
end

last_schedule = schedules.last
ScheduleShow.where(schedule: last_schedule).delete_all

puts "Your Festival is Seeded 🌱🤲"
