Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 15 # instead of default of 60
  Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile, http_client: client)
end

require 'rspec/retry'

RSpec.configure do |config|
  config.verbose_retry = true # show retry status in spec process
  config.default_retry_count = 20
  config.exceptions_to_retry = [Net::ReadTimeout] # only retry if this exception was thrown
end
