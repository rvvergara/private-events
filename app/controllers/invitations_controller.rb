class InvitationsController < ApplicationController
  def create
    @event = Event.find_by(id: params[:invitation][:event_id])

    @creator = User.find_by(id: params[:creator_id])

    @invitee = User.find_by(id: params[:invitation][:invitee_id])

    @invitation = Invitation.new(event_id: @event.id, invitee_id: @invitee.id)

    @invitation.save
    
    redirect_to add_invitees_path(@creator.id, @event)
  end

  def update
    @invitee = User.find_by(id:params[:invitation][:invitee_id])
    @event = Event.find_by(id:params[:invitation][:event_id])
    @invitation = Invitation.find_by(id: params[:id])
    @invitation.decline
    flash[:warning] = "You declined invitation to attend #{@event.title}"
    redirect_back(fallback_location: root_path)
  end
end
