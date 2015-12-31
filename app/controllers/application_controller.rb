class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |user| user.permit(:email, :password) }
    devise_parameter_sanitizer.for(:account_update) { |user| user.permit(:email, :password, :current_password, name_attributes: [:first, :last]) }
  end

end
