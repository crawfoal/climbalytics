require 'rails_helper'
require 'shared_examples/visitor_resourceful_request'

describe SetterClimbLogsController do
  it_behaves_like 'a controller that has resourceful routes that requires user authentication', :setter_climb_log
end
