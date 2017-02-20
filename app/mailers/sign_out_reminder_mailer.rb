class SignOutReminderMailer < ApplicationMailer
  default from: ENV['WEEKLY_REPORT_FROM'] || 'communications@habitat-nola.org'

  def self.end_of_day_reminders
    shifts = Shift.incomplete.where(day: Time.zone.today)

    shifts.map do |shift|
      end_of_day_reminder(shift)
    end
  end

  def self.send_end_of_day_reminders
    end_of_day_reminders.each(&:deliver_now)
  end

  def end_of_day_reminder(shift)
    @shift = shift
    @volunteer = shift.volunteer
    @today = Time.zone.today
    mail(to: @volunteer.email, subject: 'Remember to sign out!')
  end
end
