
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