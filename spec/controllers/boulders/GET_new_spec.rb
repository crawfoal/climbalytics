require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe BouldersController do
  describe 'GET #new' do

    context 'for a logged in non-setter' do
      login_user
      it_behaves_like 'a request for a unauthorized action' do
        let(:http_request_proc) { Proc.new { get :new } }
      end
    end

    context 'for a logged in setter' do
      login_user(:setter_user)

      before :each do
        get :new
      end

      it 'builds a new boulder' do
        expect(assigns(:boulder)).to be_a_new(Boulder)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

  end
end
