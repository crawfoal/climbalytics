require "rails_helper"
require 'shared_examples/action_not_authorized'

# ToDo: I could stub SetterClimbLog.new and SetterClimbLog#save to speed things up here.

describe SetterClimbLogsController do
  describe 'POST #create' do
    let(:setter_climb_log_attribs) { attributes_for(:setter_climb_log) }

    context 'for a logged in non-setter user' do
      login_user
      it_behaves_like 'a request for a unauthorized action' do
        let(:http_request_proc) { Proc.new { post :create, {setter_climb_log: setter_climb_log_attribs} } }
      end
    end

    context 'for a logged in setter' do
      login_user(:setter_user)

      context 'and with valid setter_climb_log attributes' do
        it 'creates a new setter_climb_log' do
          expect { post :create, {setter_climb_log: setter_climb_log_attribs} }.to change {SetterClimbLog.count}.by(1)
        end
        it 'associates the setter_climb_log with the setter' do
          expect { post :create, {setter_climb_log: setter_climb_log_attribs} }.to change {current_user.setter_story.setter_climb_logs.count}.by(1)
        end
        it 'redirects to :show' do
          post :create, {setter_climb_log: setter_climb_log_attribs}
          expect(response).to redirect_to SetterClimbLog.last
        end
        it 'displays a flash message' do
          post :create, {setter_climb_log: setter_climb_log_attribs}
          expect(flash[:notice]).to eq 'SetterClimbLog was successfully created.'
        end
      end
    end

  end
end
