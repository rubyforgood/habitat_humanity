require 'concerns/date_limitable'
require 'concerns/csv_generatable'

class SignaturesReport
  include DateLimitable
  include CSVGeneratable

  JOINED_HEADERS = %i(address
                      day
                      occurred_at
                      action
                      volunteer_name
                      volunteer_email
                      minor
                      signature).freeze

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
    start_time = begin_date.in_time_zone.beginning_of_day
    end_time   = end_date.in_time_zone.end_of_day

    ShiftEvent
      .includes(shift: [:work_site, :volunteer])
      .where(occurred_at: start_time..end_time)
      .order(:occurred_at)
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
