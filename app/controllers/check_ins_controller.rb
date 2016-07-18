class CheckInsController < ApplicationController
  expose(:check_in_form) { CheckInForm.new check_in_params }
  expose(:work_sites)    { WorkSite.active }

  def create
    if check_in_form.valid?
      check_in_form.save

      flash[:success] = 'Check in has been saved.'
      redirect_to new_check_in_path(current_work_site_params)
    else
      flash[:error] = 'Check in is not valid.'
      render 'new'
    end
  end

  private

  def check_in_params
    params.fetch(:check_in_form, {}).permit(
      :name, :email, :work_site_id, :day, :time, :action, :signature, :minor
    )
  end

  def current_work_site_params
    { check_in_form: { work_site_id: check_in_form.work_site_id } }
  end
end
