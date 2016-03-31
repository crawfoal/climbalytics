require "rails_helper"

RSpec.describe ClimbPickersController, 'routing' do
  it 'routes to #show' do
    expect(get: '/climb_pickers/1').to route_to 'climb_pickers#show', id: '1'
  end
end
