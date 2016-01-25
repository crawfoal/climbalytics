require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/delete_request'

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

      it_behaves_like 'a basic delete request', {redirect_to: {action: :index}}, {notice: 'SetterClimbLog was successfully destroyed.'} do
        let(:record) { current_user.setter_story.setter_climb_logs.create(attributes_for(:setter_climb_log)) }
      end
    end

  end
end
