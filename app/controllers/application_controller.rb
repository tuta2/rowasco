class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper
  before_action :authorized!
  before_action :restrict_landing_page
  helper_method :current_user
  helper_method :logged_in?

  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "You are not authorized to perform this action❗"
    redirect_back(fallback_location: root_path)
  end

  def layout_by_resource
    if logged_in?
      'user_layout'
    else
      'application'
    end
  end
end
