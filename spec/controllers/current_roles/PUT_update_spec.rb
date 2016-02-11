require 'rails_helper'
require 'shared_examples/action_not_authorized'
require 'shared_examples/update_request'

describe CurrentRolesController do
  describe "PUT #update" do
    context 'for a logged in user' do
      context 'with a role of setter' do
        login_user(:setter_user)
        let(:http_request_proc) { Proc.new { put :update, user: {current_role: 'athlete'} } }

        before :each do
          current_user.add_role :athlete
          http_request_proc.call
        end

        it "updates the current user's current role" do
          expect(current_user.reload.current_role).to eq 'athlete'
        end
        it "redirects the user to the root path" do
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
