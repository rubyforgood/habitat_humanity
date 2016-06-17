class CheckInsController < ApplicationController
  expose(:check_in_form) { CheckInForm.new check_in_params }

  def create
    if check_in_form.valid?
      check_in_form.save

      redirect_to new_check_in_path, notice: "Check in has been saved."
    else
      render 'new', notice: "Check in is not valid"
    end
  end

  private

  def check_in_params
    params.fetch(:check_in_form, {}).permit(
      :name, :email, :work_site_id, :signature
    )
  end
end
