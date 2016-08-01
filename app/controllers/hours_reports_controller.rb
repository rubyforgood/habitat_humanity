class HoursReportsController < ApplicationController
  before_action :authenticate_user!

  layout 'admin/non_administrate'

  def show
    end_date = Date.parse(params.fetch(:end_date, Time.zone.today.to_s))
    @report = HoursReport.for_week(ending: end_date)

    respond_to do |format|
      format.csv { send_data @report.to_csv, filename: @report.csv_filename }
    end
  end
end
