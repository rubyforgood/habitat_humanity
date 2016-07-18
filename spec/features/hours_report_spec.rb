require 'rails_helper'

feature 'Admin can download hours report', :feature do
  scenario 'as an admin' do
    sign_in_as_admin
    visit hours_report_path(format: :csv)

    expect(current_path).to eq '/admin/hours_report'

    expect(page.status_code).to eq 200
    expect(page.response_headers['Content-Type']).to eq 'text/csv'
  end
end
