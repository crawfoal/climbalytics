require 'rails_helper'
require 'shared_examples/action_not_authorized'

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

          let(:athlete_climb_log) { current_user.athlete_story.athlete_climb_logs.create(attributes_for(:athlete_climb_log)) }

          it 'deletes the athlete_climb_log from the database' do
            athlete_climb_log
            expect { delete :destroy, id: athlete_climb_log.id }.to change(AthleteClimbLog, :count).by(-1)
          end
          it 'redirects to the athlete_climb_logs index' do
            delete :destroy, id: athlete_climb_log.id
            expect(response).to redirect_to athlete_climb_logs_path
          end
          it 'displays a flash message' do
            delete :destroy, id: athlete_climb_log.id
            expect(flash[:notice]).to eq 'Athlete climb log was successfully destroyed.'
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
