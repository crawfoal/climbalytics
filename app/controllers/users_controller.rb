class UsersController < ApplicationController
  before_action :set_user, only: [:update]

  def edit
  end

  def update
    update_roles
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: 'Profile was successfully updated.' }
        format.json { render nothing: true, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  protected
  def set_user
    @user = current_user
  end

  def update_roles
    role_params[:_roles].try(:each) do |role|
      err_msg = current_user.add_role role unless current_user.has_role? role
      flash[:alert] = err_msg unless err_msg.blank? if err_msg
    end
  end

  def user_params
    params.require(:user).permit(
      name_attributes: [:id, :first, :last],
      current_location_attributes: [:id, :latitude, :longitude]
    )
  end
  def role_params
    params.require(:user).permit(_roles: [])
  end
end
