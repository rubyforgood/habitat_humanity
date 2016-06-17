class CheckInsController < ApplicationController
  expose(:check_in_form) { CheckInForm.new check_in_params }
  expose(:work_site) { WorkSite.find params.fetch(:work_site_id) }

  before_action :set_work_site_id

  def create
    if check_in_form.valid?
      check_in_form.save

      redirect_to work_site_path(work_site), notice: "Check in has been saved."
    else
      render 'new', notice: "Check in is not valid"
    end
  end

  private

  def check_in_params
    params.fetch(:check_in_form, {}).permit(
      :name, :email, :signature
    )
  end

  def set_work_site_id
    check_in_form.work_site_id = params.fetch(:work_site_id)
  end
end
