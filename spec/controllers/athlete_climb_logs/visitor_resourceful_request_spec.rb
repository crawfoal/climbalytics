require 'rails_helper'
require 'shared_examples/visitor_resourceful_request'

describe AthleteClimbLogsController do
  it_behaves_like 'a controller that requires user authentication for resourceful, CRUD actions', :setter_climb_log
end
