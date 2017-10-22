require 'rails_helper'

RSpec.describe CheckInsController, type: :request do
  describe '#create' do
    context 'starting a new shift' do
      let(:work_site) { FactoryGirl.create(:work_site) }

      let(:check_in_form_params) do
        {
          'name' => 'Test User',
          'email' => 'tester@example.org',
          'day' => '05 Jun, 2017',
          'time' => '09:30 AM',
          'work_site_id' => work_site.id,
          'action' => 'start_shift',
          'minor' => false,
          'signature' => 'totally a valid image file'
        }
      end

      it 'adds a new shift' do
        expect do
          post '/check_ins', check_in_form: check_in_form_params
        end.to change { Shift.count }.by(1)
      end

      it 'adds a new shift event' do
        expect do
          post '/check_ins', check_in_form: check_in_form_params
        end.to change { ShiftEvent.count }.by(1)
      end

      it 'adds a new volunteer' do
        expect do
          post '/check_ins', check_in_form: check_in_form_params
        end.to change { Volunteer.count }.by(1)
      end
    end
  end
end
