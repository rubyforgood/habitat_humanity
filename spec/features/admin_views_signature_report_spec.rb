require 'rails_helper'

feature 'Admins can view the volunteer signature report', type: :feature do
  # Creates n shift events. If dates is specified, it assigns the listed dates
  # to the created events.
  def generate_entries(n, dates: [])
    n.times do |i|
      date = dates[i] || Faker::Time.between(1.minute.ago, 1.week.ago)
      create(:shift_event, occurred_at: date)
    end
  end
  
  def sign_in_as_admin
    create(:user, email: 'admin@example.com', password: 'password')
    visit '/users/sign_in'
    within 'form#new_user' do
      fill_in 'Email', with: 'admin@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
  end
  
  before { Timecop.freeze Time.local(1592, 3, 14, 6, 53) }
  after { Timecop.return }
  
  # Given I am a signed-in site admin
  # When I visit the volunteer signature report page
  # Then I see a list of volunteer actions for the past week
  scenario 'when an admin visits the page' do
    generate_entries(3, dates: [1.second.ago, 5.days.ago, 1.month.ago]) # test outer limits
    
    sign_in_as_admin
    visit '/signatures_reports'
    expect(current_path).to eq '/signatures_reports'
    expect(page).to have_content 'Volunteer Signatures'
    
    expect(all('.entry').count).to eq(2)
  end
  
  # Given I am a signed-in site admin
  # When I set the start and end dates to valid values
  # Then I see a list of volunteer actions for the given date range
  scenario 'when the start and end dates are specified'
  
  # Given I am a signed-in site admin
  # When I set the end date to precede the start date
  # Then I see an error message
  # And I see a list of volunteer actions for the past week
  scenario 'when the end date precedes the start date'
  
  # Given I am a signed-in site admin
  # When I set the end date in the future
  # Then I see an error message
  # Then I see a list of volunteer actions for the start date through today
  scenario 'when the end date is in the future'
  
  # Given I am a signed-in site admin
  # When I set the start date in the future
  # Then I see an error message
  # And I see a list of volunteer actions for the past week
  scenario 'when the start date is in the future'
  
  # Given I am not signed in as an admin
  # When I visit the volunteer signature report page
  # Then I am redirected to the sign in page
  scenario 'when the visitor is not an admin'
end