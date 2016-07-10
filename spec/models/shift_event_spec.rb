require 'rails_helper'

RSpec.describe ShiftEvent, type: :model do
  it 'validates that the day matches the shift' do
    shift = FactoryGirl.create(:shift)

    expect do
      FactoryGirl.create(:shift_event, shift: shift, occurred_at: shift.day - 1)
    end.to raise_error ActiveRecord::RecordInvalid, /does not match day/
  end
end
