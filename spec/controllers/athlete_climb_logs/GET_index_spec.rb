require 'rails_helper'
require 'shared_examples/index_request'

describe AthleteClimbLogsController do
  describe 'GET #index' do
    context 'for a logged in athlete' do
      login_user(:athlete) # the logs don't belong to the user, so if we add some authorization to the index action, this spec will need to be modified
      let(:athlete_climb_logs) { create_list(:athlete_climb_log, 3, athlete_story: current_user.athlete_story) }
      it_behaves_like 'a basic index request', :athlete_climb_logs

      it "only shows records that belong to the current user" do
        get :index
        assigns[:athlete_climb_logs].each do |alog|
          expect(alog.athlete_story).to be == current_user.athlete_story
        end
      end
    end
  end
end
