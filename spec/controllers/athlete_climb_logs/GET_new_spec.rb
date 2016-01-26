require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/new_request'

describe AthleteClimbLogsController do
  describe 'GET #new' do
    let(:http_request_proc) { proc { get :new } }

    context 'for a logged in user' do

      context 'without a role of athlete' do
        login_user

        it_behaves_like 'a request for a unauthorized action', :http_request_proc
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)
        it_behaves_like 'a basic new request', :athlete_climb_log
        describe 'associated models' do
          before :each do
            http_request_proc.call
          end
          it 'builds a new associated climb model' do
            expect(assigns(:athlete_climb_log).climb).to be_a_new(Climb)
          end
          it 'builds a new associated climb_sesh model' do
            expect(assigns(:athlete_climb_log).climb_seshes.size).to be 1
          end
        end
      end

    end

  end
end
