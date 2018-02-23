require 'csv_report_generator'

describe CSVReportGenerator do
  class FakeRecord
    FIELDS = %i[address
                day
                occurred_at
                action
                volunteer_name
                volunteer_email
                minor
                signature].freeze

    attr_accessor(*FIELDS)

    class << self
      def list_methods
        fields.map(&:to_s)
      end

      private

      def fields
        FIELDS
      end
    end
  end

  it 'should allow records to be set after creation' do
    generator = CSVReportGenerator.new method_names: FakeRecord.list_methods
    generator.records = [FakeRecord.new] * 10
    expect(generator.records.count).to eq 10
  end

  it 'should generate a CSV with the given headers' do
    method_names = FakeRecord.list_methods
    generator = CSVReportGenerator.new method_names: method_names,
                                       records: [FakeRecord.new] * 10

    report = generator.generate_report
    expect(report).to include method_names.join ','
    # TODO: test the actual CSV content
  end
end
