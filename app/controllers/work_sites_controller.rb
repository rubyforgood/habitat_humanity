class WorkSitesController < ApplicationController
  expose(:work_sites) { WorkSite.all }
end