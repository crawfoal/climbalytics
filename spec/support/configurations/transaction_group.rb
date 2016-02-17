RSpec.configure do |config|
  config.before(:all, :transaction_group) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:all, :transaction_group) do
    DatabaseCleaner.clean
  end
end
