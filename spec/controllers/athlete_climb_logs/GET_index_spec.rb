require 'rails_helper'
require 'shared_examples/index_request'

describe AthleteClimbLogsController do
  describe 'GET #index' do
    let(:athlete_climb_logs) { create_list(:athlete_climb_log, 3) }

    context 'for a logged in user' do
      login_user
      it_behaves_like 'a basic index request', :athlete_climb_logs
    end
  end
end
