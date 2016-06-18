class ShiftEvent < ActiveRecord::Base
  ACTIONS = %w(
    start_shift
    start_break
    end_break
    end_shift
  ).freeze

  belongs_to :shift

  validates :shift,       presence: true
  validates :action,      presence: true
  validates :occurred_at, presence: true
end
