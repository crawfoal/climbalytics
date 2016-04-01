require "main_suite_helper"

describe AthleteClimbLogsController do
  login_user(:athlete)

  describe 'GET #new' do
    context 'with no preset attributes for the climb record' do
      it 'builds an empty climb record' do
        get :new

        expect(assigns(:athlete_climb_log).climb.value_attributes.compact).to be_empty
      end
    end
  end

  describe 'POST #new' do
    context 'with attributes specified through the athlete_climb_log hash' do
      it 'builds a climb record with the specified attributes' do
        params = {athlete_climb_log: {climb_attributes: {'gym_section_id' => create(:gym_section).id}}}
        get :new, params

        expect(assigns(:athlete_climb_log).climb.attributes).to include params[:athlete_climb_log][:climb_attributes]
      end
    end
  end
end
