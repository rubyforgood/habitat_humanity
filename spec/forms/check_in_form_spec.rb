require 'rails_helper'

RSpec.describe CheckInForm do
  describe 'signature field' do
    it 'is required for start_shift' do
      form = build :check_in_form, signature: nil, action: 'start_shift'

      expect(form).to_not be_valid
    end

    it 'is required for end_shift' do
      form = build :check_in_form, signature: nil, action: 'end_shift'

      expect(form).to_not be_valid
    end

    it 'is not required for start_break' do
      form = build :check_in_form, signature: nil, action: 'start_break'

      expect(form).to be_valid
    end

    it 'is not required for end_break' do
      form = build :check_in_form, signature: nil, action: 'end_break'

      expect(form).to be_valid
    end
  end

  describe '#save' do
    context 'when the volunteer signs in for the start of the shift' do
      let(:form) { build :check_in_form, action: 'start_shift' }

      it 'creates a shift' do
        expect { form.save }.to change { Shift.count }.by(1)
      end

      it 'creates a shift_event' do
        expect { form.save }.to change { ShiftEvent.count }.by(1)
      end

      it 'creates a volunteer' do
        expect { form.save }.to change { Volunteer.count }.by(1)
      end
    end
  end

  it 'should save time in the local time zone' do
    form = create :check_in_form, day: '1 January, 2016', time: '4:30 PM'

    expect(ShiftEvent.first.occurred_at).to eq \
      Time.zone.local(2016, 1, 1, 16, 30)
  end
end
