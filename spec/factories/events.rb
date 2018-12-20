FactoryBot.define do
  factory :future_event, class: "Event" do
    title Faker::Lorem.sentence
    date Faker::Time.forward(60, :evening)
    venue Faker::GameOfThrones.city
    description Faker::Lorem.paragraph(3)
  end

  factory :past_event, class: "Event" do
    title Faker::Lorem.sentence
    date Faker::Time.backward(10, :evening)
    venue Faker::GameOfThrones.city
    description Faker::Lorem.paragraph(3)
  end

  factory :invalid_event, class: "User" do
    title nil
    date Faker::Time.forward(60, :evening)
    venue Faker::GameOfThrones.city
    description Faker::Lorem.paragraph(3)
  end
end