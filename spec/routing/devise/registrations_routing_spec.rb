require "main_suite_helper"

RSpec.describe Devise::RegistrationsController, 'routing' do
  it 'routes to #create' do
    expect(post: '/user_accounts').to route_to 'devise/registrations#create'
  end
end
