FactoryGirl.define do
  factory :shift do
    day { Faker::Date.forward(23) }
    work_site
    volunteer { Volunteer.first || FactoryGirl.create(:volunteer) }
  end
end
