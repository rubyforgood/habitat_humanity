require 'active_support/concern'
require 'csv'
require 'date_input'

##
# Contains an interface to limit the date range of a report.
#
module WeeklyReportable
  extend ActiveSupport::Concern

  included do
    # TODO: this should probably change to non-reseved words
    # TODO: doesn't fit with the module name (allows for more control than just
    #       weekly reports); change module name?
    attr_reader :begin, :end
  end

  class_methods do
    ##
    # Returns a signatures report containing data for the week ending on the
    # specified end date
    #
    # @param ending [String,Date]
    #   Date or String parseable as a Date
    #
    # @return [SignaturesReport]
    def for_week(ending:)
      end_date   = Date.parse ending.to_s
      begin_date = end_date - 6
      new_with_date_range(begin_date, end_date)
    end

    def for_date_range(beginning:, ending:)
      new_with_date_range(beginning, ending)
    end

    private

    def new_with_date_range(begin_date, end_date)
      report = new
      report.set_date_range(begin_date, end_date)
      report
    end
  end

  def set_date_range(begin_date, end_date)
    @begin = Date.parse begin_date.to_s
    @end   = Date.parse end_date.to_s
  end
end
