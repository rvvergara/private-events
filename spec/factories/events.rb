FactoryBot.define do
  factory :future_event, class: "Event" do
    creator_id Faker::Number.between(User.first.id,User.last.id)
    title Faker::Lorem.sentence
    date Faker::Time.forward(60, :evening)
    venue Faker::GameOfThrones.city
    description Faker::Lorem.paragraph(3)
  end

  factory :past_event, class: "Event" do
    creator_id Faker::Number.between(User.first.id,User.last.id)
    title Faker::Lorem.sentence
    date Faker::Time.backward(10, :evening)
    venue Faker::GameOfThrones.city
    description Faker::Lorem.paragraph(3)
  end

  factory :invalid_event, class: "Event" do
    creator_id Faker::Number.between(User.first.id,User.last.id)
    title nil
    date Faker::Time.backward(10, :evening)
    venue Faker::GameOfThrones.city
    description Faker::Lorem.paragraph(3)
  end
end