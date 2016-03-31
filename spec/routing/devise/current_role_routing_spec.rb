require "rails_helper"

RSpec.describe CurrentRolesController, 'routing' do
  it 'routes to #update' do
    expect(patch: '/current_role').to route_to 'current_roles#update'
  end
end
