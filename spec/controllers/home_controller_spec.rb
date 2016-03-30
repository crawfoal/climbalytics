require 'rails_helper'

describe HomeController do
  describe 'GET #show' do
    context 'when the user is not logged in' do
      it 'renders the homepage view' do
        get :show
        expect(response).to render_template :homepage
      end
    end

    context 'when a user with no roles is logged in' do
      login_user
      before :each do
        get :show
      end

      it 'redirects to their edit profile page' do
        expect(response).to redirect_to edit_user_path
      end
      it 'displays a flash message' do
        expect(flash[:warning]).to eq "Select a role to start using the site."
      end
    end

    context 'when an athlete is logged in' do
      login_user(:athlete)

      it 'renders their dashboard view' do
        get :show
        expect(response).to redirect_to athlete_dashboard_path
      end
    end
  end
end
