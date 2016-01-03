module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_filter :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |user_params| user_params.permit(:email, :password) }
    devise_parameter_sanitizer.for(:account_update) do |user_params|
      user_params.permit(:email,
                         :password,
                         :password_confirmation,
                         :current_password,
                         name_attributes: [:first, :last],
                         address_attributes: [:line1, :line2, :city, :state_id, :zip])
    end
  end

end

DeviseController.send :include, DevisePermittedParameters
