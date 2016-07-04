class ShiftEvent < ActiveRecord::Base
  ACTIONS = {
    'start_shift' => 'Start Shift',
    'start_break' => 'Start Break',
    'end_break'   => 'End Break',
    'end_shift'   => 'End Shift'
  }.freeze

  belongs_to :shift

  validates :shift,       presence: true
  validates :action,      presence: true, inclusion: { in: ACTIONS }
  validates :occurred_at, presence: true

  delegate :address, :day, :volunteer_name, :volunteer_email, to: :shift
end
