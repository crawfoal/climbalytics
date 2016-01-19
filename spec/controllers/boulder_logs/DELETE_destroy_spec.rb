require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe BoulderLogsController do
  describe 'DELETE #destroy' do
    context 'for a logged in user' do
      let(:boulder_log) { build_stubbed(:boulder_log) }

      context 'without a role of athlete' do
        login_user
        before :each do
          allow(BoulderLog).to receive(:find).and_return(boulder_log)
        end

        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { delete :destroy, id: boulder_log.id } }
        end
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        context 'who owns the boulder log' do

          let(:boulder_log) { current_user.athlete_story.boulder_logs.create(attributes_for(:boulder_log)) }

          it 'deletes the boulder log from the database' do
            boulder_log
            expect { delete :destroy, id: boulder_log.id }.to change(BoulderLog, :count).by(-1)
          end
          it 'redirects to the boulder logs index' do
            delete :destroy, id: boulder_log.id
            expect(response).to redirect_to boulder_logs_path
          end
          it 'displays a flash message' do
            delete :destroy, id: boulder_log.id
            expect(flash[:notice]).to eq 'Boulder log was successfully destroyed.'
          end
        end

        context 'who does not own the boulder log' do
          before :each do
            allow(BoulderLog).to receive(:find).and_return(boulder_log)
          end

          it_behaves_like 'a request for a unauthorized action' do
            let(:http_request_proc) { Proc.new { delete :destroy, id: boulder_log.id } }
          end
        end

      end

    end
  end
end
