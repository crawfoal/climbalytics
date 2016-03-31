class CurrentRolesController < ApplicationController
  def update
    new_role = params[:user][:current_role]
    current_user.update(current_role: new_role) if current_user.has_role? new_role
    redirect_to root_path
  end
end
