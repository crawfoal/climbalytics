require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe AthleteClimbLogsController do
  describe 'POST #create' do
    let(:athlete_climb_log_attribs) { attributes_for(:athlete_climb_log) }

    context 'for a logged in user' do

      context 'without a role of athlete' do
        login_user

        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { post :create, {athlete_climb_log: athlete_climb_log_attribs} } }
        end
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        it 'creates a new athlete_climb_log' do
          expect { post :create, {athlete_climb_log: athlete_climb_log_attribs} }.to change {AthleteClimbLog.count}.by(1)
        end
        it 'associates the log with the athlete' do
          expect { post :create, {athlete_climb_log: athlete_climb_log_attribs} }.to change {current_user.athlete_story.athlete_climb_logs.count}.by(1)
        end
        it 'redirects to :show' do
          post :create, {athlete_climb_log: athlete_climb_log_attribs}
          expect(response).to redirect_to AthleteClimbLog.last
        end
        it 'displays a flash message' do
          post :create, {athlete_climb_log: athlete_climb_log_attribs}
          expect(flash[:notice]).to eq 'Athlete climb log was successfully created.'
        end
      end

    end
  end
end
