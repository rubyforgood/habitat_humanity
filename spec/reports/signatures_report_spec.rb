require 'rails_helper'

RSpec.describe SignaturesReport, type: :report do
  it 'generates a report based on the end of the week' do
    report = SignaturesReport.for_week(ending: '2016-05-09')
    expect(report.end).to eq(Date.parse('2016-05-09'))
    expect(report.end - report.begin).to eq(7)
  end
end
