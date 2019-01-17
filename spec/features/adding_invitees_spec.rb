require 'rails_helper'

feature "event creator invites a user to the event" do
  before :each do
    @creator = FactoryBot.create(:valid_user, username:"creator", email: "@creator@gmail.com")
    
    @invitee = FactoryBot.create(:valid_user, name: "Alex")
    
    @event = FactoryBot.create(:future_event, creator_id: @creator.id)
    
    page.set_rack_session(user_id: @creator.id)

    visit event_path(@event)
    click_on("Invite People")
    within all("li").last do
      click_on("Invite")
    end
  end

  scenario "invitee will see in his page that he is invited to that event" do
    page.set_rack_session(user_id: @invitee.id)
    visit root_path
    expect(page).to have_content("You are invited to")
  end
end 