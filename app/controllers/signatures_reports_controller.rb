require 'date_input' # handles parsing of user-inputted date strings

class SignaturesReportsController < ApplicationController
  before_action :authenticate_user!
  expose(:work_sites) do
    WorkSite.where(active: true).select('id, address').order(:address).map do |ws|
      [ws.address, ws.id]
    end
  end

  layout 'admin/non_administrate'

  def init_vars
    @sites        = [['All Sites', 0]] + work_sites
    @end_date     = parse_date params[:end_date],   default: Time.zone.today
    @begin_date   = parse_date params[:begin_date], default: (@end_date - 6.days)
    @site_id      = ((params[:site] || {})[:id] || 0).to_i

    addr_cell     = @sites.find { |c| c[1] == @site_id } || ['unknown', 0]
    @site_addr    = addr_cell[0]
  end

  def show
    init_vars

    if valid_date_range?
      @shift_events = shift_events_for_range(@begin_date, @end_date, @site_id)
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
