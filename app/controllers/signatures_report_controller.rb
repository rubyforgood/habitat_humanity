require_relative 'concerns/weekly_reportable_controller'

class SignaturesReportController < Admin::ApplicationController
  REPORT_CLASS = SignaturesReport
  include WeeklyReportableController
end
