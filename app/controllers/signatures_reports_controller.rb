require 'date_input' # handles parsing of user-inputted date strings

class SignaturesReportsController < ApplicationController
  before_action :authenticate_user!

  layout 'admin/non_administrate'

  def init_vars
    @end_date     = parse_date params[:end_date],   default: Time.zone.today
    @begin_date   = parse_date params[:begin_date], default: (@end_date - 6.days)

    site_id       = WorkSite.site_id_selected(params)
    @sites        = WorkSite.select_box_input
    @site_addr    = WorkSite.addr_for_id(@sites, site_id)

    site_id
  end

  def show
    site_id = init_vars

    if valid_date_range?
      @shift_events = shift_events_for_range(@begin_date, @end_date, site_id)
    else
      flash[:error] = 'Invalid date range. Begin date must precede the end date.'
      @shift_events = []
    end
  end

  private

  def shift_events_for_range(begin_date, end_date, site_id)
    SignaturesReport
      .for_date_range(beginning: begin_date, ending: end_date)
      .pull_join(site_id)
  end

  def valid_date_range?
    @begin_date < @end_date
  end

  def parse_date(input_str, default:)
    input = DateInput.new(input_str, default: default.to_date)
    input.to_date
  end
end
