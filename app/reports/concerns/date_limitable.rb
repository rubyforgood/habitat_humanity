require 'active_support/concern'

##
# Contains an interface to limit the date range of a report.
#
module DateLimitable
  extend ActiveSupport::Concern

  included do
    attr_reader :begin_date, :end_date
  end

  class_methods do
    ##
    # Returns a signatures report containing data for the week ending on the
    # specified end date
    #
    # @param ending [#to_date]  End date for week
    # @return [DateLimitable]
    def for_week(ending:)
      end_date   = ending.to_date
      begin_date = end_date - 6.days
      new_with_date_range(begin_date, end_date)
    end

    ##
    # Returns a new DateLimitable containing data for the specified date range
    #
    # @param  beginning [#to_date]  Start of date range
    # @param  ending [#to_date]     End of date range
    # @return [DateLimitable]
    def for_date_range(beginning:, ending:)
      new_with_date_range(beginning, ending)
    end

    private

    ##
    # Returns a new DateLimitable with the given date range
    def new_with_date_range(begin_date, end_date)
      report = new
      report.set_date_range(begin_date, end_date)
      report
    end
  end

  ##
  # Sets the begin/end date ivars to the specified begin/end dates
  def set_date_range(begin_date, end_date)
    @begin_date = begin_date.to_date
    @end_date   = end_date.to_date
  end
end
