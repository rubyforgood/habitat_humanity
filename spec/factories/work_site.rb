FactoryGirl.define do
  factory :work_site do
    address { "#{Faker::Address.street_address}, #{Faker::Address.city}" }
    
    trait :with_shifts do
      after(:build) do |site|
        3.times { create(:shift, work_site: site) }
      end
    end
  end
end
