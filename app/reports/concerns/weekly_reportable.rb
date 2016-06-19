require 'active_support/concern'
require 'csv'

module WeeklyReportable
  extend ActiveSupport::Concern

  included do
    attr_reader :begin, :end
  end

  class_methods do
    ##
    # @param ending [String,Date]
    #   Date or String parseable as a Date
    #
    # @return [SignaturesReport]
    def for_week(ending:)
      end_date = Date.parse(ending.to_s)
      begin_date = end_date - 6
      new(begin_date, end_date)
    end
  end

  ##
  # @param begin_date [String,Date]
  #   Date or String parseable as a Date
  # @param end_date [String,Date]
  #   Date or String parseable as a Date
  def initialize(begin_date, end_date)
    @begin = Date.parse(begin_date.to_s)
    @end = Date.parse(end_date.to_s)
  end

  def csv_filename
    "#{self.class.name.demodulize.underscore.dasherize} #{@begin.iso8601} to #{@end.iso8601}.csv"
  end
end
