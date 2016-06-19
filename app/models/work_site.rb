class WorkSite < ActiveRecord::Base
  validates :address, presence: true

  scope :active, lambda { where active: true }
end
