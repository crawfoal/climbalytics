class HomeController < ApplicationController
  skip_before_action :authenticate_user_account!

  def show
    if not user_signed_in?
      render 'homepage'
    elsif current_user.current_role
      redirect_to action: :show, controller: "#{current_user.current_role}/dashboards"
    else
      flash.keep
      flash[:warning] = 'Select a role to start using the site.'
      redirect_to edit_user_path
    end
  end
end
