require 'rails_helper'

describe AthleteClimbLogsController do
  describe 'POST #new' do
    let(:http_request_proc) { proc { post :new, params } }

    context 'valid attributes, use has a role of athlete' do
      login_user(:athlete)

      let(:ww) { create :wild_walls }
      let(:slog) { create :setter_climb_log }
      let(:params) { {athlete_climb_log: {setter_climb_log_id: slog.id, climb_attributes: {gym_section_id: ww.sections.sample.id}}} }

      it 'should set the gym_section_id to the param value' do
        http_request_proc.call
        expect(assigns[:athlete_climb_log].climb.gym_section_id).to be == params[:athlete_climb_log][:climb_attributes][:gym_section_id]
      end

      it 'should set the setter_climb_log_id to the param value' do
        http_request_proc.call
        expect(assigns[:athlete_climb_log].setter_climb_log).to be == slog
      end
    end
  end
end
