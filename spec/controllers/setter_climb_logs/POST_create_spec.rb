require "rails_helper"
require 'shared_examples/action_not_authorized'
require 'shared_examples/create_request'

describe SetterClimbLogsController do
  describe 'POST #create' do
    let(:setter_climb_log_attribs) { attributes_for(:setter_climb_log) }
    let(:http_request_proc) { Proc.new { post :create, {setter_climb_log: setter_climb_log_attribs} } }

    context 'for a logged in non-setter user' do
      login_user
      it_behaves_like 'a request for a unauthorized action', :http_request_proc
    end

    context 'for a logged in setter' do
      login_user(:user, roles: [:setter])

      context 'and with valid setter_climb_log attributes' do

        it_behaves_like 'a basic create request', :setter_climb_log, :setter_climb_log_attribs, {redirect_to: -> {SetterClimbLog.last}}, {notice: 'SetterClimbLog was successfully created.'}

        it 'associates the setter_climb_log with the setter' do
          expect { http_request_proc.call }.to change {current_user.setter_story.setter_climb_logs.count}.by(1)
        end

      end
    end

  end
end
