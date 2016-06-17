class ShiftsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def create
    @shift = Shift.new(shift_params)
    redirect_to @shift if @shift.save
  end

  private

  def shift_params
    params.require(:shift).permit(:volunteer_id, :shift_id, :day)
  end
end
