require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/request_that_sets_instance_var_and_renders_template.rb'

describe BouldersController do
  describe 'GET #edit' do

    context 'when the user does not own the boulder problem' do
      let(:boulder) { build_stubbed(:boulder) }

      before :each do
        allow(Boulder).to receive(:find) { boulder }
      end

      context 'and the user is not a setter' do
        login_user
        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { get :edit, id: boulder.id } }
        end
      end

      context 'and the user is a setter' do
        define_roles(:setter)
        login_user(:setter_user)

        it_behaves_like 'a request for a unauthorized action' do
          let(:http_request_proc) { Proc.new { get :edit, id: boulder.id } }
        end
      end
    end

    context 'when the user owns the boulder problem' do
      define_roles(:setter)
      login_user(:setter_user)
      let(:boulder) { current_user.setter_story.boulders.create(attributes_for(:boulder)) }

      it_behaves_like 'a request that sets an instance variable and renders a template', :boulder, :edit do
        let(:http_request_proc) { Proc.new { get :edit, id: boulder.id } }
      end
    end

  end
end
