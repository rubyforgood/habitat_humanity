require 'rails_helper'

RSpec.describe Shift do
  describe '#destroy' do
    it 'removes all related ShiftEvents' do
      shift = FactoryGirl.create(:shift, :full)
      shift_event_ids = shift.shift_events.map(&:id)
      shift.destroy
      expect(ShiftEvent.where(id: shift_event_ids).to_a).to be_empty
    end
  end
end
