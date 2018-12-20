class AttendancesController < ApplicationController
  before_action :logged_in_user, only: :create

  def create
    @user = current_user
    @event = Event.find_by(id: params[:attendance][:event_id])
    @attendance = Attendance.new(attendance_params)
    begin
      @attendance.save
    rescue => exception
      flash[:danger] = "You are already in this event"
      render "users/show"
    else
      flash[:success] = "You are now part of this event! Nice"
      redirect_to @event
    end
  end

  private

  def attendance_params
    params.require(:attendance).permit(:attendee_id, :event_id)
  end

end
