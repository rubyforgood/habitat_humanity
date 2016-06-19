require_relative 'concerns/weekly_reportable_controller'

class SignaturesReportController < ApplicationController
  REPORT_CLASS = SignaturesReport
  include WeeklyReportableController
end
