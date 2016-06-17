class ShiftEventsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def create
    @shiftevent = ShiftEvent.new(shift_event_params)
    redirect_to @shiftevent if @shiftevent.save
  end

  private

  def shift_event_params
    params.require(:shiftevent).permit(:shift_id, :occurred_at, :signature, :action)
  end
end
