RSpec.configure do |config|
  config.include RoleHelper
  include RoleHelper

  # The roles are defined in the before :suite hook in main_suite_helper.rb, so that we can be sure that it creates the records after DatabaseCleaner truncates all tables.

  config.after(:suite) do
    undefine_roles(:setter,:athlete)
  end

end
