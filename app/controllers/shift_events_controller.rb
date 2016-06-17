class ShiftEventsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  def index
    @shift_events = ShiftEvent.all
  end

  def create
    @shift_event = ShiftEvent.new(shift_event_params)
    if @shift_event.save!
      redirect_to @shift_event
    else
      flash[:notice] = "Error"
    end
  end


  private

  def shift_event_params
    params.require(:shift_event).permit(:occured_at, :signature, :action)
  end
end
