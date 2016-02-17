require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/new_request'

describe SetterClimbLogsController do
  describe 'GET #new' do
    let(:http_request_proc) { Proc.new { get :new } }

    context 'for a logged in non-setter' do
      login_user
      it_behaves_like 'a request for a unauthorized action', :http_request_proc
    end

    context 'for a logged in setter' do
      login_user(:setter)

      it_behaves_like 'a basic new request', :setter_climb_log
    end

  end
end
