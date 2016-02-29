module FormHelper
  def setup_user(user)
    user.name ||= User::Name.new
    user
  end
end
