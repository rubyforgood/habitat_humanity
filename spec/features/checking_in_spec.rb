require 'rails_helper'

RSpec.describe 'Checking in at a worksite', type: :feature do
  it 'saves the shift event' do
    work_site = WorkSite.create! address: '101 Main Street'

    visit root_path
    fill_in 'Name', with: 'Sam Jones'
    fill_in 'Email', with: 'my@email.com'
    select work_site.address, from: 'Work site'
    select 'Start Shift', from: 'Action'
    fill_in 'Signature', with: 'abcdefg'
    click_button 'Check In'

    expect(Shift.count).to eq(1)
    expect(ShiftEvent.count).to eq(1)
    expect(Volunteer.count).to eq(1)
    expect(ShiftEvent.first.action).to eq('start_shift')
  end
end
