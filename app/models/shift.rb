class Shift < ActiveRecord::Base
  belongs_to :work_site
  belongs_to :volunteer
  has_many   :shift_events

  validates :work_site, presence: true
  validates :volunteer, presence: true
  validates :day,       presence: true,
                        uniqueness: { scope: [:work_site_id, :volunteer_id] }

  # WIP
  validates_each :shift_events do |record, attr, value|
    if !record.started? && value.action != 'start_shift'
      # Disallow
    end

    if record.started? && value.action == 'start_shift'
      # Disallow addition of attr...only allow modification of attr
    end

    if record.ended? && value.action == 'end_shift'
      # Disallow
    end

    # Disallow more things
  end

  def shift_start
    shift_events.where(action: 'start_shift').first
  end

  def shift_end
    shift_events.where(action: 'end_shift').first
  end

  def started?
    !!shift_start
  end

  def ended?
    !!shift_end
  end
end
