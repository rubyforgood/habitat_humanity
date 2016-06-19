require_relative 'concerns/weekly_reportable'

class HoursReport
  include WeeklyReportable

  ##
  # @private
  #
  # @return [ActiveRecord::Relation]
  def pull_join
    # query goes here
  end

  JOINED_HEADERS = %w().freeze
end
