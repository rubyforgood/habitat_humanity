require 'rails_helper'

RSpec.describe Shift, type: :model do
  describe '#destroy' do
    it 'removes all related ShiftEvents' do
      shift = FactoryGirl.create(:shift, :full)
      shift_event_ids = shift.shift_events.map(&:id)
      shift.destroy
      expect(ShiftEvent.where(id: shift_event_ids).to_a).to be_empty
    end
  end

  describe '#duration' do
    it 'is numeric if the shift has start and end times for each break' do
      shift = FactoryGirl.create(:shift, :full)
      expect(shift.duration).to be_a Numeric
    end

    it 'can handle a missing shift_end event' do
      shift = FactoryGirl.create :shift, :missing_break_return
      expect(shift.duration).to \
        eq 'Error: volunteer never checked in from break'
    end
  end

  describe '#breaks_duration' do
    it 'raises an `IncompleteBreakError` if the volunteer forgot to sign back '\
       'in from their break' do
      shift = FactoryGirl.create :shift, :missing_break_return
      expect { shift.breaks_duration }.to raise_error \
        Shift::IncompleteBreakError
    end
  end

  describe '.completed' do
    it 'returns only completed shifts' do
      complete_shift = FactoryGirl.create :shift, :full
      FactoryGirl.create :shift, :incomplete

      completed_shifts = Shift.completed

      expect(completed_shifts.size).to eq 1
      expect(completed_shifts).to include complete_shift
    end
  end

  describe '.incomplete' do
    it 'returns only incomplete shifts' do
      complete_shift = FactoryGirl.create(:shift, :full)
      incomplete_shift = FactoryGirl.create(:shift, :incomplete)

      incomplete_shifts = Shift.incomplete

      expect(incomplete_shifts).to include incomplete_shift
      expect(incomplete_shifts).not_to include complete_shift
      incomplete_shifts.each { |shift| expect(shift.shift_end).to be nil }
      expect(incomplete_shifts.size).to eq 1
    end

    it 'can be limited to a specific day' do
      past_incomplete_shift = FactoryGirl.create(:shift, :incomplete)
      past_incomplete_shift.update(day: Date.new(2017, 1, 9))
      incomplete_shift = FactoryGirl.create(:shift, :incomplete)
      incomplete_shift.update(day: Date.new(2017, 1, 10))
      future_incomplete_shift = FactoryGirl.create(:shift, :incomplete)
      future_incomplete_shift.update(day: Date.new(2017, 1, 11))

      incomplete_shifts = Shift.incomplete.where(day: Date.new(2017, 1, 10))

      expect(incomplete_shifts).to include incomplete_shift
      expect(incomplete_shifts).not_to include past_incomplete_shift
      expect(incomplete_shifts).not_to include future_incomplete_shift
      incomplete_shifts.each { |shift| expect(shift.shift_end).to be nil }
      expect(incomplete_shifts.size).to eq 1
    end
  end
end
