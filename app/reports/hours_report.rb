require 'concerns/weekly_reportable'
require 'csv_report_generator'

class HoursReport
  include WeeklyReportable

  ##
  # @private
  #
  # @return [ActiveRecord::Relation]
  def pull_join
    # TODO: Have yet to get a Railsy query working here
    Shift
      .includes(:work_site, :volunteer, :shift_events)
      .where(day: @begin..@end)
      .order(:day)
      .select(&:complete?)
  end

  JOINED_HEADERS = %i(address
                      day
                      volunteer_name
                      volunteer_email
                      minor
                      shift_start_time
                      shift_end_time
                      duration
                      duration_without_breaks).freeze

  ##
  # @return [String]  The generated CSV for the configured begin/end date
  def to_csv
    csv_report_generator = CSVReportGenerator.new method_names: JOINED_HEADERS,
                                                  records: pull_join
    csv_report_generator.generate_report
  end

  ##
  # @return [String]  The filename for the generated CSV
  def csv_filename
    "#{report_title} #{begin_date.iso8601} to #{end_date.iso8601}.csv"
  end

  private

  # Returns the report title to be used in the csv filename
  def report_title
    self.class.name.demodulize.underscore.dasherize
  end
end
