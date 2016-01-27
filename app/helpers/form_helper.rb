module FormHelper
  def setup_user(user)
    user.name ||= User::Name.new
    user.address ||= Address.new
    user
  end

  def resource_name
    :user
  end
  def resource
    @resource ||= User.new
  end
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
