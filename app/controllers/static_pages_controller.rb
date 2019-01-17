class StaticPagesController < ApplicationController
  def home
    @user = current_user if logged_in?
    @upcoming_events = Event.upcoming_events
    @past_events = Event.past_events
  end
end
