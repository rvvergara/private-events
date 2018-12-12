class AttendancesController < ApplicationController
  
  def create
    @event = Event.find_by(id: params[:id])
    begin
      @event.add_attendee(current_user)
    rescue => exception
      flash[:danger] = "You are already in this event"
      render "users/show"
    else
      redirect_to @event
    end
  end

end
