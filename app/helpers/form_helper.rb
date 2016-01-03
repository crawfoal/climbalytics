module FormHelper
  def setup_user(user)
    user.build_name unless user.name
    user.build_address unless user.address
    user
  end
end
