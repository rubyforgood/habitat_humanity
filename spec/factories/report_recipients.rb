FactoryGirl.define do
  factory :report_recipient do
    email { Faker::Internet.email }
  end
end
