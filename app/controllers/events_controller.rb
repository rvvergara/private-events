class EventsController < ApplicationController
  
  def index
  end

  def show
    # @user = User.find_by(id: params[:user_id])
    @event = Event.find_by(id: params[:id])
  end

  def new
    @user = User.find_by(id: params[:user_id])
    @event = Event.new
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @event = @user.events_created.new(event_params)
    if @event.save
      flash[:success] = "#{@event.title} has been created. Invite people to attend!"
      redirect_to @event
    else
    end
  end

  def edit
    @event = Event.find_by(id:params[:id])
  end

  def update
    @event = Event.find_by(id:params[:id])
    if @event.update(event_params)
      flash[:success] = "#{@event.title} successfully updated!"
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  
  def event_params
    params.require(:event).permit(:title, :date, :venue, :description)
  end
end
