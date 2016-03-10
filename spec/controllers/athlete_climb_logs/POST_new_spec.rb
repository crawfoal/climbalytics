require 'rails_helper'

describe AthleteClimbLogsController do
  describe 'POST #new' do
    let(:http_request_proc) { proc { post :new, params } }

    context 'valid attributes, use has a role of athlete' do
      login_user(:athlete)

      before :each do
        create :wild_walls
      end
      let(:params) { {athlete_climb_log: {climb_attributes: {gym_section_id: Gym.last.sections.sample.id}}} }

      it 'should set the gym_section_id to the param value' do
        http_request_proc.call
        expect(assigns[:athlete_climb_log].climb.gym_section_id).to be == params[:athlete_climb_log][:climb_attributes][:gym_section_id]
      end
    end
  end
end
