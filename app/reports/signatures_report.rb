require_relative 'concerns/weekly_reportable'

class SignaturesReport
  include WeeklyReportable

  ##
  # @private
  #
  # @return [ActiveRecord::Relation]
  def pull_join
    ShiftEvent
      .includes(shift: [:work_site, :volunteer])
      .where(
        'occurred_at BETWEEN :begin_date AND :end_date',
        begin_date: @begin, end_date: @end
      ).order(:occurred_at)
  end

  JOINED_HEADERS = %i(address
                      day
                      occurred_at
                      action
                      volunteer_name
                      volunteer_email
                      minor
                      signature).freeze

  def to_csv
    CSV.generate(write_headers: false, headers: self.class::JOINED_HEADERS) do |csv|
      # Don't want to rely on `write_headers: true` since we want still
      # header row in the CSV file even when there is no data.
      csv << JOINED_HEADERS
      pull_join.each do |record|
        csv << JOINED_HEADERS.map { |field| record.public_send(field) }
      end
    end
  end
end
