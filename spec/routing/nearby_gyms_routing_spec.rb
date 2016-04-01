require "main_suite_helper"

RSpec.describe NearbyGymsController, 'routing' do
  it 'routes to #show' do
    expect(get: '/nearby_gyms').to route_to 'nearby_gyms#show'
  end
end
