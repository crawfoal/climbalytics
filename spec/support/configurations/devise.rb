require 'devise'

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :helper
  config.include Devise::TestHelpers, type: :view
end
