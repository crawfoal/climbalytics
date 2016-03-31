require "rails_helper"

RSpec.describe SetterDashboardsController, 'routing' do
  it 'routes to #show' do
    expect(get: '/setter_dashboard').to route_to 'setter_dashboards#show'
  end
end
