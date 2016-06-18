FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Hipster.words(4).join('.') }

    trait :admin do
      roles_mask 1
    end

    trait :site_supervisor do
      roles_mask 2
    end

  end
end
