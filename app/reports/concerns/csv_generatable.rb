require 'active_support/concern'
require 'csv_report_generator'

##
# Contains an interface to generate CSV reports
#
module CSVGeneratable
  extend ActiveSupport::Concern

  ##
  # == Interface Requirements ==

  ##
  # Returns a string filename "<something>.csv"
  def csv_filename
    raise NotImplementedError
  end

  ##
  # Returns list of method names valid for the records returned w/ `#pull_join`
  def csv_headers
    raise NotImplementedError
  end

  ##
  # Returns an enumerable of records to include in the generated report
  def pull_join
    raise NotImplementedError
  end

  ##
  # Initializes the report generator for the given headers
  def initialize_generator
    @csv_report_generator ||= CSVReportGenerator.new(method_names: csv_headers)
  end

  ##
  # Generates a CSV using the records retrieved with `#pull_join` and the
  # methods retrieved with `#csv_headers` (using the method names as headers)
  #
  # @return [String]  The generated CSV for the configured begin/end date
  def to_csv
    initialize_generator
    csv_report_generator.records = pull_join
    csv_report_generator.generate_report
  end

  private

  attr_reader :csv_report_generator
end
