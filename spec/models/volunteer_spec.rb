require 'rails_helper'

describe Volunteer, type: :model do
  describe '#destroy' do
    it 'deletes the volunteer' do
      volunteer = create(:volunteer)
      expect { volunteer.destroy! }.to change { Volunteer.count }.from(1).to(0)
    end

    it 'removes associated shifts' do
      volunteer = create(:volunteer, :with_shifts, shift_count: 2)
      expect { volunteer.destroy! }.to change { Shift.count }.from(2).to(0)
    end
  end
end
