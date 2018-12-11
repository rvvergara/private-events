
User.create!(
  name: "Michael Jordan",
  username: "goat",
  email: "jordan@gmail.com",
  password:              "password",
  password_confirmation: "password",
)

5.times do |n|
User.create!(
  name: "User-#{n}",
  username: "user#{n}",
  email: "user#{n}@gmail.com",
  password:              "password",
  password_confirmation: "password"
)
end

User.first.events_created.create!(
  title: "Awesome event",
  date: Date.today + 5.days,
  venue: "Pizza Hut",
  description: "Pizza eating party"
)

User.last.events_created.create(
  title: "Event that had happened",
  date: Date.today - 4.days,
  venue: "Mars",
  description: "This has already happened"
)