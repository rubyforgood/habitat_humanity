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
      redirect_back fallback_location: admin_work_sites_path
    end

    def deactivate
      resource = WorkSite.find params[:work_site_id]
      resource.deactivate!
      flash[:success] = "#{resource.address} successfully deactivated"
      redirect_back fallback_location: admin_work_sites_path
    end

    private

    ##
    # Redirects the browser to the page that issued the request (the referrer)
    # if possible, otherwise redirects to the provided default fallback
    # location.
    #
    # The referrer information is pulled from the HTTP `Referer` (sic) header on
    # the request. This is an optional header and its presence on the request is
    # subject to browser security settings and user preferences. If the request
    # is missing this header, the `fallback_location` will be used.
    #
    # Note: This functionality is included in Rails 5, so this method can be
    #       removed.
    #
    def redirect_back(fallback_location: root_url, **args)
      referer = request.headers['Referer']
      if referer
        redirect_to referer, **args
      else
        redirect_to fallback_location, **args
      end
    end
  end
end
