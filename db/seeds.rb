
require 'factory_girl'

10.times do
  FactoryGirl.create(:work_site)
  shift = FactoryGirl.create(:shift)
  FactoryGirl.create(:shift_event, shift: shift)
end
