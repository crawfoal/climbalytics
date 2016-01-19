require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe BoulderLogsController do
  [:patch, :put].each do |http_method|
    describe "#{http_method.upcase} #update" do
      context 'for a logged in user' do
        let(:boulder_log) { build_stubbed(:boulder_log) }

        context 'without a role of athlete' do
          login_user
          before :each do
            allow(BoulderLog).to receive(:find).and_return(boulder_log)
          end

          it_behaves_like 'a request for a unauthorized action' do
            let(:http_request_proc) { Proc.new { method(http_method).call :update, id: boulder_log.id, boulder_log: attributes_for(:boulder_log) } }
          end
        end

        context 'with a role of athlete' do
          login_user(:athlete_user)

          context 'who owns the boulder log' do

            let(:boulder_log) { current_user.athlete_story.boulder_logs.create(attributes_for(:boulder_log)) }
            before :each do
              method(http_method).call :update, id: boulder_log.id, boulder_log: {quality_rating: 5, note: 'Updated note.'}
            end

            it 'persists the updates in the database' do
              boulder_log.reload
              expect(boulder_log.quality_rating).to eq 5
              expect(boulder_log.note).to eq 'Updated note.'
            end
            it 'redirects to the :show template' do
              expect(response).to redirect_to boulder_log_path(boulder_log)
            end
            it 'displays a flash message' do
              expect(flash[:notice]).to eq "Boulder log was successfully updated."
            end
          end

          context 'who does not own the boulder log' do
            before :each do
              allow(BoulderLog).to receive(:find).and_return(boulder_log)
            end

            it_behaves_like 'a request for a unauthorized action' do
              let(:http_request_proc) { Proc.new { method(http_method).call :update, id: boulder_log.id, boulder_log: attributes_for(:boulder_log) } }
            end
          end

        end

      end
    end
  end
end
