require 'rails_helper'

RSpec.describe 'Checking in at a worksite', type: :feature do
  it 'saves the shift event' do
    shift_count = Shift.count
    volunteer_count = Volunteer.count
    shift_event_count = ShiftEvent.count
    work_site = WorkSite.create! address: '101 Main Street'

    visit root_path
    click_link work_site.address

    fill_in 'Name', with: 'Sam Jones'
    fill_in 'Email', with: 'my@email.com'
    find(:css, '#check_in_form_signature', visible: false).set 'my signature'
    click_button 'Save'

    expect(Shift.count).to eq(shift_count + 1)
    expect(ShiftEvent.count).to eq(shift_event_count + 1)
    expect(Volunteer.count).to eq(volunteer_count + 1)
    expect(ShiftEvent.first.action).to eq('start_shift')
  end
end
