require 'rails_helper'

feature "Users Invitation Page - perspective of event creator" do
  before :each do
    @user = User.first
    @event = FactoryBot.create(:future_event, creator_id: @user.id)
    page.set_rack_session(user_id: @user.id)
    visit event_path(@event)
    click_on("Invite People")
  end

  scenario "user will be able to open the page" do
    expect(page).to have_selector(:link_or_button, "Invite")
  end
end

feature "Perspective of visitor" do
  before :each do
    @creator = User.first
    @visitor = User.last
    @event = FactoryBot.create(:future_event, creator_id: @creator.id)
    page.set_rack_session(user_id: @visitor.id)
    visit add_invitees_path(@creator, @event)
  end

  scenario "visitor will be redirected to his own page" do
    expect(page).to have_selector("h1", text: @visitor.name)
  end

  scenario "visitor will see a flash message" do
    expect(page).to have_selector("div.alert.alert-danger", text: "You are not authorized to do that!")
  end
end