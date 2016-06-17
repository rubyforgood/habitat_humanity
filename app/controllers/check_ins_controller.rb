class CheckInsController < ApplicationController
  expose(:check_in_form) { CheckInForm.new check_in_params }

  private

  def check_in_params
    params.fetch(:check_in, {}).permit(
      :name, :email, :work_site_id, :signature
    )
  end
end
