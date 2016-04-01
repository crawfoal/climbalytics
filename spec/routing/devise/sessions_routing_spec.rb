require "main_suite_helper"

RSpec.describe Devise::SessionsController, 'routing' do
  it 'routes to #create' do
    expect(post: '/sign_in').to route_to 'devise/sessions#create'
  end

  it 'routes to #destroy' do
    expect(delete: '/sign_out').to route_to 'devise/sessions#destroy'
  end
end
