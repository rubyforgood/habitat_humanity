require 'rails_helper'

RSpec.describe ReportMailer, type: :mailer do
  describe 'weekly_email' do
    let(:recipient) { create(:report_recipient) }
    let(:mail) { ReportMailer.weekly_email(recipient) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Weekly Report')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('This is your weekly report.')
    end
  end
end
