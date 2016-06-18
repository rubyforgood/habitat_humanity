module Admin
  class SignaturesReportController < Admin::ApplicationController
    def index
      end_date = params.fetch(:end_date, Date.today)
      super
      @report = SignaturesReport.for_week(ending: end_date)

      respond_to do |format|
        format.csv { render inline: @report.to_csv }
      end
    end
  end
end
