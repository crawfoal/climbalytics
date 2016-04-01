require "main_suite_helper"

RSpec.describe UsersController, 'routing' do
  it 'routes to #edit' do
    expect(get: '/user/edit').to route_to 'users#edit'
  end

  it 'routes to #update via PUT' do
    expect(put: '/user').to route_to 'users#update'
  end

  it 'routes to #update via PATCH' do
    expect(patch: '/user').to route_to 'users#update'
  end
end
