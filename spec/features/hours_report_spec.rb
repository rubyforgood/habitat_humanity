require 'rails_helper'

feature 'Admin can download hours report', type: :feature do
  scenario 'when all is well' do
    sign_in_as_admin
    visit hours_report_path(format: :csv)

    expect(current_path).to eq '/admin/hours_report'

    expect(page.status_code).to eq 200
    expect(page.response_headers['Content-Type']).to eq 'text/csv'
  end

  scenario 'when a volunteer forgot to sign back in from a break' do
    FactoryGirl.create :shift, :missing_break_return, day: Time.zone.yesterday
    sign_in_as_admin

    visit hours_report_path(format: :csv)

    expect(page.status_code).to eq 200
  end
end
