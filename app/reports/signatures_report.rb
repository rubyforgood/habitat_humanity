class SignaturesReport
  attr_reader :begin, :end

  def initialize(begin_date, end_date)
    @begin = Date.parse(begin_date.to_s)
    @end = Date.parse(end_date.to_s)
  end

  def self.for_week(ending:)
    end_date = Date.parse(ending.to_s)
    begin_date = end_date - 7
    new(begin_date, end_date)
  end
end
