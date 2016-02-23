RSpec.configure do |config|
  config.before(:all, :transaction_group) do
    DatabaseCleaner.strategy = :transaction
    print_status_message "opening transaction for `before :all` hook".light_yellow
    DatabaseCleaner.start
  end

  config.after(:all, :transaction_group) do
    print_status_message "rolling back transaction opened in `before :all` hook".light_yellow
    DatabaseCleaner.clean
  end
end
