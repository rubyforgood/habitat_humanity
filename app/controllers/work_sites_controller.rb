class WorkSitesController < ApplicationController
  expose(:work_sites) { WorkSite.all }
  expose(:work_site) { WorkSite.find params.fetch(:id) }
end