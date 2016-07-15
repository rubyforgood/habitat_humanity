require 'concerns/weekly_reportable'
require 'csv_report_generator'

class SignaturesReport
  include WeeklyReportable

  def initialize
    @csv_report_generator = CSVReportGenerator.new method_names: JOINED_HEADERS
  end

  ##
  # @private
  #
  # @return [ActiveRecord::Relation]
  def pull_join
    start_time = begin_date.in_time_zone.beginning_of_day
    end_time   = end_date.in_time_zone.end_of_day

    ShiftEvent
      .includes(shift: [:work_site, :volunteer])
      .where(occurred_at: start_time..end_time)
      .order(:occurred_at)
  end

  ##
  # @return [String]  The generated CSV for the configured begin/end date
  def to_csv
    csv_report_generator.records = pull_join
    csv_report_generator.generate_report
  end

  ##
  # @return [String]  The filename for the generated CSV
  def csv_filename
    "#{report_title} #{begin_date.iso8601} to #{end_date.iso8601}.csv"
  end

  JOINED_HEADERS = %i(address
                      day
                      occurred_at
                      action
                      volunteer_name
                      volunteer_email
                      minor
                      signature).freeze

  private

  attr_reader :csv_report_generator

  # Returns the report title to be used in the csv filename
  def report_title
    self.class.name.demodulize.underscore.dasherize
  end
end
