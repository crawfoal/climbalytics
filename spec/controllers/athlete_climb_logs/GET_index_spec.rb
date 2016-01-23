require 'rails_helper'

describe AthleteClimbLogsController do
  describe 'GET #index' do
    let(:athlete_climb_logs) { build_stubbed_list(:athlete_climb_log, 3) }

    before :each do
      allow(AthleteClimbLog).to receive(:all) { athlete_climb_logs }
    end

    context 'for a logged in user' do
      login_user

      before :each do
        get :index
      end

      it 'populates an array of all athlete_climb_logs' do
        expect(assigns(:athlete_climb_logs)).to eq(athlete_climb_logs)
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end
  end
end
