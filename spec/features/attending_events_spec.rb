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