
desc 'Send the weekly report via Heroku Scheduler'

task weekly_report: :environment do
  mail = ReportMailer.weekly_email
  mail.deliver_now
end
