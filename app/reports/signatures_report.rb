class SignaturesReport
  attr_reader :begin, :end

  def initialize(begin_date, end_date)
    @begin = Date.parse(begin_date.to_s)
    @end = Date.parse(end_date.to_s)
  end

  ##
  # @param ending [String,Date]
  #
  # @return [SignaturesReport]
  def self.for_week(ending:)
    end_date = Date.parse(ending.to_s)
    begin_date = end_date - 6
    new(begin_date, end_date)
  end

  ##
  # @return [Hash{Date=>Array<ActiveRecord::Base>}]
  def data
    # Might not want to include a date entry for days without any data
    out = (self.begin..self.end).map { |date| [date, []] }.to_h

    # Get the *actual* data
    out.merge(data_pull.to_a.group_by(&:day))
  end

  ##
  # @private
  #
  # @return [ActiveRecord::Relation]
  def data_pull
    Shift.where(
      'day BETWEEN :begin_date AND :end_date',
      begin_date: @begin, end_date: @end
    ).order(:day)
  end
end
