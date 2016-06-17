FactoryGirl.define do
  factory :work_site do
    address { "#{Faker::Address.street_address}, #{Faker::Address.city}" }
  end
end
