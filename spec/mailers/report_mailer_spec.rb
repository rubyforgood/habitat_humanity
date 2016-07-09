require 'rails_helper'

RSpec.describe ReportMailer, type: :mailer do
  describe 'weekly_email' do
    before do
      ReportRecipient.first || ReportRecipient.create(email: 'from@example.com')
    end

    let(:mail) { ReportMailer.weekly_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Weekly Report')
      expect(mail.to).to eq(ReportRecipient.pluck(:email))
      expect(mail.from).to eq(['communications@habitat-nola.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('This is your weekly report.')
    end
  end
end
