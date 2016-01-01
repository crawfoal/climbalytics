module FormHelper
  def setup_user(user)
    user.name ||= User::Name.new
    user.build_address unless user.address
    user
  end
end
