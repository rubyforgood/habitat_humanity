namespace :db do
  desc 'Creates a new admin user. Requires the ADMIN_EMAIL and ADMIN_PASSWORD environment variables to be set in production.'
  task initialize_admin: :environment do
    email    = Rails.application.secrets.admin_email
    password = Rails.application.secrets.admin_password
    puts "Initializing admin #{email}..."

    user = User.new(email: email,
                    password: password,
                    password_confirmation: password)

    if user.save
      puts 'Successfully created admin!'
    else
      puts 'Failure: could not initialize admin for the following reasons:'
      user.errors.messages.each do |category, errors|
        errors.each { |error| puts "- #{category}: #{error}" }
      end
    end
  end
end
