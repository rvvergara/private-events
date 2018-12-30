FactoryBot.define do
  factory :new_invitation, class: "Invitation" do
    event_id Faker::Number.between(Event.last.id, Event.first.id)

    invitee_id Faker::Number.between(User.first.id, User.last.id)

    responded false
  end
end
