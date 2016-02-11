require 'rails_helper'

describe HomeController do
  describe 'GET #show' do

    context 'when the user is logged in' do

      context 'and the user has a current role defined' do
        login_user(:athlete_user)

        it 'renders their dashboard view' do
          get :show
          expect(response).to render_template "home/dashboards/#{current_user.current_role}"
        end
      end

      context 'and the user does not have a current role defined' do
        login_user

        before :each do
          get :show
        end

        it 'redirects to their edit profile page' do
          expect(response).to redirect_to edit_user_registration_path
        end
        it 'displays a flash message' do
          expect(flash[:warning]).to eq "Select a role to start using the site."
        end
      end

    end

    context 'when the user is not logged in' do

      before :each do
        get :show
      end

      it 'renders the homepage view' do
        expect(response).to render_template :homepage
      end
    end

  end
end
