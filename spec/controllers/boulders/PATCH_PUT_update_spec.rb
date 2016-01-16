require 'rails_helper'
require 'shared_examples/action_not_authorized'

describe BouldersController do
  [:patch, :put].each do |http_method|
    describe "#{http_method.upcase} #update" do

      context "when the user does not own the boulder problem" do
        let(:boulder) { build_stubbed(:boulder) }

        before :each do
          allow(Boulder).to receive(:find) { boulder }
        end

        context "and the user is a setter" do
          define_roles(:setter)
          login_user(:setter_user)
          
          it_behaves_like "a request for a unauthorized action" do
            let(:http_request_proc) { Proc.new { method(http_method).call :update, id: boulder.id, boulder: attributes_for(:boulder) } }
          end
        end

        context "and the user is not a setter" do
          login_user
          it_behaves_like "a request for a unauthorized action" do
            let(:http_request_proc) { Proc.new { method(http_method).call :update, id: boulder.id, boulder: attributes_for(:boulder) } }
          end
        end

      end

      context "when the user owns the boulder problem" do
        define_roles(:setter)
        login_user(:setter_user)
        let(:boulder) { current_user.setter_story.boulders.create(attributes_for(:boulder)) }

        before :each do
          method(http_method).call :update, id: boulder.id, boulder: {name: 'Updated Name', grade: 'VB'}
        end

        it 'persists the updates in the database' do
          boulder.reload
          expect(boulder.name).to eq 'Updated Name'
          expect(boulder.grade).to eq 'VB'
        end
        it 'redirects to the :show template' do
          expect(response).to redirect_to boulder_path(boulder)
        end
        it 'displays a flash message' do
          expect(flash[:notice]).to eq "Boulder was successfully updated."
        end
      end

    end
  end
end
