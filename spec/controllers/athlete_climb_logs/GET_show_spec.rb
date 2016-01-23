require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/request_that_sets_instance_var_and_renders_template.rb'

describe AthleteClimbLogsController do
  describe "GET #show" do
    let(:athlete_climb_log) { build_stubbed(:athlete_climb_log) }

    before :each do
      allow(AthleteClimbLog).to receive(:find) { athlete_climb_log }
    end

    context 'for a logged in user' do

      context 'without a role of athlete' do
        login_user

        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { get :show, id: athlete_climb_log.id } }
        end
      end

      context 'with a role of athlete' do
        login_user(:athlete_user)

        context 'who owns the athlete_climb_log' do
          let(:athlete_climb_log) { current_user.athlete_story.athlete_climb_logs.create(attributes_for(:athlete_climb_log)) }

          it_behaves_like 'a request that sets an instance variable and renders a template', :athlete_climb_log, :show do
            let(:http_request_proc) { Proc.new { get :show, id: athlete_climb_log.id } }
          end
        end

        context 'who does not own the athlete_climb_log', :focus do
          it_behaves_like 'a request for a unauthorized action' do
            let(:http_request_proc) { Proc.new { get :show, id: athlete_climb_log.id } }
          end
        end

      end

    end

  end
end
