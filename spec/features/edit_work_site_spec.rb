require 'rails_helper'

feature 'Admin can edit work sites' do
  context 'from the collection view' do
    # Given I am a signed-in admin on the work site admin index page
    # When I click "Deactivate" on a collection item
    # Then the work site is set to inactive
    scenario 'deactivate work site' do
      create(:work_site, active: true)
      sign_in_as_admin
      visit admin_work_sites_path
      click_link 'Deactivate'

      expect(current_path).to eq admin_work_sites_path
      expect(page).not_to have_content 'Deactivate'
      expect(page).to have_content 'successfully deactivated'
      expect(WorkSite.active.any?).to be false
    end

    # Given I am a signed-in admin on the work site admin index page
    # When I click "Activate" on a collection item
    # Then the work site is set to active
    scenario 'activate work site' do
      create(:work_site, active: false)
      sign_in_as_admin
      visit admin_work_sites_path
      click_link 'Activate'

      expect(current_path).to eq admin_work_sites_path
      expect(page).not_to have_content 'Activate'
      expect(page).to have_content 'successfully activated'
      expect(WorkSite.exists?(active: false)).to be false
    end
  end

  context 'from the show view' do
    xscenario 'deactivate work site' do
      create(:work_site, active: true)
      sign_in_as_admin
      visit admin_work_site_path(subject)
      click_button 'Deactivate'

      expect(current_path).to eq admin_work_sites_path
      expect(page).not_to have_content 'Deactivate'
      expect(page).to have_content 'successfully deactivated'
      expect(WorkSite.active.any?).to be false
    end

    xscenario 'activate work site' do
      create(:work_site, active: true)
      sign_in_as_admin
      visit admin_work_site_path(subject)
      click_button 'Deactivate'

      expect(current_path).to eq admin_work_sites_path
      expect(page).not_to have_content 'Activate'
      expect(page).to have_content 'successfully activated'
      expect(WorkSite.exists?(active: false)).to be false
    end

    xscenario 'delete work site' do
      create(:work_site)
      sign_in_as_admin
      visit admin_work_site_path(subject)
      click_button 'Delete'

      expect(current_path).to eq admin_work_sites_path
      expect(page).to have_content 'successfully deleted'
      expect(WorkSite.any?).to be false
    end
  end
end
