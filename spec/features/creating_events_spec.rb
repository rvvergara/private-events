require 'rails_helper'

feature "valid event creation" do
  before :each do
    @user = User.first
    page.set_rack_session(user_id: @user.id)
    visit new_user_event_path(@user)
    fill_in("Title", with: Faker::Lorem.sentence)
    select("2019", from: "event_date_1i").click
    select("January", from: "event_date_2i").click
    select("1", from: "event_date_3i").click
    select("07", from: "event_date_4i").click
    select("00", from: "event_date_5i").click
    fill_in("Venue", with: Faker::GameOfThrones.city)
    fill_in("Description", with: Faker::Lorem.paragraph(3))
    click_on("Create Event")
  end

  scenario "user will see his name in the list of attendees" do
    within page.find("ul#attendee_list") do
      expect(page).to have_link(@user.name, href: user_path(@user))
    end
  end

  scenario "user will see an invite people button" do
    expect(page).to have_selector(:link_or_button, "Invite People")
  end
end

feature "invalid event creation" do
  before :each do
    @user = User.first
    page.set_rack_session(user_id: @user.id)
    visit new_user_event_path(@user)
    select("2019", from: "event_date_1i").click
    select("January", from: "event_date_2i").click
    select("1", from: "event_date_3i").click
    select("07", from: "event_date_4i").click
    select("00", from: "event_date_5i").click
    fill_in("Venue", with: Faker::GameOfThrones.city)
    fill_in("Description", with: Faker::Lorem.paragraph(3))
    click_on("Create Event")
  end

  scenario "user will see the event creation form again" do
    expect(page).to have_selector("input#event_title")
  end

  scenario "user will see message 'title can't be blank'" do
    expect(page).to have_content("Title can't be blank")
  end

end