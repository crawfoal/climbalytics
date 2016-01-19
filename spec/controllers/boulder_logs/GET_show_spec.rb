require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/request_that_sets_instance_var_and_renders_template.rb'

describe BoulderLogsController do
  describe "GET #show" do
    let(:boulder_log) { build_stubbed(:boulder_log) }

    before :each do
      allow(BoulderLog).to receive(:find) { boulder_log }
    end

    context 'for a logged in user' do

      context 'without a role of athlete' do
        login_user

        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { get :show, id: boulder_log.id } }
        end
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        context 'who owns the boulder log' do
          let(:boulder_log) { current_user.athlete_story.boulder_logs.create(attributes_for(:boulder_log)) }

          it_behaves_like 'a request that sets an instance variable and renders a template', :boulder_log, :show do
            let(:http_request_proc) { Proc.new { get :show, id: boulder_log.id } }
          end
        end

        context 'who does not own the boulder log', :focus do
          it_behaves_like 'a request for a unauthorized action' do
            let(:http_request_proc) { Proc.new { get :show, id: boulder_log.id } }
          end
        end

      end

    end

  end
end
