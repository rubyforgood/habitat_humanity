require 'rails_helper'

feature 'Admins can view the volunteer signature report', type: :feature do
  # Given I am a signed-in site admin
  # When I visit the volunteer signature report page
  # Then I see a list of volunteer actions for the past week
  scenario 'when an admin visits the page'
  
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