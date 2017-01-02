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
  def events_in_range(start_time, end_time)
    ShiftEvent
      .includes(shift: [:work_site, :volunteer])
      .where(occurred_at: start_time..end_time,
             work_sites:  { active: true })
      .order(:occurred_at)
  end

  def events_in_range_at_site(start_time, end_time, site_id)
    ShiftEvent
      .joins(shift: [:work_site, :volunteer])
      .where(occurred_at: start_time..end_time,
             shifts:      { work_site_id:     site_id })
      .includes(shift: [:work_site, :volunteer])
      .order(:occurred_at)
  end

  def pull_join(site_id = 0)
    start_time = begin_date.in_time_zone.beginning_of_day
    end_time   = end_date.in_time_zone.end_of_day

    return events_in_range(start_time, end_time) if 0 == site_id

    events_in_range_at_site(start_time, end_time, site_id)
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
