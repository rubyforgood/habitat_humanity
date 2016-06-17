require 'rails_helper'

RSpec.describe 'Checking in at a worksite', type: :feature do
  it 'saves the shift event' do
    worksite = WorkSite.create! address: '101 Main Street'

    visit new_check_in_path
    fill_in 'Name', with: 'Sam Jones'
    fill_in 'Email', with: 'my@email.com'
    select '101 Main Street', from: 'Work site'
    fill_in 'Signature', with: 'abcdefg'
    click_button 'Check In'

    expect(Shift.count).to eq(1)
    expect(ShiftEvent.count).to eq(1)
    expect(Volunteer.count).to eq(1)
  end
end
