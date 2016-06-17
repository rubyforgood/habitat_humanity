require 'rails_helper'

RSpec.describe SignaturesReport, type: :report do
  let(:end_date_string) { '2016-05-09' }
  let(:end_date) { Date.parse(end_date_string) }
  let(:begin_date) { end_date - 6 }
  let(:report) { SignaturesReport.for_week(ending: end_date) }

  it 'instantiates a report based on the end of the week' do
    expect(report.begin).to eq(begin_date)
    expect(report.end).to eq(end_date)
    expect(report.end - report.begin).to eq(6)
  end

  it 'generates a hash for the covered days' do
    expect(report.data.keys).to eq([*begin_date..end_date])
  end
end
