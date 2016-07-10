require 'date_input' # handles parsing of user-inputted date strings

class SignaturesReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @end_date     = parse_date params[:end_date],   default: Time.zone.today
    @begin_date   = parse_date params[:begin_date], default: (@end_date - 6.days)

    @shift_events = SignaturesReport
                    .for_date_range(beginning: @begin_date, ending: @end_date)
                    .pull_join
  end

  private

  def parse_date(input_str, default:)
    input = DateInput.new(input_str, default: default.to_date)
    input.to_date
  end
end
