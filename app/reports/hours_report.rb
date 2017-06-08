require 'concerns/date_limitable'
require 'concerns/csv_generatable'

class HoursReport
  include DateLimitable
  include CSVGeneratable

  JOINED_HEADERS = %i(address
                      day
                      volunteer_name
                      volunteer_email
                      minor
                      shift_start_time
                      shift_end_time
                      duration
                      duration_without_breaks
                      signature_in
                      signature_out).freeze

  ##
  # Required for CSVGeneratable
  def csv_headers
    JOINED_HEADERS
  end

  ##
  # @private
  #
  # @return [ActiveRecord::Relation]
  def pull_join
    Shift
      .includes(:work_site, :volunteer, :shift_events)
      .completed
      .where(day: begin_date..end_date)
      .order(:day)
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
