class Shift < ActiveRecord::Base
  belongs_to :work_site
  belongs_to :volunteer

  validates :work_site, presence: true
  validates :volunteer, presence: true
  validates :date,      presence: true,
                        uniqueness: { scope: [:work_site_id, :volunteer_id] }
end
