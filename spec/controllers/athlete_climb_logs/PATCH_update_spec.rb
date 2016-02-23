require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/update_request'

describe AthleteClimbLogsController do
  describe "PATCH #update" do
    context 'for a logged in user' do
      let(:athlete_climb_log) { create(:athlete_climb_log) }
      let(:http_request_proc) { Proc.new { patch :update, id: athlete_climb_log.id, athlete_climb_log: attributes_for(:athlete_climb_log) } }

      context 'without a role of athlete' do
        login_user

        it_behaves_like 'a request for a unauthorized action', :http_request_proc
      end

      context 'with a role of athlete' do
        login_user(:athlete)

        context 'who owns the athlete_climb_log' do

          let(:athlete_climb_log) { create(:athlete_climb_log, athlete_story: current_user.athlete_story) }

          it_behaves_like 'a basic update request', :athlete_climb_log, {quality_rating: 5, note: 'Updated note.'}, {notice: 'Athlete climb log was successfully updated.'}
        end

        context 'who does not own the athlete_climb_log' do
          it_behaves_like 'a request for a unauthorized action', :http_request_proc
        end

      end

    end
  end
end
