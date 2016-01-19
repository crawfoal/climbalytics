require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/request_that_sets_instance_var_and_renders_template.rb'

describe BoulderLogsController do
  describe "GET #edit" do
    let(:boulder_log) { create(:boulder_log) }

    context 'for a logged in user' do

      context 'without a role of athlete' do
        login_user

        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { get :edit, id: boulder_log.id } }
        end
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        context 'who owns the boulder log' do
          let(:boulder_log) { current_user.athlete_story.boulder_logs.create(attributes_for(:boulder_log)) }

          it_behaves_like 'a request that sets an instance variable and renders a template', :boulder_log, :edit do
            let(:http_request_proc) { Proc.new { get :edit, id: boulder_log.id } }
          end
        end

        context 'who does not own the boulder log' do
          it_behaves_like 'a request for a unauthorized action' do
            let(:http_request_proc) { Proc.new { get :edit, id: boulder_log.id } }
          end
        end

      end

    end

  end
end
