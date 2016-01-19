require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe BoulderLogsController do
  describe 'POST #create' do
    let(:boulder_log_attribs) { attributes_for(:boulder_log) }

    context 'for a logged in user' do

      context 'without a role of athlete' do
        login_user

        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { post :create, {boulder_log: boulder_log_attribs} } }
        end
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        it 'creates a new boulder log' do
          expect { post :create, {boulder_log: boulder_log_attribs} }.to change {BoulderLog.count}.by(1)
        end
        it 'associates the log with the athlete' do
          expect { post :create, {boulder_log: boulder_log_attribs} }.to change {current_user.athlete_story.boulder_logs.count}.by(1)
        end
        it 'redirects to :show' do
          post :create, {boulder_log: boulder_log_attribs}
          expect(response).to redirect_to BoulderLog.last
        end
        it 'displays a flash message' do
          post :create, {boulder_log: boulder_log_attribs}
          expect(flash[:notice]).to eq 'Boulder log was successfully created.'
        end
      end

    end
  end
end
