class ShiftEvent < ActiveRecord::Base
  belongs_to :shift

  validates :shift,       presence: true
  validates :action,      presence: true
  validates :occurred_at, presence: true
end
