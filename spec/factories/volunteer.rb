FactoryGirl.define do
  factory :volunteer do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
  end

  trait :with_shifts do
    transient do
      shift_count 2
    end

    after(:build) do |volunteer, evaluator|
      evaluator.shift_count.times do
        create(:shift, volunteer: volunteer)
      end
    end
  end
end
