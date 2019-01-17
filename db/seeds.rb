
User.create!(
  name: "Michael Jordan",
  username: "goat",
  email: "jordan@gmail.com",
  password:              "password",
  password_confirmation: "password",
)

11.times do |n|
User.create!(
  name: "User-#{n+1}",
  username: "user#{n+1}",
  email: "user#{n+1}@gmail.com",
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

11.times do |n|
  User.find_by(id: n+1).events_created.create(
    title: "Upcoming Event#{n+1} by User-#{n+1}",
    date: Faker::Time.forward(60, :evening),
    venue: Faker::GameOfThrones.city,
    description: Faker::Lorem.paragraph(3),
  )
end

6.times do |n|
  User.find_by(id: n+1).events_created.create(
    title: "Past Event#{n+1} by User-#{n+1}",
    date: Faker::Time.backward(10, :evening),
    venue: Faker::GameOfThrones.city,
    description: Faker::Lorem.paragraph(3),
  )
end