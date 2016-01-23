require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe SetterClimbLogsController do
  [:patch, :put].each do |http_method|
    describe "#{http_method.upcase} #update" do

      context "when the user does not own the setter_climb_log" do
        let(:setter_climb_log) { build_stubbed(:setter_climb_log) }

        before :each do
          allow(SetterClimbLog).to receive(:find) { setter_climb_log }
        end

        context "and the user is a setter" do
          login_user(:setter_user)

          it_behaves_like "a request for a unauthorized action" do
            let(:http_request_proc) { Proc.new { method(http_method).call :update, id: setter_climb_log.id, setter_climb_log: attributes_for(:setter_climb_log) } }
          end
        end

        context "and the user is not a setter" do
          login_user
          it_behaves_like "a request for a unauthorized action" do
            let(:http_request_proc) { Proc.new { method(http_method).call :update, id: setter_climb_log.id, setter_climb_log: attributes_for(:setter_climb_log) } }
          end
        end

      end

      context "when the user owns the setter_climb_log" do
        login_user(:setter_user)
        let(:setter_climb_log) { current_user.setter_story.setter_climb_logs.create(attributes_for(:setter_climb_log)) }

        before :each do
          setter_climb_log # instantiate, save to database
          setter_climb_log.touch # update
          method(http_method).call :update, id: setter_climb_log.id, setter_climb_log: setter_climb_log.attributes
        end

        it 'persists the updates in the database'
        it 'redirects to the :show template' do
          expect(response).to redirect_to setter_climb_log_path(setter_climb_log)
        end
        it 'displays a flash message' do
          expect(flash[:notice]).to eq "SetterClimbLog was successfully updated."
        end
      end

    end
  end
end
