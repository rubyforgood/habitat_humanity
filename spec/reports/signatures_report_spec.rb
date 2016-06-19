require 'rails_helper'

RSpec.describe SignaturesReport, type: :report do
  let(:end_date_string) { '2016-05-09' }
  let(:end_date) { Date.parse(end_date_string) }
  let(:begin_date) { end_date - 6 }
  let(:report) { SignaturesReport.for_week(ending: end_date) }

  it 'instantiates a report based on the end of the week' do
    # TODO Should this be refactored now that this helper logic has been
    # extracted into WeeklyReportable?
    expect(report.begin).to eq(begin_date)
    expect(report.end).to eq(end_date)
    expect(report.end - report.begin).to eq(6)
  end

  it 'generates CSV' do
    # TODO Should this be refactored now that this helper logic has been
    # extracted into WeeklyReportable?

    # Create a shift inside our weekly report period
    FactoryGirl.create(:shift, :full, day: begin_date + 1)
    round_trip = CSV.parse(report.to_csv)
    expect(round_trip.size).to be > 1
    expect(round_trip.first.size)
      .to eq SignaturesReport::JOINED_HEADERS.size
  end
end
