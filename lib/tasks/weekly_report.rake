
desc 'Send the weekly report via Heroku Scheduler'

task weekly_report: :environment do
  mail = ReportMailer.weekly_email
  if Time.now.in_time_zone.monday?
    mail.deliver_now
  else
    Rails.logger.info "not sending weekly report because it's not Monday"
  end
end
