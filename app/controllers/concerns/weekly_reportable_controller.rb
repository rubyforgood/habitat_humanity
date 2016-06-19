require 'active_support/concern'

module WeeklyReportableController
  include ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  def index
    end_date = Date.parse(params.fetch(:end_date, Time.zone.today.to_s))
    @report = self.class::REPORT_CLASS.for_week(ending: end_date)

    respond_to do |format|
      format.csv { send_data @report.to_csv, filename: @report.csv_filename }
    end
  end
end
