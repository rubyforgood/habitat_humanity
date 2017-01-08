require 'rails_helper'

feature 'Admins can view the volunteer signature report', type: :feature do
  before { Timecop.freeze Time.zone.parse('July 24, 1969, 16:50:35 UTC') }
  after { Timecop.return }

  # Given I am a signed-in site admin
  # When I visit the volunteer signature report page
  # Then I see a list of volunteer actions for the past week
  scenario 'when an admin visits the page' do
    generate_entries dates: [Time.zone.today, 5.days.ago, 1.month.ago]

    sign_in_as_admin
    visit signatures_report_path
    expect(current_path).to eq '/admin/signatures_report'
    expect(page).to have_content 'Volunteer Signatures'

    expect(all('.entry').count).to eq(2)
  end

  # Given I am a signed-in site admin
  # When I visit the volunteer signature report page
  # Then I see a list of information on shift events
  scenario 'when an admin sees shift information' do
    generate_entries dates: [Time.zone.today]
    shift_event = ShiftEvent.last

    sign_in_as_admin
    visit signatures_report_path

    within('.entry') do
      expect(page).to have_content(shift_event.address)
      expect(page).to have_content(shift_event.occurred_at.to_date)
      expect(page).to have_content(shift_event.occurred_at.strftime('%I:%M%p'))
      expect(page).to have_content(shift_event.action)
      expect(page).to have_content(shift_event.volunteer_name)
      expect(page).to have_content(shift_event.volunteer_email)
      expect(page).to have_css('img')
    end
  end

  # Given I am a signed-in site admin
  # When I set the start and end dates to valid values
  # Then I see a list of volunteer actions for the given date range
  scenario 'when the start and end dates are specified' do
    generate_entries(dates: [25.days.ago, 50.days.ago])
    start_date = 40.days.ago.to_date
    end_date = 20.days.ago.to_date

    # the date that should show up with the displayed record
    formatted_valid_date = 25.days.ago.to_date.to_s

    sign_in_as_admin
    visit signatures_report_path
    within 'form#set_date_range' do
      fill_in 'Begin date', with: start_date.to_s
      fill_in 'End date',   with: end_date.to_s
    end
    click_button 'Generate'

    expect(page).to have_content formatted_valid_date
    expect(all('.entry').count).to eq(1)
  end

  # Given I am a signed-in site admin
  # And there are no signed-in events for the past week
  # When I visit the volunteer signature report page
  # Then I see a notice that no data is found for the date range
  scenario 'when there is no data for the selected range' do
    sign_in_as_admin
    visit signatures_report_path

    expect(page).not_to have_css '.entry'
    expect(page).not_to have_content 'Work Site'
    expect(page).to have_content 'No data for this date range'
  end

  # Given I am a signed-in site admin
  # When I set the end date to precede the start date
  # Then I see an error message
  # Then I see a notice that no data is found for the date range
  scenario 'when the end date precedes the start date' do
    start_date = 20.days.ago.to_date
    end_date = 40.days.ago.to_date

    sign_in_as_admin
    visit signatures_report_path
    within 'form#set_date_range' do
      fill_in 'Begin date', with: start_date.to_s
      fill_in 'End date',   with: end_date.to_s
    end
    click_button 'Generate'

    expect(page).to have_css '.alert-error'
    expect(page).to have_content 'Invalid date range'
    expect(page).to have_content 'No data for this date range'
  end

  # Given I am a signed-in site admin
  # When I set the end date in the future
  # Then I see a list of volunteer actions for the start date through today
  scenario 'when the end date is in the future' do
    generate_entries(dates: [6.days.ago, 2.days.ago])
    start_date = 4.days.ago.to_date
    end_date = 5.days.from_now.to_date

    sign_in_as_admin
    visit signatures_report_path
    within 'form#set_date_range' do
      fill_in 'Begin date', with: start_date.to_s
      fill_in 'End date',   with: end_date.to_s
    end
    click_button 'Generate'

    expect(all('.entry').count).to eq(1)
  end

  # Given I am a signed-in site admin
  # When I set the start date in the future
  # Then I see a notice that no data is found for the date range
  scenario 'when the start date is in the future' do
    generate_entries(dates: [6.days.ago, 5.days.ago])
    start_date = 5.days.from_now.to_date
    end_date = 10.days.from_now.to_date

    sign_in_as_admin
    visit signatures_report_path
    within 'form#set_date_range' do
      fill_in 'Begin date', with: start_date.to_s
      fill_in 'End date',   with: end_date.to_s
    end
    click_button 'Generate'

    expect(page).to have_content 'No data for this date range'
  end

  # Given I am not signed in as an admin
  # When I visit the volunteer signature report page
  # Then I am redirected to the sign in page
  scenario 'when the visitor is not an admin' do
    visit signatures_report_path
    expect(current_path).to eq new_user_session_path
  end

  # Given I am signed in as an admin
  # and given an signature image wider than 650px
  # when I visit the volunteer signature report page
  # I see an image that is no wider than 650px
  scenario 'when image width exceeds 650px, it rescales' do
    generate_entries dates: [Time.zone.today]

    sign_in_as_admin
    visit signatures_report_path
    img_width = find(:css, 'img')['width']
    expect(img_width).to eq('650')
  end
end
