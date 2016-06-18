require 'rails_helper'

RSpec.describe User, type: :model do
  context 'roles' do
    it 'include being an admin' do
      u = create(:user, :admin)
      expect(u.has_role?(:admin)).to be true
    end
    it 'include being a site supervisor' do
      u = create(:user, :site_supervisor)
      expect(u.has_role?(:site_supervisor)).to be true
    end
  end
end
