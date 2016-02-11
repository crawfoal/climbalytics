class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    if not user_signed_in?
      render 'homepage'
    elsif current_user.current_role
      render "home/dashboards/#{current_user.current_role}"
    else
      flash.keep
      flash[:warning] = 'Select a role to start using the site.'
      redirect_to edit_user_registration_path
    end
  end
end
