class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def home
    if current_user.current_role
      render "users/dashboards/#{current_user.current_role}"
    else
      flash.keep
      flash[:warning] = 'Select a role to start using the site.'
      redirect_to edit_user_registration_path
    end
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

end
