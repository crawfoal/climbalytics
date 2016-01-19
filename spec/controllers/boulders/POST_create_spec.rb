require "rails_helper"
require 'shared_examples/action_not_authorized'

# ToDo: I could stub Boulder.new and Boulder#save to speed things up here.

describe BouldersController do
  describe 'POST #create' do
    let(:boulder_attribs) { attributes_for(:boulder) }

    context 'for a logged in non-setter user' do
      login_user
      it_behaves_like 'a request for a unauthorized action' do
        let(:http_request_proc) { Proc.new { post :create, {boulder: boulder_attribs} } }
      end
    end

    context 'for a logged in setter' do
      login_user(:setter_user)

      context 'and with valid boulder problem attributes' do
        it 'creates a new boulder' do
          expect { post :create, {boulder: boulder_attribs} }.to change {Boulder.count}.by(1)
        end
        it 'associates the boulder with the setter' do
          expect { post :create, {boulder: boulder_attribs} }.to change {current_user.setter_story.boulders.count}.by(1)
        end
        it 'redirects to :show' do
          post :create, {boulder: boulder_attribs}
          expect(response).to redirect_to Boulder.last
        end
        it 'displays a flash message' do
          post :create, {boulder: boulder_attribs}
          expect(flash[:notice]).to eq 'Boulder was successfully created.'
        end
      end
    end

  end
end
