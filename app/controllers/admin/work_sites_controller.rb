module Admin
  class WorkSitesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = WorkSite.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   WorkSite.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def activate
      resource = WorkSite.find params[:work_site_id]
      resource.activate!
      flash[:success] = "#{resource.address} successfully activated"
      redirect_to admin_work_sites_path
    end

    def deactivate
      resource = WorkSite.find params[:work_site_id]
      resource.deactivate!
      flash[:success] = "#{resource.address} successfully deactivated"
      redirect_to admin_work_sites_path
    end
  end
end
