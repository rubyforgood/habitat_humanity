# Generates a CSV report given a set of headers and records. Each record must
# respond to the methods represented by the headers.
class CSVReportGenerator
  attr_accessor :records

  # Initializes a new CSVReportGenerator object
  #
  # @return [CSVReportGenerator]
  def initialize(method_names:, records: [])
    @records = records
    @headers = method_names
    @method_names = method_names
  end

  # Generates a report with the given configuration
  #
  # @return [CSV]
  def generate_report
    CSV.generate(write_headers: false, headers: headers) do |csv|
      # Don't want to rely on `write_headers: true` since we want still
      # header row in the CSV file even when there is no data.
      csv << headers
      records.each do |record|
        csv << method_names.map { |method_name| record.public_send method_name }
      end
    end
  end

  private

  attr_reader :headers, :method_names
end
