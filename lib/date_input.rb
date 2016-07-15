# Provides an easy interface for working with user-inputted dates, similar to the
# Hash#fetch syntax. It can parse user input for a date or, if invalid, return a
# default date.
#
# This allows the code for handling unexpected date inputs to live in one place.
#
# ## Example
#
#     > input = DateInput.new 'invalid', default: Date.new(1990)
#     > input.to_date
#     => #<Date: 1990-01-01 ((2447893j,0s,0n),+0s,2299161j)>
#
class DateInput
  # Creates a new DateInput object
  #
  # @param input [String]  The user-inputted date
  # @param default         The default value to use in case `input`
  #                        is invalid
  # @return [DateInput]  A new DateInput object
  def initialize(input, default:)
    @input = input
    @default = default
  end

  # Returns the parsed date from the user input or, if the input is invalid, the
  # given default value
  def to_date
    Date.parse input
  rescue TypeError, ArgumentError
    default
  end

  private

  attr_reader :input, :default
end
