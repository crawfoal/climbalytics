module FormHelper
  def setup_user(user)
    user.name ||= User::Name.new
    user.address ||= Address.new
    user
  end
end
