class UsersInviteController < ApplicationController
  before_action :authorized_user
  def show
    @creator = User.find_by(id: params[:creator_id])
    @event = @creator.events_created.find_by(id: params[:event_id])
    @users = User.all
  end
end
