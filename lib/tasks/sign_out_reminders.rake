desc 'Send sign-out reminders via Heroku Scheduler'

task sign_out_reminders: :environment do
  if Time.new.in_time_zone.hour == 18
    SignOutReminderMailer.send_end_of_day_reminders
  else
    Rails.logger.info "not sending sign-out reminders because it's not 6-7 PM"
  end
end
