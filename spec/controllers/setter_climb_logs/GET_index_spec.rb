require 'rails_helper'

describe SetterClimbLogsController do
  describe 'GET #index' do
    let(:setter_climb_logs) { build_stubbed_list(:setter_climb_log, 3) }

    before :each do
      allow(SetterClimbLog).to receive(:all) { setter_climb_logs }
    end

    context 'for a logged in user' do
      login_user

      before :each do
        get :index
      end

      it 'populates an array of all setter_climb_logs' do
        expect(assigns(:setter_climb_logs)).to eq(setter_climb_logs)
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end
  end
end
