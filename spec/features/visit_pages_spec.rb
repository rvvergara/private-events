require 'rails_helper'
require 'spec_helper'

feature "non-logged user visits homepage" do
  before :each do
    visit root_path
  end

  scenario "user will see a welcome message" do
    expect(page).to have_content("Welcome to events")
  end

  scenario "user will see upcoming events if any" do
    expect(page).to have_content("Upcoming Events")
  end

  scenario "user will see past events if any" do
    expect(page).to have_content("Past Events")
  end

  scenario "user will see details buttons for each upcoming events" do
    upcoming_events_count = Event.upcoming_events.count
    within first("div.col-md-6") do
      expect(page).to have_selector(:link_or_button, "Detail", count: upcoming_events_count)
    end
  end

  scenario "user will see details buttons for each past events" do
    past_events_count = Event.past_events.count
    within page.all("div.col-md-6")[1] do
      expect(page).to have_selector(:link_or_button, "Detail", count: past_events_count)
    end
  end

  scenario "user will find link to home page with text Events galore" do
    expect(page).to have_link("Events Galore", href: root_path)
  end

  scenario "user will find link to create an event that leads to login path" do
    expect(page).to have_link("Create", href: login_path)
  end

  scenario "user will find link to login path" do
    expect(page).to have_link("Log in", href: login_path)
  end

  scenario "user will find link to sign up path" do
    expect(page).to have_link("Sign up", href: signup_path)
  end

  scenario "user will find link to events index" do
    expect(page).to have_link("Events", href: events_path)
  end

end

feature "non-logged user visits an event page" do
  before :each do
    @upcoming_event = Event.upcoming_events[0]
    visit root_path
    within page.all("div.col-md-6")[0] do
      page.all("a.btn")[0].click
    end
  end

  scenario "user will see event details/description" do
    expect(page).to have_content(@upcoming_event.description)
  end

  scenario "user will see Attend Event button that leads to login path" do
    expect(page).to have_link("Attend Event")
  end

  scenario "user will list of attendees of the event" do
    guests = @upcoming_event.attendees
    if guests.any?
      expect(page).to have_link(guests.first.name, href: user_path(guests.first))
    end
  end
end

feature "logged and non-logged users visits another user's page" do
  before :each do
    @user = User.first
    visit user_path(@user)
  end

  scenario "visitor sees user's name" do
    will_attend = @user.upcoming_events
    attended = @user.past_events

    will_attend.each do |event|
      expect(page).to have_link(event.title, href: event_path(event))
    end

    attended.each do |event|
      expect(page).to have_link(event.title, href: event_path(event))
    end

  end
end

feature "logged user visits homepage" do
  before :each do
    @user = User.first
    page.set_rack_session(user_id:@user.id)
    visit root_path
  end

  scenario "user sees a link with his name on it" do
    expect(page).to have_link(@user.name)
  end

  scenario "user will see link to his/her profile upon clicking his name in upper right corner" do
    click_on(@user.name)
    expect(page).to have_link("Profile", href: user_path(@user))
  end

  scenario "user will see edit profile link" do
    click_on(@user.name)
    expect(page).to have_link("Edit Profile", href: edit_user_path(@user))
  end

  scenario "user will see logout link" do
    click_on(@user.name)
    expect(page).to have_link("Logout", href: logout_path)
  end

end