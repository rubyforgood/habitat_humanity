require_relative 'concerns/weekly_reportable'

class HoursReport
  include WeeklyReportable

  ##
  # @private
  #
  # @return [ActiveRecord::Relation]
  def pull_join
    # TODO Have yet to get a Railsy query working here
    Shift
      .select(*ATTRIBUTE_HEADERS)
      .joins(:work_site, :volunteer, :shift_events)
      .where(day: @begin..@end)
      .order(:day)
      .select(&:complete?)
  end

  ATTRIBUTE_HEADERS = %w(address
                         day
                         name).freeze

  JOINED_HEADERS = (ATTRIBUTE_HEADERS + %w(
                         shift_start_time
                         shift_end_time
                         duration
                         duration_without_breaks)).freeze

  def to_csv
    CSV.generate(write_headers: false, headers: self.class::JOINED_HEADERS) do |csv|
      # Don't want to rely on `write_headers: true` since we want still
      # header row in the CSV file even when there is no data.
      csv << self.class::JOINED_HEADERS
      pull_join.each { |record| csv << self.class::JOINED_HEADERS.map(&record.method(:send)) }
    end
  end
end
