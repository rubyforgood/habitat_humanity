class Shift < ActiveRecord::Base
  belongs_to :work_site
  belongs_to :volunteer
  has_many   :shift_events

  validates :work_site, presence: true
  validates :volunteer, presence: true
  validates :day,       presence: true,
                        uniqueness: { scope: [:work_site_id, :volunteer_id] }

  def shift_start
    shift_events.find_by(action: 'start_shift')
  end

  def shift_end
    shift_events.find_by(action: 'end_shift')
  end

  def started?
    !!shift_start
  end

  def ended?
    !!shift_end
  end
end
