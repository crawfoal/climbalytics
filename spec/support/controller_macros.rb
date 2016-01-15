module ControllerMacros
  def login_user(factory_name = nil)
    user = nil
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(factory_name || :user)
      sign_in user
    end
    let(:current_user) {user}
  end
end
