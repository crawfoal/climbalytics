require "main_suite_helper"

RSpec.describe ClimbsController, 'routing' do
  it 'routes to #index' do
    expect(get: '/climbs').to route_to 'climbs#index'
  end
end
