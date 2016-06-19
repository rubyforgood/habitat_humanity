require_relative 'concerns/weekly_reportable'

class SignaturesReport
  include WeeklyReportable

  ##
  # @private
  #
  # @return [ActiveRecord::Relation]
  def pull_join
    ShiftEvent
      .joins(shift: [:work_site, :volunteer])
      .where(
        'day BETWEEN :begin_date AND :end_date',
        begin_date: @begin, end_date: @end
      )
      .order(:occurred_at)
  end

  JOINED_HEADERS = %w(address
                      day
                      occurred_at
                      action
                      name
                      email
                      signature).freeze
end
