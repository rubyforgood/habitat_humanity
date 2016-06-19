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

  JOINED_HEADERS = %w(address
                      day
                      occurred_at
                      action
                      name
                      email
                      signature).freeze

  # TODO
  # rubocop: disable Metrics/AbcSize, Metrics/MethodLength
  def to_csv
    CSV.generate(write_headers: false, headers: self.class::JOINED_HEADERS) do |csv|
      # Don't want to rely on `write_headers: true` since we want still
      # header row in the CSV file even when there is no data.
      csv << JOINED_HEADERS
      pull_join.each do |record|
        csv << [
          record.shift.work_site.address,
          record.shift.day,
          record.occurred_at,
          record.action,
          record.shift.volunteer.name,
          record.shift.volunteer.email,
          record.signature
        ]
      end
    end
  end
end
