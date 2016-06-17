class WorkSite < ActiveRecord::Base
  validates :address, presence: true
end
