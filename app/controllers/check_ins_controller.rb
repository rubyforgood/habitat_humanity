class CheckInsController < ApplicationController
  expose(:check_in_form) { CheckInForm.new check_in_params }
  expose(:work_sites)    { WorkSite.all }

  def create
    if check_in_form.valid?
      check_in_form.save

      redirect_to new_check_in_path(current_work_site_params),
        notice: 'Check in has been saved.'
    else
      render 'new', notice: 'Check in is not valid.'
    end
  end

  private

  def check_in_params
    params.fetch(:check_in_form, {}).permit(
      :name, :email, :work_site_id, :day, :time, :action, :signature
    )
  end

  def current_work_site_params
    {check_in_form: {work_site_id: check_in_form.work_site_id}}
  end
end
