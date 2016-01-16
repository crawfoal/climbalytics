require 'rails_helper'
require 'shared_examples/visitor_resourceful_request'

describe BouldersController do
  it_behaves_like 'a controller that has resourceful routes that requires user authentication', :boulder
end
