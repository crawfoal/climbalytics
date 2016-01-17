require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe BouldersController do
  describe "DELETE #destroy" do

    context 'when the user does not own the boulder problem' do
      let(:boulder) { build_stubbed(:boulder) }

      before :each do
        allow(Boulder).to receive(:find) { boulder }
      end

      context 'and the user is a setter' do
        login_user(:setter_user)

        it_behaves_like "a request for a unauthorized action" do
          let(:http_request_proc) { Proc.new { delete :destroy, id: boulder.id } }
        end
      end

      context 'and the user is not a setter' do
        login_user

        it_behaves_like "a request for a unauthorized action" do
          let(:http_request_proc) { Proc.new { delete :destroy, id: boulder.id } }
        end
      end

    end

    context 'when the user owns the boulder problem' do
      login_user(:setter_user)
      let(:boulder) { current_user.setter_story.boulders.create(attributes_for(:boulder)) }

      it 'deletes the boulder from the database' do
        boulder # lazy evaluation causes this test to fail if the boulder isn't created before the proc below is evaluated
        expect { delete :destroy, id: boulder.id }.to change(Boulder, :count).by(-1)
      end
      it 'redirects to the boulders index' do
        delete :destroy, id: boulder.id
        expect(response).to redirect_to boulders_path
      end
      it 'displays a flash message' do
        delete :destroy, id: boulder.id
        expect(flash[:notice]).to eq 'Boulder was successfully destroyed.'
      end
    end

  end
end
