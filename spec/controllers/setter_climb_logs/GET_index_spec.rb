require 'rails_helper'
require 'shared_examples/index_request'

describe SetterClimbLogsController do
  describe 'GET #index' do
    let(:setter_climb_logs) { create_list(:setter_climb_log, 3) }

    context 'for a logged in user' do
      login_user
      it_behaves_like 'a basic index request', :setter_climb_logs
    end
  end
end
