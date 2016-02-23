require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/edit_request'

describe SetterClimbLogsController do
  describe 'GET #edit' do
    let(:http_request_proc) { Proc.new { get :edit, id: setter_climb_log.id } }

    context 'when the user does not own the setter_climb_log' do
      let(:setter_climb_log) { create(:setter_climb_log) }

      context 'and the user is not a setter' do
        login_user
        it_behaves_like 'a request for a unauthorized action', :http_request_proc
      end

      context 'and the user is a setter' do
        login_user(:setter)

        it_behaves_like 'a request for a unauthorized action', :http_request_proc
      end
    end

    context 'when the user owns the setter_climb_log' do
      login_user(:setter)
      let(:setter_climb_log) { current_user.setter_story.setter_climb_logs.create(attributes_for(:setter_climb_log)) }

      it_behaves_like 'a basic edit request', :setter_climb_log
    end

  end
end
