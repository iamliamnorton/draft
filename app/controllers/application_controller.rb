class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= super || Guest.new
  end

  def authenticate_admin_user!
    redirect_to root_path unless current_user.admin?
  end
end
