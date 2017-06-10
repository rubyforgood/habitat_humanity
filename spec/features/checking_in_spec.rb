require 'rails_helper'

RSpec.describe 'Checking in at a worksite', type: :feature do
  it 'saves the shift event' do
    work_site = create :work_site

    visit root_path
    fill_in 'Name', with: 'Sam Jones'
    fill_in 'Email', with: 'my@email.com'
    select work_site.address, from: 'Work site'
    fill_in 'Day', with: '1 January, 2016'
    fill_in 'pick-a-time', with: '4:30 PM'
    select 'Start Shift', from: 'Action'
    find('#check_in_form_signature', visible: false).set 'my signature'
    click_button 'Save'

    expect(page).to have_content 'Check in has been saved.'
  end

  # Given the main form has just loaded
  # Then I do not see the lolliclock widget
  scenario 'hides the lolliclock widget when the form loads', js: true do
    skip 'PhantomJS 2+ required' unless ENV['RAILS_SPEC_JS']

    visit root_path

    expect { find '.lolliclock-popover' }
      .to raise_error Capybara::ElementNotFound
  end

  # Given the main form has just loaded
  # When I click the time input field
  # Then I see the lolliclock widget
  scenario 'activates lolliclock when time input is focused', js: true do
    skip 'PhantomJS 2+ required' unless ENV['RAILS_SPEC_JS']

    visit root_path
    page.execute_script('document.getElementById("pick-a-time").click()')

    clock = find '.lolliclock-popover'
    expect(clock).to be_visible
  end
end
