require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe SetterClimbLogsController do
  describe "DELETE #destroy" do

    context 'when the user does not own the setter_climb_log' do
      let(:setter_climb_log) { build_stubbed(:setter_climb_log) }

      before :each do
        allow(SetterClimbLog).to receive(:find) { setter_climb_log }
      end

      context 'and the user is a setter' do
        login_user(:setter_user)

        it_behaves_like "a request for a unauthorized action" do
          let(:http_request_proc) { Proc.new { delete :destroy, id: setter_climb_log.id } }
        end
      end

      context 'and the user is not a setter' do
        login_user

        it_behaves_like "a request for a unauthorized action" do
          let(:http_request_proc) { Proc.new { delete :destroy, id: setter_climb_log.id } }
        end
      end

    end

    context 'when the user owns the setter_climb_log' do
      login_user(:setter_user)
      let(:setter_climb_log) { current_user.setter_story.setter_climb_logs.create(attributes_for(:setter_climb_log)) }

      it 'deletes the setter_climb_log from the database' do
        setter_climb_log # lazy evaluation causes this test to fail if the setter_climb_log isn't created before the proc below is evaluated
        expect { delete :destroy, id: setter_climb_log.id }.to change(SetterClimbLog, :count).by(-1)
      end
      it 'redirects to the setter_climb_logs index' do
        delete :destroy, id: setter_climb_log.id
        expect(response).to redirect_to setter_climb_logs_path
      end
      it 'displays a flash message' do
        delete :destroy, id: setter_climb_log.id
        expect(flash[:notice]).to eq 'SetterClimbLog was successfully destroyed.'
      end
    end

  end
end
