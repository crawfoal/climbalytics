require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/delete_request'

describe AthleteClimbLogsController do
  describe 'DELETE #destroy' do
    context 'for a logged in user' do
      let(:athlete_climb_log) { build_stubbed(:athlete_climb_log) }

      context 'without a role of athlete' do
        login_user
        before :each do
          allow(AthleteClimbLog).to receive(:find).and_return(athlete_climb_log)
        end

        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { delete :destroy, id: athlete_climb_log.id } }
        end
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        context 'who owns the athlete_climb_log' do
          it_behaves_like 'a basic delete request', {redirect_to: {action: :index}}, {notice: 'Athlete climb log was successfully destroyed.'} do
            let(:record) { current_user.athlete_story.athlete_climb_logs.create(attributes_for(:athlete_climb_log)) }
          end
        end

        context 'who does not own the athlete_climb_log' do
          before :each do
            allow(AthleteClimbLog).to receive(:find).and_return(athlete_climb_log)
          end

          it_behaves_like 'a request for a unauthorized action' do
            let(:http_request_proc) { Proc.new { delete :destroy, id: athlete_climb_log.id } }
          end
        end

      end

    end
  end
end
