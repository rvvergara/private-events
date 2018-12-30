class UsersInviteController < ApplicationController
  before_action :creator_user
  def show
    @creator = User.find_by(id: params[:user_id])
    @event = @creator.events_created.find_by(id: params[:event_id])
    @users = User.all
  end
end
