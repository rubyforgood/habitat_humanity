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
    @report = SignaturesReport.for_week(ending: @end_date)
    @report.pull_join

    attachments['WeeklyReport.csv'] = @report.to_csv
    mail(subject: 'Weekly Report')
  end
end
