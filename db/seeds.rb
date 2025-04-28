# db/seeds.rb

# — Users
alice = User.find_or_create_by!(email: "alice@example.com") do |u|
  u.first_name = "Alice"
  u.last_name  = "Smith"
  u.birthday   = "1990-05-14"
  u.username   = "alice90"
end

bob = User.find_or_create_by!(email: "bob@example.com") do |u|
  u.first_name = "Bob"
  u.last_name  = "Jones"
  u.birthday   = "1985-09-20"
  u.username   = "bobj"
end

# — Festival
festival = Festival.find_or_create_by!(name: "Fiddler's Field Festival")

# — Stages
main_stage = Stage.find_or_create_by!(name: "Main Stage", festival: festival)
jazz_tent  = Stage.find_or_create_by!(name: "Jazz Tent", festival: festival)
east_stage = Stage.find_or_create_by!(name: "East Stage", festival: festival)

# — Shows (assigned to stages)
show1 = Show.find_or_create_by!(
  artist:   "The Rockets",
  location: "Main Stage",
  date:     "2025-08-01",
  time:     "18:00",
  stage_id: main_stage.id  # ← use .id here
)

show2 = Show.find_or_create_by!(
  artist:   "Jazz Trio",
  location: "Jazz Tent",
  date:     "2025-08-01",
  time:     "19:30",
  stage_id: jazz_tent.id   # ← and here
)

show3 = Show.find_or_create_by!(
  artist:   "Indie Band",
  location: "East Stage",
  date:     "2025-08-02",
  time:     "17:45",
  stage_id: east_stage.id  # ← and here
)

# — Alice’s Schedule
alice_schedule = Schedule.find_or_create_by!(
  title: "Alice’s Picks",
  user: alice,
  date: "2025-08-01"
)

# — Link shows to her schedule
ScheduleShow.find_or_create_by!(schedule: alice_schedule, show: show1)
ScheduleShow.find_or_create_by!(schedule: alice_schedule, show: show2)

puts "Your Festival is Seeded 🌱🤲"
