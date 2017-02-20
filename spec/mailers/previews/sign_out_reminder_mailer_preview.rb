# Preview all emails at http://localhost:3000/rails/mailers/sign_out_reminder_mailer
class SignOutReminderMailerPreview < ActionMailer::Preview
  def any_from_today
    SignOutReminderMailer.end_of_day_reminders.first
  end
end
