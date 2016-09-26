require 'rails_helper'

RSpec.describe HoursReport, type: :report do
  let(:end_date_string) { '2016-05-09' }
  let(:end_date) { Date.parse(end_date_string) }
  let(:begin_date) { end_date - 6.days }
  let(:report) { HoursReport.for_week(ending: end_date) }

  it 'instantiates a report based on the end of the week' do
    # TODO: Should this be refactored now that this helper logic has been
    # extracted into WeeklyReportable?
    expect(report.begin_date).to eq(begin_date)
    expect(report.end_date).to eq(end_date)
    expect(report.end_date - report.begin_date).to eq(6)
  end

  it 'generates CSV' do
    # Create a shift inside our weekly report period
    FactoryGirl.create(:shift, :full, day: begin_date + 1.day)
    rows = CSV.parse(report.to_csv)
    expect(rows.size).to be > 1
    expect(rows.first.size)
      .to eq HoursReport::JOINED_HEADERS.size
  end

  describe '#to_csv' do
    before do
      FactoryGirl.create(:work_site, address: '101 Broadway')
      FactoryGirl.create(:shift, :full,
                         day: begin_date + 1.day,
                         work_site: WorkSite.first)
    end
    let(:rows) { CSV.parse(report.to_csv) }

    it "each row includes a work_site's address" do
      address_index = HoursReport::JOINED_HEADERS
                      .index(:address)
      addresses = rows.map { |row| row[address_index] }
      addresses.each_with_index do |address, i|
        expect(address)
          .not_to be_blank, "address #{i} blank (#{address.inspect})"
      end
    end

    it "each row includes a volunteer's email address" do
      email_index = HoursReport::JOINED_HEADERS
                    .index(:volunteer_email)
      emails = rows.map { |row| row[email_index] }
      emails.each_with_index do |email, i|
        expect(email)
          .not_to be_blank, "email #{i} blank (#{email.inspect})"
      end
    end

    it 'reports an error if a volunteer forgot to sign back in from a break' do
      FactoryGirl.create :shift, :missing_break_return, day: end_date
      duration_index = HoursReport::JOINED_HEADERS.index(:duration)
      durations = rows.map { |row| row[duration_index] }
      expect(durations).to include 'Error: incomplete break'
    end
  end
end
