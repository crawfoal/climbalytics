require 'rails_helper'

describe BouldersController do
  describe 'GET #index' do
    let(:boulders) { build_stubbed_list(:boulder, 3) }

    before :each do
      allow(Boulder).to receive(:all) { boulders }
    end

    context 'for a logged in user' do
      login_user

      before :each do
        get :index
      end

      it 'populates an array of all boulders' do
        expect(assigns(:boulders)).to eq(boulders)
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end
  end
end
