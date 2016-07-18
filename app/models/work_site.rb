class WorkSite < ActiveRecord::Base
  has_many :shifts, dependent: :destroy

  validates :address, presence: true

  scope :active, -> { where active: true }
end
