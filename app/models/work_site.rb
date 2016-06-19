class WorkSite < ActiveRecord::Base
  validates :address, presence: true

  scope :active, -> { where active: true }
end
