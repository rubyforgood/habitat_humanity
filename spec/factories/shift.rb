FactoryGirl.define do
  factory :shift do
    work_site

    sequence :day do |n|
      Time.zone.today - n.days
    end
    volunteer { Volunteer.first || FactoryGirl.create(:volunteer) }

    transient do
      day_begin { day.beginning_of_day }
      day_end { day.end_of_day }
      shift_event_actions []
      shift_event_actions_with_times do
        times = Array.new(shift_event_actions.length) do
          Faker::Time.between(day_begin, day_end)
        end
        shift_event_actions.zip(times.sort)
      end
    end

    after :build do |shift, evaluator|
      evaluator.shift_event_actions_with_times.each do |(action, occurred_at)|
        create(
          :shift_event,
          action: action, occurred_at: occurred_at, shift: shift,
        )
      end
    end

    trait :full do
      transient do
        shift_event_actions ShiftEvent::ACTIONS.keys
      end
    end

    trait :missing_break_return do
      transient do
        shift_event_actions(ShiftEvent::ACTIONS.keys - ['end_break'])
      end
    end
  end
end
