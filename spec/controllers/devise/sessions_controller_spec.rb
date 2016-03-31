require 'rails_helper'

RSpec.describe Devise::SessionsController, '#create' do
  context 'with invalid credentials' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user_account]
      user_account = create(:user_account)
      invalid_password = attributes_for(:user_account)[:password] + '_modified'

      post :create, user_account: {email: user_account.email, password: invalid_password}
    end

    it 'redirects back to the landing page' do
      expect(response).to redirect_to root_path
    end

    it 'renders a flash' do
      expect(flash[:alert]).to include 'Invalid email or password.'
    end
  end
end
