class WorkSitesController < ApplicationController
  expose(:work_sites) { WorkSite.all }
  expose(:work_site) { WorkSite.find params.fetch(:id) }

  expose(:check_in_form) { CheckInForm.new }
end
