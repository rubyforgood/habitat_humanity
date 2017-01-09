class WorkSite < ActiveRecord::Base
  has_many :shifts, dependent: :destroy

  validates :address, presence: true

  scope :active, -> { where active: true }

  def active?
    !!active
  end

  def activate
    self.active = true
  end

  def activate!
    activate
    save!
  end

  def deactivate
    self.active = false
  end

  def deactivate!
    deactivate
    save!
  end

  def self.select_box_input
    fallback    = ['All Sites', -1]
    addresses   = where(active: true).order(:address).pluck(:address, :id)
    addresses.unshift fallback
  end

  def self.site_id_selected(params)
    ((params[:site] || {})[:id] || -1).to_i
  end

  def self.addr_for_id(sites, site_id = -1)
    addr_cell = sites.find { |c| c[1] == site_id } || ['unknown', -1]
    addr_cell[0]
  end
end
