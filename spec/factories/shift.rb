FactoryGirl.define do
  factory :shift do
    day { Faker::Date.backward(23) }
    work_site
    volunteer { Volunteer.first || FactoryGirl.create(:volunteer) }

    trait :full do
      after(:build) do |shift|
        day_begin = shift.day.beginning_of_day
        day_end = shift.day.end_of_day

        ShiftEvent::ACTIONS.keys.zip(
          Array.new(4) { Faker::Time.between(day_begin, day_end) }.sort
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
