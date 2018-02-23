class Shift < ActiveRecord::Base
  belongs_to :work_site
  belongs_to :volunteer
  has_many   :shift_events, dependent: :destroy

  validates :work_site, presence: true
  validates :volunteer, presence: true
  validates :day,       presence: true,
                        uniqueness: { scope: %i[work_site_id volunteer_id] }

  delegate :address, to: :work_site
  delegate :name, :email, to: :volunteer, prefix: true

  def shift_start
    shift_events.find_by(action: 'start_shift')
  end

  def shift_start_time
    shift_start.occurred_at
  end

  def shift_end
    shift_events.find_by(action: 'end_shift')
  end

  def shift_end_time
    shift_end.occurred_at
  end

  def started?
    !!shift_start
  end

  def ended?
    !!shift_end
  end

  def complete?
    started? && ended?
  end

  def self.completed
    from(from(with_shift_start, :shifts).with_shift_end, :shifts)
  end

  def self.incomplete
    select('shifts.*, shift_events.action')
      .joins('LEFT JOIN shift_events ON shifts.id = shift_events.shift_id '\
             "AND shift_events.action = 'end_shift'")
      .where('shift_events.action IS NULL')
  end

  def self.with_shift_start
    joins(:shift_events).merge(ShiftEvent.shift_starts)
  end

  def self.with_shift_end
    joins(:shift_events).merge(ShiftEvent.shift_ends)
  end

  def duration_without_breaks
    return unless complete?

    (shift_end.occurred_at - shift_start.occurred_at).seconds / 1.hour
  end

  def duration
    duration_without_breaks - breaks_duration
  rescue IncompleteBreakError
    'Error: volunteer never checked in from break'
  end

  ##
  # @note
  #   Warning: This method expects that every break in the shift has
  #   exactly one start break event and exactly one end break event,
  #   that the start break event precedes the end break event, and that
  #   the breaks do not overlap each other or fall outside of the actual
  #   shift.
  def breaks
    shift_events
      .select(:action, :occurred_at)
      .where(action: %w[start_break end_break])
      .order(:occurred_at)
      .each_slice(2)
  end

  class IncompleteBreakError < StandardError
    def initialize(message = 'start or end time is missing for a break')
      super
    end
  end

  def breaks_duration
    breaks.map do |(start_break, end_break)|
      raise IncompleteBreakError unless start_break && end_break
      end_break.occurred_at - start_break.occurred_at
    end.inject(0.0, :+).seconds / 1.hour
  end

  def signature_in
    shift_start.try(:signature)
  end

  def signature_out
    shift_end.try(:signature)
  end
end
