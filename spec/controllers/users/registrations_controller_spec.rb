require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do

  context 'JSON format' do
    describe '#update' do
      context 'for a logged in user' do
        login_user

        context 'with just a lat and long given' do
          before :each do
            patch 'update', user: {current_location_attributes: {latitude: 47.627710799999996, longitude: -117.66227529999999}}, format: :json
          end

          it 'should have a successful response' do
            message = "expected response to be a success, but it had code #{response.status}"
            expect(response).to be_success, message
          end

          it "should update the user's current location" do
            expect(User.first.current_location.latitude).to be_a Float
          end
        end
      end
    end
  end

end
