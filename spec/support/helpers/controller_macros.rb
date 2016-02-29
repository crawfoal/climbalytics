module ControllerMacros
  def login_user(factory_name = :user, *options)
    user = nil
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(factory_name, *options)
      sign_in user.user_account
    end
    let(:current_user) {user}
  end
end
