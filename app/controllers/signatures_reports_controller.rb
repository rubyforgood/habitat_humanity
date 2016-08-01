require 'date_input' # handles parsing of user-inputted date strings

class SignaturesReportsController < ApplicationController
  before_action :authenticate_user!

  layout 'admin/non_administrate'

  def show
    @end_date     = parse_date params[:end_date],   default: Time.zone.today
    @begin_date   = parse_date params[:begin_date], default: (@end_date - 6.days)

    if valid_date_range?
      @shift_events = shift_events_for_range(@begin_date, @end_date)
    else
      flash[:error] = 'Invalid date range. Begin date must precede the end date.'
      @shift_events = []
    end
  end

  private

  def shift_events_for_range(begin_date, end_date)
    SignaturesReport
      .for_date_range(beginning: begin_date, ending: end_date)
      .pull_join
  end

  def valid_date_range?
    @begin_date < @end_date
  end

  def parse_date(input_str, default:)
    input = DateInput.new(input_str, default: default.to_date)
    input.to_date
  end
end
