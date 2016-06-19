require_relative 'concerns/weekly_reportable_controller'

class HoursReportController < ApplicationController
  REPORT_CLASS = HoursReport
  include WeeklyReportableController
end
