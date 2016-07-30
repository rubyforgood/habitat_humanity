class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_from_resource

  protected

  # Returns the appropriate layout for a given resource.
  #
  # This code is here in order to keep the logic about admin controllers/layouts
  # (ex. layout name, admin controller list, etc.) in a single place.
  def layout_from_resource
    admin_layout   = 'admin/non_administrate'
    default_layout = 'application'

    admin_controller? ? admin_layout : default_layout
  end

  private

  def admin_controller?
    devise_controller? || controller_name.in?(admin_controllers)
  end

  # A list of controllers in the "admin" flow, excluding administrate/devise.
  # Add controller names to the list to give their views the admin layout.
  def admin_controllers
    %w(signatures_reports hours_reports)
  end
end
