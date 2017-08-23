FactoryGirl.define do
  # TODO: this factory is invalid sometimes, see issue #122
  factory :check_in_form do
    transient do
      signature_required? { CheckInForm::SHIFT_ACTIONS.include? action }
    end

    name { Faker::Name.name }
    email { Faker::Internet.email }
    work_site_id { WorkSite.first || FactoryGirl.create(:work_site).id }
    action { ShiftEvent::ACTIONS.keys.sample }
    minor { [true, false].sample }
    signature { signature_required? ? 'signature' : nil }
  end
end
