FactoryBot.define do
  factory :attendance, class:"Attendance" do
    event_id Faker::Number.between(Event.last.id,Event.first.id)

    attendee_id Faker::Number.between(User.first.id, User.last.id)
  end
end