require 'rails_helper'

describe BoulderLogsController do
  describe 'GET #index' do
    let(:boulder_logs) { build_stubbed_list(:boulder_log, 3) }

    before :each do
      allow(BoulderLog).to receive(:all) { boulder_logs }
    end

    context 'for a logged in user' do
      login_user

      before :each do
        get :index
      end

      it 'populates an array of all boulder logs' do
        expect(assigns(:boulder_logs)).to eq(boulder_logs)
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end
  end
end
