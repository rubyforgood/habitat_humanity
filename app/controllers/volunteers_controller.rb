class VolunteersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def create
    @volunteer = Volunteer.new(volunteer_params)
    redirect_to @volunteer if @volunteer.save
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:name, :email)
  end
end
