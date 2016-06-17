FactoryGirl.define do
  factory :volunteer do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    shift
  end
end
