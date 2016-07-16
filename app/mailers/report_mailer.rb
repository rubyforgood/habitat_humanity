class ReportMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.weekly_email.subject
  #
  default to: proc { ReportRecipient.pluck(:email) },
          from: ENV['WEEKLY_REPORT_FROM'] || 'communications@habitat-nola.org'

  def weekly_email
    @end_date = Date.tomorrow
    @report = HoursReport.for_week(ending: @end_date)
    @report.pull_join

    attachments['WeeklyReport.csv'] = @report.to_csv
    email = mail(subject: 'Weekly Report')
    raise 'there are no recipients' if email[:to].addresses.empty?
    email
  end
end
