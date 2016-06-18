class WorkSitesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def create
    @worksite = WorkSite.new(worksite_params)
    redirect_to @worksite if @worksite.save
  end

  private

  def worksite_params
    params.require(:worksite).permit(:address)
  end
end
