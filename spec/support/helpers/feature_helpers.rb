module FeatureHelpers
  # Creates n shift events. If dates is specified, it assigns the listed dates
  # to the created events.
  def generate_entries(count: nil, dates: [])
    n = count || dates.count
    n.times do |i|
      date = dates[i].to_date || Faker::Date.before(1.week.ago)
      shift = create(:shift, day: date)
      create(:shift_event, shift: shift)
    end
  end

  # Creates a user account and signs the user in. Used for setup for
  # administrative specs.
  def sign_in_as_admin
    create(:user, email: 'admin@example.com', password: 'password')
    visit '/users/sign_in'
    within 'form#new_user' do
      fill_in 'Email', with: 'admin@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
  end
end
