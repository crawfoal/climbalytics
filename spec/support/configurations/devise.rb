require 'devise'

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :helper
  config.extend ControllerMacros, type: :helper
  config.extend ControllerMacros, type: :controller
  config.include Devise::TestHelpers, type: :view
end
