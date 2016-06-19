require_relative 'concerns/weekly_reportable'

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

  JOINED_HEADERS = %w(address
                      day
                      name
                      email
                      shift_start_time
                      shift_end_time
                      duration
                      duration_without_breaks).freeze

  # TODO
  # rubocop: disable Metrics/MethodLength
  def to_csv
    CSV.generate(write_headers: false, headers: JOINED_HEADERS) do |csv|
      # Don't want to rely on `write_headers: true` since we want still
      # header row in the CSV file even when there is no data.
      csv << JOINED_HEADERS
      pull_join.each do |record|
        csv << [
          record.work_site.address,
          record.day,
          record.volunteer.name,
          record.volunteer.email,
          record.shift_start_time,
          record.shift_end_time,
          record.duration,
          record.duration_without_breaks,
        ]
      end
    end
  end
end
