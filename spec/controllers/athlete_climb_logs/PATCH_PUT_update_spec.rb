require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe AthleteClimbLogsController do
  [:patch, :put].each do |http_method|
    describe "#{http_method.upcase} #update" do
      context 'for a logged in user' do
        let(:athlete_climb_log) { build_stubbed(:athlete_climb_log) }

        context 'without a role of athlete' do
          login_user
          before :each do
            allow(AthleteClimbLog).to receive(:find).and_return(athlete_climb_log)
          end

          it_behaves_like 'a request for a unauthorized action' do
            let(:http_request_proc) { Proc.new { method(http_method).call :update, id: athlete_climb_log.id, athlete_climb_log: attributes_for(:athlete_climb_log) } }
          end
        end

        context 'with a role of athlete' do
          login_user(:athlete_user)

          context 'who owns the athlete_climb_log' do

            let(:athlete_climb_log) { current_user.athlete_story.athlete_climb_logs.create(attributes_for(:athlete_climb_log)) }
            before :each do
              method(http_method).call :update, id: athlete_climb_log.id, athlete_climb_log: {quality_rating: 5, note: 'Updated note.'}
            end

            it 'persists the updates in the database' do
              athlete_climb_log.reload
              expect(athlete_climb_log.quality_rating).to eq 5
              expect(athlete_climb_log.note).to eq 'Updated note.'
            end
            it 'redirects to the :show template' do
              expect(response).to redirect_to athlete_climb_log_path(athlete_climb_log)
            end
            it 'displays a flash message' do
              expect(flash[:notice]).to eq "Athlete climb log was successfully updated."
            end
          end

          context 'who does not own the athlete_climb_log' do
            before :each do
              allow(AthleteClimbLog).to receive(:find).and_return(athlete_climb_log)
            end

            it_behaves_like 'a request for a unauthorized action' do
              let(:http_request_proc) { Proc.new { method(http_method).call :update, id: athlete_climb_log.id, athlete_climb_log: attributes_for(:athlete_climb_log) } }
            end
          end

        end

      end
    end
  end
end
