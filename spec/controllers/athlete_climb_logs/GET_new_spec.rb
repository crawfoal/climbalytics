require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/new_request'

describe AthleteClimbLogsController do
  describe 'GET #new' do
    let(:http_request_proc) { Proc.new { get :new } }

    context 'for a logged in user' do

      context 'without a role of athlete' do
        login_user

        it_behaves_like 'a request for a unauthorized action', :http_request_proc
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)
        it_behaves_like 'a basic new request', :athlete_climb_log
      end

    end

  end
end
