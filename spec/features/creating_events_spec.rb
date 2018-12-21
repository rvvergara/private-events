require 'rails_helper'

feature 'Event creation and invitation by event creator' do

  before :each do
    @user = User.first
    page.set_rack_session(user_id: @user.id)

    visit new_user_event_path(@user)

    fill_in("Title", with: Faker::Lorem.sentence)
    find("select", id: "event_date_1i", text: "2019").click
    find("select", id: "event_date_2i", text: "January").click
    find("select", id: "event_date_3i", text: "1").click
    find("select", id: "event_date_4i", text: "07").click
    find("select", id: "event_date_5i", text: "00").click
    fill_in("Venue", with: Faker::GameOfThrones.city)
    fill_in("Description", with: Faker::Lorem.paragraph(3))
    click_on("Create Event")
  end

  scenario "user will go to the new event and see 1 attendee: him" do
    within page.find("ul#attendee_list") do
      expect(page).to have_link(@user.name, href: user_path(@user))
    end
  end

  scenario "user will see Invite button" do
    expect(page).to have_selector(:link_or_button, "Invite People")
  end

end