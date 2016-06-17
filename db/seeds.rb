
require 'factory_girl'

10.times do
  FactoryGirl.create(:work_site)
  FactoryGirl.create(:shift)
end
