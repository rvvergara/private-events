class AttendancesController < ApplicationController
  before_action :logged_in_user, only: :create

  def create
    @user = current_user
    @event = Event.find_by(id: params[:attendance][:event_id])
    @attendance = Attendance.new(attendance_params)
    @invitation = Invitation.where("event_id=? AND invitee_id=?", @event.id, @user.id).first
    begin
      @attendance.save
    rescue => exception
      flash[:danger] = "You are already in this event"
      redirect_back(fallback_location:root_path)
    else
      @invitation.accept
      flash[:success] = "You are now part of #{@event.title}! Nice"
      # redirect_to @event
      redirect_back(fallback_location: event_path(@event))
    end
  end

  private

  def attendance_params
    params.require(:attendance).permit(:attendee_id, :event_id)
  end

end
