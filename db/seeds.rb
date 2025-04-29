# db/seeds.rb

# — Festivals, Stages & Shows
festivals = []
stages_by_festival = []
shows_by_festival = []

3.times do |f|
  fest = Festival.find_or_create_by!(name: "Festival #{f + 1}")
  festivals << fest

  stages = []
  3.times do |s|
    stage = Stage.find_or_create_by!(name: "Festival #{f + 1} - Stage #{s + 1}", festival: fest)
    stages << stage
  end
  stages_by_festival << stages

  shows = []
  stages.each_with_index do |stage, idx|
    3.times do |i|
      show = Show.find_or_create_by!(
        artist:   "Artist F#{f + 1}S#{idx + 1}##{i + 1}",
        location: stage.name,
        date:     Date.today + 30,
        time:     Time.parse("18:00"),
        stage:    stage
      )
      shows << show
    end
  end
  shows_by_festival << shows
end

# — Users & Schedules
users = []
schedules = []

45.times do |n|
  user = User.find_or_create_by!(email: "user#{n + 1}@example.com") do |u|
    u.first_name = "User#{n + 1}"
    u.last_name  = "Example"
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

puts "Your Festival is Seeded 🌱🤲"
