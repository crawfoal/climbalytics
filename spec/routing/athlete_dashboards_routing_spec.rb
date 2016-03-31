require "rails_helper"

RSpec.describe AthleteDashboardsController, 'routing' do
  it 'routes to #show' do
    expect(get: '/athlete_dashboard').to route_to 'athlete_dashboards#show'
  end
end
