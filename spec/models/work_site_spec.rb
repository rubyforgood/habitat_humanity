require 'rails_helper'

describe WorkSite, type: :model do
  describe '#destroy' do
    it 'deletes a work site record' do
      create(:work_site).destroy
      expect(WorkSite.any?).to be false
    end
    it 'deletes all associated shifts' do
      create(:work_site, :with_shifts).destroy

      expect(WorkSite.any?).to be false
      expect(Shift.any?).to be false
    end
  end
end
