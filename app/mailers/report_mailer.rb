class ReportMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.weekly_email.subject
  #
  def weekly_email
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end
end
