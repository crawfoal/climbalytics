require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe AthleteClimbLogsController do
  describe 'GET #new' do

    context 'for a logged in user' do

      context 'without a role of athlete' do
        login_user

        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { get :new } }
        end
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        before :each do
          get :new
        end

        it 'builds a new athlete_climb_log' do
          expect(assigns(:athlete_climb_log)).to be_a_new(AthleteClimbLog)
        end

        it 'renders the :new template' do
          expect(response).to render_template :new
        end

      end

    end

  end
end
