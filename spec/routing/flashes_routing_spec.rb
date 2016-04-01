require "main_suite_helper"

RSpec.describe FlashesController, 'routing' do
  it 'routes to #show' do
    expect(get: '/flash').to route_to 'flashes#show'
  end
end
