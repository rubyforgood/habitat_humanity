require 'rails_helper'

RSpec.describe SignaturesReport, type: :report do
  it 'generates a report based on the end of the week' do
    end_date_string = '2016-05-09'
    end_date = Date.parse(end_date_string)
    report = SignaturesReport.for_week(ending: end_date)

    expect(report.begin).to eq(end_date - 6)
    expect(report.end).to eq(end_date)
    expect(report.end - report.begin).to eq(6)
  end
end
