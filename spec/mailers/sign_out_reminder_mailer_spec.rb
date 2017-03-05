require 'rails_helper'

class SignOutReminderMailerTest < ActionMailer::TestCase
  describe '#end_of_day_reminder' do
    let(:shift) { FactoryGirl.create(:shift, :incomplete) }
    let(:mail) { SignOutReminderMailer.end_of_day_reminder(shift) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Remember to sign out!')
      expect(mail.to).to eq [shift.volunteer.email]
      expect(mail.from).to eq ['communications@habitat-nola.org']
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('please remember to sign out')
    end

    it 'includes a link to the sign-in form' do
      expect(mail.body.encoded).to match('/check_ins/new')
    end
  end
end
