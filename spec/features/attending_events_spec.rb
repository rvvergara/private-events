require 'rails_helper'
require 'spec_helper'

feature "logged user tries to attend upcoming 
event from event page" do
  before :each do
    @invitee = User.first
    @event = FactoryBot.create(:future_event)
    @invitation = FactoryBot.create(:new_invitation, event_id: @event.id, invitee_id: @invitee.id)
    page.set_rack_session(user_id: @invitee.id)
    visit event_path(@event)
    click_on("Accept")
  end

  scenario "user will now see the text 'You are attending this event' in lieu of Attend Event button" do
    expect(page).to have_content("You are attending this event")
  end

  scenario "user will now see a link with his name in the list of attendees" do
    within page.all("ul").last do
      expect(page).to have_link(@invitee.name, href: user_path(@invitee))
    end
  end

  scenario "user will now see this event in his/her page as part of Events he/she will attend" do
    skip
    visit user_path(@invitee)
    
    within "ol" do
      expect(page).to have_link(@event.title, event_path(@event))
    end
  end

end

feature "logged user clicks on Accept Invite" do
  before :each do
    @invitee = FactoryBot.create(:valid_user)
    @event = FactoryBot.create(:future_event)
    @invitation = FactoryBot.create(:new_invitation, event_id: @event.id, invitee_id: @invitee.id)
    page.set_rack_session(user_id: @invitee.id)
    visit root_path
    click_on("Accept")
    @invitee.reload
  end

  scenario "root page will now show Events will be attending" do
    skip
    expect(page).to have_content("Events #{@invitee.name} will be attending:")
  end

  scenario "user will now see event in his own page" do
    skip
    visit user_path(@invitee)
    expect(page).to have_link(@event.title, event_path(@event))
  end

end