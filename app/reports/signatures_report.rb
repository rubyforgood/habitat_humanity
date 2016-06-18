require 'csv'

class SignaturesReport
  attr_reader :begin, :end

  ##
  # @param begin_date [String,Date]
  #   Date or String parseable as a Date
  # @param end_date [String,Date]
  #   Date or String parseable as a Date
  def initialize(begin_date, end_date)
    @begin = Date.parse(begin_date.to_s)
    @end = Date.parse(end_date.to_s)
  end

  ##
  # @param ending [String,Date]
  #   Date or String parseable as a Date
  #
  # @return [SignaturesReport]
  def self.for_week(ending:)
    end_date = Date.parse(ending.to_s)
    begin_date = end_date - 6
    new(begin_date, end_date)
  end

  ##
  # @private
  #
  # @return [ActiveRecord::Relation]
  def pull_shifts
    Shift
      .where(
        'day BETWEEN :begin_date AND :end_date',
        begin_date: @begin, end_date: @end
      )
      .order(:day)
  end

  def pull_join
    ShiftEvent
      .joins(shift: [:work_site, :volunteer])
      .where(
        'day BETWEEN :begin_date AND :end_date',
        begin_date: @begin, end_date: @end
      )
      .order(:occurred_at)
  end

  JOINED_HEADERS = ['address',
                    'day',
                    'occurred_at',
                    'action',
                    'name',
                    'email'].freeze

  def to_csv
    join = pull_join
    CSV.generate(write_headers: true, headers: JOINED_HEADERS) do |csv|
      join.each { |record| csv << record.attributes }
    end
  end
end
