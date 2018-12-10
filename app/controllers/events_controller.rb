class EventsController < ApplicationController
  
  def index
  end

  def show
  end

  def new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "#{@event.title} has been created. Invite people to attend!"
      redirect_to @event
    else
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  
  def event_params
    params.require(:event).permit(:title, :date, :venue)
  end
end
