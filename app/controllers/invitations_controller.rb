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
    @invitation = Invitation.find_by(id: params[:id])
    @invitee = User.find_by(id: params[:invitation][:invitee_id])
    @invitation.update(invitation_params)
    redirect_back(fallback_location: root_path)
  end

  private
  def invitation_params
    params.require(:invitation).permit(:invitee_id, :event_id, :responded, :accepted)
  end
end
