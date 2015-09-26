class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :fullname, :avatar) }
  end

  def admin_user
    flash[:error] = "You have to be an admin to do that!" unless current_user.admin? || current_user.username == "dave4506"
    redirect_to(root_url) unless current_user.admin? || current_user.username == "dave4506"
  end

  def user?
    flash[:error] = "You have to be an user to do that!" unless user_signed_in?
    redirect_to(root_url)  unless user_signed_in?
  end
end
