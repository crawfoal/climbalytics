require "main_suite_helper"

RSpec.describe HomeController, 'routing' do
  it 'routes to #show' do
    expect(get: '/').to route_to 'home#show'
  end
end
