
require 'factory_girl_rails'

10.times do
  FactoryGirl.create(:work_site)
  FactoryGirl.create(:shift, :full)
end
