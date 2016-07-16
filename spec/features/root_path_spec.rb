require 'rails_helper'

feature 'Root path directs user to the appropriate page' do
  # Given I am a signed-in user
  # When I visit the root path
  # Then I should see an admin dashboard with a link to the check in form
  scenario 'when the user is logged in' do
    sign_in_as_admin

    visit '/'
    expect(page).to have_link 'Sign out'
    expect(page).to have_link 'Check in form'
  end

  # Given I am a site visitor
  # When I visit the root path
  # Then I should see the check in form
  scenario 'when the guest is not logged in' do
    visit '/'
    expect(page).not_to have_link 'Sign out'
    expect(page).to have_css '#new_check_in_form'
  end
end
