Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

require 'rspec/retry'

RSpec.configure do |config|
  config.verbose_retry = true # show retry status in spec process
  config.exceptions_to_retry = [Net::ReadTimeout] # only retry if this exception was thrown

  config.around :each, :js do |ex|
    ex.run_with_retry retry: 2
  end
end
