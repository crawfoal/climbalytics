class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #-----------------------------------------------------------------------------
  # Devise
  #-----------------------------------------------------------------------------
  before_action :authenticate_user_account!

  #-----------------------------------------------------------------------------
  # Pundit
  #-----------------------------------------------------------------------------
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected
  def current_user
    current_user_account.user || current_user_account.create_user
  end
  def user_signed_in?
    user_account_signed_in?
  end
  helper_method :current_user, :user_signed_in?

  private

  #-----------------------------------------------------------------------------
  # Devise
  #-----------------------------------------------------------------------------
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  #-----------------------------------------------------------------------------
  # Pundit
  #-----------------------------------------------------------------------------
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

end
