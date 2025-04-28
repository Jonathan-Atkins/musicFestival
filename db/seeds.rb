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

# — Shows
show1 = Show.find_or_create_by!(
  artist:   "The Rockets",
  location: "Main Stage",
  date:     "2025-08-01",
  time:     "18:00"
)

show2 = Show.find_or_create_by!(
  artist:   "Jazz Trio",
  location: "Jazz Tent",
  date:     "2025-08-01",
  time:     "19:30"
)

show3 = Show.find_or_create_by!(
  artist:   "Indie Band",
  location: "East Stage",
  date:     "2025-08-02",
  time:     "17:45"
)

# — Alice’s schedule
alice_schedule  = Schedule.find_or_create_by!(
  title: "Alice’s Picks",
  user:  alice,
  date:  "2025-08-01"
)

# — Link shows to her schedule (no loop—just individual calls)
ScheduleShow.find_or_create_by!(schedule: alice_schedule , show: show1)
ScheduleShow.find_or_create_by!(schedule: alice_schedule , show: show2)


puts "Your Festival is Seeded 🌱🤲"