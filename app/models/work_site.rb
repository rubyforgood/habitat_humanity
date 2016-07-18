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
end
