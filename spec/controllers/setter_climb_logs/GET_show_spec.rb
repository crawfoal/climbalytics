require 'rails_helper'
require 'shared_examples/request_that_sets_instance_var_and_renders_template.rb'

describe SetterClimbLogsController do
  describe "GET #show" do
    let(:setter_climb_log) { build_stubbed(:setter_climb_log) }

    before :each do
      allow(SetterClimbLog).to receive(:find) { setter_climb_log }
    end

    context 'for a logged in user' do
      login_user

      it_behaves_like 'a request that sets an instance variable and renders a template', :setter_climb_log, :show do
        let(:http_request_proc) { Proc.new { get :show, id: setter_climb_log.id } }
      end
    end

  end
end
