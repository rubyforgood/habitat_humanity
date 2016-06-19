class SignaturesReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @end_date = Date.parse(params.fetch(:end_date, Time.zone.today.to_s))
    @begin_date = @end_date - 6
    @shift_events = SignaturesReport.for_week(ending: @end_date).pull_join
  end
end
