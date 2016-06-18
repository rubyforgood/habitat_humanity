FactoryGirl.define do
  factory :shift do
    day { Faker::Date.forward(23) }
    work_site
    volunteer { Volunteer.first || FactoryGirl.create(:volunteer) }

    trait :full do
      after(:build) do |shift|
        ShiftEvent::ACTIONS.zip(
          Array.new(4) { Faker::Time.between(shift.day.to_datetime, shift.day.succ.to_datetime) }.sort
        ).each do |(action, occurred_at)|
          create(
            :shift_event,
            action: action, occurred_at: occurred_at, shift: shift,
          )
        end
      end
    end
  end
end
