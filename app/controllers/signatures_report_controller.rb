class SignaturesReportController < Admin::ApplicationController
  before_action :authenticate_user!

  def index
    end_date = Date.parse(params.fetch(:end_date, Time.zone.today.to_s))
    begin_date = end_date - 6
    @report = SignaturesReport.for_week(ending: end_date)

    respond_to do |format|
      format.csv do
        send_data @report.to_csv,
                  filename: "signatures-report #{begin_date.iso8601} to " + "#{end_date.iso8601}.csv"
      end
    end
  end
end
