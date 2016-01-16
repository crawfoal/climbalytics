require 'rails_helper'
require 'shared_examples/request_that_sets_instance_var_and_renders_template.rb'

describe BouldersController do
  describe "GET #show" do
    let(:boulder) { build_stubbed(:boulder) }

    before :each do
      allow(Boulder).to receive(:find) { boulder }
    end

    context 'for a logged in user' do
      login_user

      it_behaves_like 'a request that sets an instance variable and renders a template', :boulder, :show do
        let(:http_request_proc) { Proc.new { get :show, id: boulder.id } }
      end
    end

  end
end
