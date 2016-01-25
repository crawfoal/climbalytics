require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/delete_request'

describe AthleteClimbLogsController do
  describe 'DELETE #destroy' do
    context 'for a logged in user' do
      let(:athlete_climb_log) { create(:athlete_climb_log) }
      let(:http_request_proc) { Proc.new { delete :destroy, id: athlete_climb_log.id } }

      context 'without a role of athlete' do
        login_user
        it_behaves_like 'a request for a unauthorized action'
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        context 'who owns the athlete_climb_log' do
          it_behaves_like 'a basic delete request', {redirect_to: {action: :index}}, {notice: 'Athlete climb log was successfully destroyed.'} do
            let(:record) { current_user.athlete_story.athlete_climb_logs.create(attributes_for(:athlete_climb_log)) }
          end
        end

        context 'who does not own the athlete_climb_log' do
          it_behaves_like 'a request for a unauthorized action'
        end

      end

    end
  end
end
