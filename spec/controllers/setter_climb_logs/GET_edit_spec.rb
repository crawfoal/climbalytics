require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/request_that_sets_instance_var_and_renders_template.rb'

describe SetterClimbLogsController do
  describe 'GET #edit' do

    context 'when the user does not own the setter_climb_log' do
      let(:setter_climb_log) { build_stubbed(:setter_climb_log) }

      before :each do
        allow(SetterClimbLog).to receive(:find) { setter_climb_log }
      end

      context 'and the user is not a setter' do
        login_user
        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { get :edit, id: setter_climb_log.id } }
        end
      end

      context 'and the user is a setter' do
        login_user(:setter_user)

        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { get :edit, id: setter_climb_log.id } }
        end
      end
    end

    context 'when the user owns the setter_climb_log' do
      login_user(:setter_user)
      let(:setter_climb_log) { current_user.setter_story.setter_climb_logs.create(attributes_for(:setter_climb_log)) }

      it_behaves_like 'a request that sets an instance variable and renders a template', :setter_climb_log, :edit do
        let(:http_request_proc) { Proc.new { get :edit, id: setter_climb_log.id } }
      end
    end

  end
end
