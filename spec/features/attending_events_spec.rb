require 'rails_helper'
require 'spec_helper'

feature "non logged user tries to attend an upcoming event" do
  before :each do
    @event = Event.last
    visit event_path(@event)
    click_on("Attend Event")
  end

  context "user will be redirected to login page" do
    scenario "user will be redirected to login page" do
      expect(page).to have_selector("h1", text:"Log In")
    end
    
    scenario "user will find field for username" do
      expect(page).to have_field("Username")
    end

    scenario "user will find field for password" do
      expect(page).to have_field("Password")
    end

  end

end

feature "logged user tries to attend upcoming event" do
  before :each do
    @user = User.first
    @event = Event.last
    page.set_rack_session(user_id: @user.id)
    visit event_path(@event)
    click_on("Attend Event")
  end

  scenario "user will now see the text 'You are attending this event' in lieu of Attend Event button" do
    expect(page).to have_content("You are attending this event")
  end

  scenario "user will now see a link with his name in the list of attendees" do
    within page.all("ul").last do
      expect(page).to have_link(@user.name, href: user_path(@user))
    end
  end

  scenario "user will now see this event in his page as part of his 'will attend' events" do
    visit user_path(@user)
    within page.all("ol").first do
      expect(page).to have_link(@event.title, href: event_path(@event))
    end
  end

end