require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/show_request'

describe AthleteClimbLogsController do
  describe "GET #show" do
    let(:athlete_climb_log) { create(:athlete_climb_log) }
    let(:http_request_proc) { Proc.new { get :show, id: athlete_climb_log.id } }

    context 'for a logged in user' do

      context 'without a role of athlete' do
        login_user

        it_behaves_like 'a request for a unauthorized action', :http_request_proc
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        context 'who owns the athlete_climb_log' do
          let(:athlete_climb_log) { create(:athlete_climb_log, athlete_story: current_user.athlete_story) }

          it_behaves_like 'a basic show request', :athlete_climb_log
        end

        context 'who does not own the athlete_climb_log' do
          it_behaves_like 'a request for a unauthorized action', :http_request_proc
        end

      end

    end

  end
end
