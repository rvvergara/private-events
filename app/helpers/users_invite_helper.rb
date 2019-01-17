module UsersInviteHelper
  def creator_user
    event = Event.find_by(id: params[:event_id])
    if current_user != event.creator
      flash[:danger] = "You are not authorized to do that!"
      redirect_to event_path(event)
    end
  end
end
