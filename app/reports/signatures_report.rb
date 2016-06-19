require_relative 'concerns/weekly_reportable'

class SignaturesReport
  include WeeklyReportable

  ##
  # @private
  #
  # @return [ActiveRecord::Relation]
  def pull_join
    ShiftEvent
      .select(*ATTRIBUTE_HEADERS)
      .joins(shift: [:work_site, :volunteer])
      .where(
        'day BETWEEN :begin_date AND :end_date',
        begin_date: @begin, end_date: @end
      ).order(:occurred_at)
  end

  ATTRIBUTE_HEADERS = %w(address
                         day
                         occurred_at
                         action
                         name
                         email
                         signature).freeze

  JOINED_HEADERS = ATTRIBUTE_HEADERS

  def to_csv
    CSV.generate(write_headers: false, headers: self.class::JOINED_HEADERS) do |csv|
      # Don't want to rely on `write_headers: true` since we want still
      # header row in the CSV file even when there is no data.
      csv << self.class::JOINED_HEADERS
      pull_join.each { |record| csv << self.class::JOINED_HEADERS.map(&record.method(:send)) }
    end
  end
end
