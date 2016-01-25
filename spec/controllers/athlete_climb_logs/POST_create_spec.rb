require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/create_request'

describe AthleteClimbLogsController do
  describe 'POST #create' do
    let(:athlete_climb_log_attribs) { attributes_for(:athlete_climb_log) }
    let(:http_request_proc) { Proc.new { post :create, {athlete_climb_log: athlete_climb_log_attribs} } }

    context 'for a logged in user' do

      context 'without a role of athlete' do
        login_user
        it_behaves_like 'a request for a unauthorized action'
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        it_behaves_like 'a basic create request', :athlete_climb_log, {redirect_to: -> {AthleteClimbLog.last}}, {notice: 'Athlete climb log was successfully created.'}

        it 'associates the log with the athlete' do
          expect { post :create, {athlete_climb_log: athlete_climb_log_attribs} }.to change {current_user.athlete_story.athlete_climb_logs.count}.by(1)
        end
      end

    end
  end
end
